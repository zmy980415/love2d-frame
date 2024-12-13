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
    self.canvas = love.graphics.newCanvas(win.width, win.height)
    return win
end

function Window:addComponent(component)
    table.insert(self.components, component)
end

function Window:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setCanvas(self.canvas)
    -- love.graphics.clear()
    -- 绘制窗口背景
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height, 5, 5)

    -- 绘制窗口标题栏
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", 0, 0, self.width, 30, 5, 5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.title, 0, 0 + 8, self.width, "center")

    -- 绘制窗口边框
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("line", 0, 0, self.width, self.height, 5, 5)

    -- 绘制窗口内的组件
    for _, component in ipairs(self.components) do
        love.graphics.push()
        love.graphics.translate(0, 0 + 30)  -- 确保组件在标题栏下方绘制
        component:draw()
        love.graphics.pop()
    end
    love.graphics.setCanvas()
    love.graphics.setColor(r, g, b, a)
    love.graphics.draw(self.canvas, self.x, self.y)
    love.graphics.setColor(r, g, b, a)
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

function Window:handleMouseEvent(event, x, y, ...)
    if event == "pressed" and self:isHovered(x, y) then
        if y < self.y + 30 then  -- 点击在标题栏上
            self.isDragging = true
            self.dragOffsetX = x - self.x
            self.dragOffsetY = y - self.y
        else
            self:dispatchEventToComponents("mouse" .. event, x, y, ...)
        end
    elseif event == "released" then
        self.isDragging = false
        self:dispatchEventToComponents("mouse" .. event, x, y, ...)
    elseif event == "moved" and self.isDragging then
        self.x = x - self.dragOffsetX
        self.y = y - self.dragOffsetY
    else
        self:dispatchEventToComponents("mouse" .. event, x, y, ...)
    end
end

function Window:dispatchEventToComponents(event, ...)
    local args = {...}
    for _, component in ipairs(self.components) do
        for __, uiComponent in ipairs(component.components) do
            if uiComponent[event] then
                if event:find("mouse") then
                    local x, y = args[1], args[2]
                    local localX, localY = x - self.x - component.x, y - self.y - component.y
                    uiComponent[event](uiComponent, localX, localY, select(3, ...))
                else
                    uiComponent[event](uiComponent, ...)
                end
            end
        end
    end
end

function Window:textinput(t)
    self:dispatchEventToComponents("textinput", t)
end

function Window:keypressed(key)
    self:dispatchEventToComponents("keypressed", key)
end

-- 添加默认的 Love2D 事件处理函数
function Window:mousepressed(x, y, button, istouch, presses)
    self:handleMouseEvent("pressed", x, y, button, istouch, presses)
end

function Window:mousereleased(x, y, button, istouch, presses)
    self:handleMouseEvent("released", x, y, button, istouch, presses)
end

function Window:mousemoved(x, y, dx, dy, istouch)
    self:handleMouseEvent("moved", x, y, dx, dy, istouch)
end

return Window