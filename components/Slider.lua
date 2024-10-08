-- Slider.lua

local BaseComponent = require("components.BaseComponent")

Slider = setmetatable({}, BaseComponent)
Slider.__index = Slider

function Slider:new(x, y, width, height, minValue, maxValue)
    local slider = BaseComponent.new(self, x, y, width, height)
    slider.minValue = minValue
    slider.maxValue = maxValue
    slider.currentValue = minValue
    slider.isDragging = false
    return slider
end

function Slider:draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5, 5)
    love.graphics.setColor(0.2, 0.2, 0.8)
    local knobX = self.x + (self.currentValue - self.minValue) / (self.maxValue - self.minValue) * self.width
    love.graphics.rectangle("fill", knobX - 5, self.y, 10, self.height, 5, 5)
end

function Slider:mousepressed(x, y, button, istouch, presses)
    if button == 1 and self:isHovered(x, y) then
        self.isDragging = true
    end
end

function Slider:mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        self.isDragging = false
    end
end

function Slider:mousemoved(x, y, dx, dy, istouch)
    if self.isDragging then
        local newValue = self.minValue + (x - self.x) / self.width * (self.maxValue - self.minValue)
        self.currentValue = math.max(self.minValue, math.min(self.maxValue, newValue))
        print("Slider value: " .. self.currentValue)
    end
end

return Slider