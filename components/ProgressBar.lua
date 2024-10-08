-- ProgressBar.lua

local BaseComponent = require("components.BaseComponent")

ProgressBar = setmetatable({}, BaseComponent)
ProgressBar.__index = ProgressBar

function ProgressBar:new(x, y, width, height, maxValue)
    local pb = BaseComponent.new(self, x, y, width, height)
    pb.maxValue = maxValue
    pb.currentValue = 0
    return pb
end

function ProgressBar:setValue(value)
    self.currentValue = math.min(value, self.maxValue)
end

function ProgressBar:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 1, 0)
    local fillWidth = (self.currentValue / self.maxValue) * self.width
    love.graphics.rectangle("fill", self.x, self.y, fillWidth, self.height)
end

return ProgressBar