-- Window.lua

local BaseComponent = require("components.BaseComponent")

Window = setmetatable({}, BaseComponent)
Window.__index = Window

function Window:new(x, y, width, height, title)
    local win = BaseComponent.new(self, x, y, width, height)
    win.title = title
    win.isDragging = false
    win.dragOffsetX = 0
    win.dragOffsetY = 0
    win.components = {}
    return win
end

function Window:addComponent(component)
    table.insert(self.components, component)
end

function Window:draw()
    -- 绘制窗口背景
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)

    -- 绘制窗口标题栏
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", self.x, self.y, self.width, 30, 5, 5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.title, self.x, self.y + 8, self.width, "center")

    -- 绘制窗口边框
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 5, 5)

    -- 绘制窗口内的组件
    for _, component in ipairs(self.components) do
        love.graphics.push()
        love.graphics.translate(self.x, self.y + 30)  -- 确保组件在标题栏下方绘制
        component:draw()
        love.graphics.pop()
    end
end

-- 更新逻辑
function Window:update(dt)
    local x, y = love.mouse.getPosition()
    for _, component in ipairs(self.components) do
        for __, uiComponent in ipairs(component.components) do
            local localX, localY = x - self.x - component.x, y - self.y - component.y
            if uiComponent.update then
                uiComponent:update(dt, localX, localY)
            end
        end
    end
end

function Window:mousepressed(x, y, button, istouch, presses)
    if button == 1 and self:isHovered(x, y) then
        if y < self.y + 30 then  -- 点击在标题栏上
            self.isDragging = true
            self.dragOffsetX = x - self.x
            self.dragOffsetY = y - self.y
        else
            -- 传递事件给组件
            for _, component in ipairs(self.components) do
                for __, uiComponent in ipairs(component.components) do
                    local localX, localY = x - self.x - component.x, y - self.y - component.y
                    if uiComponent.mousepressed then
                        uiComponent:mousepressed(localX, localY, button, istouch, presses)
                    end
                end
            end
        end
    end
end

function Window:mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        self.isDragging = false
        -- 传递事件给组件
        for _, component in ipairs(self.components) do
            for __, uiComponent in ipairs(component.components) do
                local localX, localY = x - self.x - component.x, y - self.y - component.y
                if uiComponent.mousereleased then
                    uiComponent:mousereleased(localX, localY, button, istouch, presses)
                end
            end
        end
    end
end

function Window:mousemoved(x, y, dx, dy, istouch)
    if self.isDragging then
        self.x = x - self.dragOffsetX
        self.y = y - self.dragOffsetY
    else
        -- 传递事件给组件
        for _, component in ipairs(self.components) do
            for __, uiComponent in ipairs(component.components) do
                local localX, localY = x - self.x - component.x, y - self.y - component.y
                if uiComponent.mousemoved then
                    uiComponent:mousemoved(localX, localY, dx, dy, istouch)
                end
            end
        end
    end
end

function Window:textinput(t)
    for _, component in ipairs(self.components) do
        for _, uiComponent in ipairs(component.components) do
            if uiComponent.textinput then
                uiComponent:textinput(t)
            end
        end
    end
end

function Window:keypressed(key)
    for _, component in ipairs(self.components) do
        for _, uiComponent in ipairs(component.components) do
            if uiComponent.keypressed then
                uiComponent:keypressed(key)
            end
        end
    end
end

return Window