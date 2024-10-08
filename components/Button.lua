-- Button.lua

local BaseComponent = require("components.BaseComponent")

Button = setmetatable({}, BaseComponent)
Button.__index = Button

function Button:new(x, y, width, height, label)
    local btn = BaseComponent.new(self, x, y, width, height)
    btn.label = label
    btn.hovered = false
    btn.pressed = false
    return btn
end

function Button:draw()
    if self.pressed then
        love.graphics.setColor(0.4, 0.4, 0.6)  -- 更深的蓝色表示按下状态
    elseif self.hovered then
        love.graphics.setColor(0.7, 0.7, 0.9)  -- 浅蓝色
    else
        love.graphics.setColor(0.5, 0.5, 0.7)  -- 深蓝色
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)  -- 圆角矩形
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.label, self.x, self.y + self.height / 2 - 6, self.width, "center")
    love.graphics.print(self.x, self.y, (self.width .. self.height))
end

function Button:update(dt,mx,my)
    self.hovered = self:isHovered(mx, my)
end

function Button:mousepressed(x, y, button, istouch, presses)
    if button == 1 and self.hovered then
        self.pressed = true
        print("Button " .. self.label .. " pressed!")
    end
end

function Button:mousereleased(x, y, button, istouch, presses)
    if button == 1 and self.pressed then
        self.pressed = false
        if self:isHovered(x, y) then
            print("Button " .. self.label .. " clicked!")
        end
    end
end

return Button