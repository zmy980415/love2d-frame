-- EditBox.lua

local BaseComponent = require("components.BaseComponent")

EditBox = setmetatable({}, BaseComponent)
EditBox.__index = EditBox

function EditBox:new(x, y, width, height)
    local eb = BaseComponent.new(self, x, y, width, height)
    eb.text = ""
    eb.isFocused = false
    eb.backgroundColor = {0.95, 0.95, 1}  -- 浅蓝色背景
    eb.cursorVisible = true
    eb.cursorTimer = 0
    eb.cursorPosition = 0
    eb.scrollOffset = 0
    eb.deleteTimer = 0
    eb.deleteSpeed = 0.3  -- 初始删除速度稍快
    eb.isSelected = false
    eb.lastClickTime = 0
    eb.selectionStart = 0
    eb.selectionEnd = 0
    return eb
end

function EditBox:draw()
    love.graphics.setColor(self.backgroundColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)  -- 圆角矩形

    love.graphics.setColor(0.7, 0.7, 0.9)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 5, 5)

    local displayText = self.text:sub(self.scrollOffset + 1)
    local textWidth = love.graphics.getFont():getWidth(displayText)

    -- 确保 selectionStart 和 selectionEnd 的顺序正确
    local selStart = math.min(self.selectionStart, self.selectionEnd)
    local selEnd = math.max(self.selectionStart, self.selectionEnd)

    -- 绘制选中文本背景
    if selStart ~= selEnd then
        local startX = self.x + 5 + love.graphics.getFont():getWidth(displayText:sub(1, selStart - self.scrollOffset))
        local endX = self.x + 5 + love.graphics.getFont():getWidth(displayText:sub(1, selEnd - self.scrollOffset))
        love.graphics.setColor(0.5, 0.5, 1, 0.5)  -- 半透明蓝色
        love.graphics.rectangle("fill", startX, self.y + 5, endX - startX, self.height - 10)
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(displayText, self.x + 5, self.y + self.height / 2 - 6, self.width - 10, "left")

    -- 绘制光标
    if self.isFocused and self.cursorVisible and not self.isSelected then
        local cursorX = self.x + 5 + love.graphics.getFont():getWidth(displayText:sub(1, self.cursorPosition - self.scrollOffset))
        love.graphics.line(cursorX, self.y + 5, cursorX, self.y + self.height - 5)
    end
end

function EditBox:update(dt)
    if self.isFocused then
        self.cursorTimer = self.cursorTimer + dt
        if self.cursorTimer >= 0.5 then
            self.cursorVisible = not self.cursorVisible
            self.cursorTimer = 0
        end

        if love.keyboard.isDown("backspace") then
            self.deleteTimer = self.deleteTimer + dt
            if self.deleteTimer >= self.deleteSpeed then
                self:deleteCharacter()
                self.deleteSpeed = math.max(0.03, self.deleteSpeed * 0.85)  -- 加快删除速度
                self.deleteTimer = 0
            end
        elseif love.keyboard.isDown("delete") then
            self.deleteTimer = self.deleteTimer + dt
            if self.deleteTimer >= self.deleteSpeed then
                self:deleteCharacterForward()
                self.deleteSpeed = math.max(0.03, self.deleteSpeed * 0.85)
                self.deleteTimer = 0
            end
        else
            self.deleteSpeed = 0.3
            self.deleteTimer = 0
        end
    end
end

function EditBox:textinput(t)
    if self.isFocused then
        if self.selectionStart ~= self.selectionEnd then
            self:deleteSelection()
        end
        local newText = self.text:sub(1, self.cursorPosition) .. t .. self.text:sub(self.cursorPosition + 1)
        local textWidth = love.graphics.getFont():getWidth(newText)
        if textWidth < self.width - 10 then  -- 确保文本不超出编辑框宽度
            self.text = newText:gsub("\n", "")

            self.cursorPosition = self.cursorPosition + 1
        else
            self.scrollOffset = self.scrollOffset + 1
            self.text = newText:gsub("\n", "")
            self.cursorPosition = self.cursorPosition + 1
        end
    end
end

function EditBox:keypressed(key)
    if self.isFocused then
        if key == "backspace" then
            self:deleteCharacter()
        elseif key == "delete" then
            self:deleteCharacterForward()
        elseif key == "left" then
            self.cursorPosition = math.max(0, self.cursorPosition - 1)
            if self.cursorPosition < self.scrollOffset then
                self.scrollOffset = self.scrollOffset - 1
            end
        elseif key == "right" then
            self.cursorPosition = math.min(#self.text, self.cursorPosition + 1)
            if self.cursorPosition > self.scrollOffset + self.width / 10 then
                self.scrollOffset = self.scrollOffset + 1
            end
        elseif key == "a" and love.keyboard.isDown("lctrl") then
            self.selectionStart = 0
            self.selectionEnd = #self.text
            self.cursorPosition = #self.text
        elseif key == "c" and love.keyboard.isDown("lctrl") then
            if self.selectionStart ~= self.selectionEnd then
                local selStart = math.min(self.selectionStart, self.selectionEnd)
                local selEnd = math.max(self.selectionStart, self.selectionEnd)
                love.system.setClipboardText(self.text:sub(selStart + 1, selEnd))
            end
        elseif key == "v" and love.keyboard.isDown("lctrl") then
            local clipboardText = love.system.getClipboardText()
            if clipboardText then
                local selStart = math.min(self.selectionStart, self.selectionEnd)
                local selEnd = math.max(self.selectionStart, self.selectionEnd)
                -- self:textinput(clipboardText)
                local txt = self.text:sub(1, self.cursorPosition) .. clipboardText
                self.text = txt .. self.text:sub(self.cursorPosition + 1)
                self.cursorPosition = #txt
                
            end
        end
    end
end

function EditBox:deleteCharacter()
    if self.selectionStart ~= self.selectionEnd then
        self:deleteSelection()
    elseif self.cursorPosition > 0 then
        self.text = self.text:sub(1, self.cursorPosition - 1) .. self.text:sub(self.cursorPosition + 1)
        self.cursorPosition = self.cursorPosition - 1
        if self.cursorPosition < self.scrollOffset then
            self.scrollOffset = self.scrollOffset - 1
        end
    end
end

function EditBox:deleteCharacterForward()
    if self.selectionStart ~= self.selectionEnd then
        self:deleteSelection()
    elseif self.cursorPosition < #self.text then
        self.text = self.text:sub(1, self.cursorPosition) .. self.text:sub(self.cursorPosition + 2)
    end
end

function EditBox:deleteSelection()
    local selStart = math.min(self.selectionStart, self.selectionEnd)
    local selEnd = math.max(self.selectionStart, self.selectionEnd)
    self.text = self.text:sub(1, selStart) .. self.text:sub(selEnd + 1)
    self.cursorPosition = selStart
    self.selectionStart = self.cursorPosition
    self.selectionEnd = self.cursorPosition
end

function EditBox:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local currentTime = love.timer.getTime()
        if currentTime - self.lastClickTime < 0.3 then
            self.selectionStart = 0
            self.selectionEnd = #self.text
            self.cursorPosition = #self.text
            self.scrollOffset = 0
        else
            self.isFocused = self:isHovered(x, y)
            if self.isFocused then
                local mx = x - self.x - 5
                local textWidth = 0
                for i = 1, #self.text do
                    textWidth = love.graphics.getFont():getWidth(self.text:sub(1, i))
                    if textWidth > mx then
                        self.cursorPosition = i - 1
                        break
                    end
                end
                if mx > textWidth then
                    self.cursorPosition = #self.text
                end
                self.selectionStart = self.cursorPosition
                self.selectionEnd = self.cursorPosition
            end
        end
        self.lastClickTime = currentTime
    end
end

function EditBox:mousemoved(x, y, dx, dy, istouch)
    if love.mouse.isDown(1)  then
        if self:isHovered(x, y) then
            self.isFocused = true
        else
            self.isFocused = false
        end
        if self.isFocused then
            local mx = x - self.x - 5
            local textWidth = 0
            for i = 1, #self.text do
                textWidth = love.graphics.getFont():getWidth(self.text:sub(1, i))
                if textWidth > mx then
                    self.cursorPosition = i - 1
                    break
                end
            end
            if mx > textWidth then
                self.cursorPosition = #self.text
            end
            self.selectionEnd = self.cursorPosition
        end
        
    end
end

return EditBox