-- ToggleButton.lua

local BaseComponent = require("components.BaseComponent")

ToggleButton = setmetatable({}, BaseComponent)
ToggleButton.__index = ToggleButton

function ToggleButton:new(x, y, width, height, label)
    local btn = BaseComponent.new(self, x, y, width, height)
    btn.label = label
    btn.isToggled = false
    return btn
end

function ToggleButton:draw()
    if self.isToggled then
        love.graphics.setColor(0.3, 0.6, 0.3)  -- 绿色
    else
        love.graphics.setColor(0.6, 0.3, 0.3)  -- 红色
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.label, self.x, self.y + self.height / 2 - 6, self.width, "center")
end

function ToggleButton:mousepressed(x, y, button, istouch, presses)
    if button == 1 and self:isHovered(x, y) then
        self.isToggled = not self.isToggled
        print("ToggleButton " .. self.label .. " toggled to " .. tostring(self.isToggled))
    end
end

return ToggleButton