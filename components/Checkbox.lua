-- Checkbox.lua

local BaseComponent = require("components.BaseComponent")

Checkbox = setmetatable({}, BaseComponent)
Checkbox.__index = Checkbox

function Checkbox:new(x, y, size, label,fontSize)
    local cb = BaseComponent.new(self, x, y, size, size)
    cb.label = label
    cb.size = size
    cb.fontSize = fontSize or 14
    cb.font = love.graphics.newFont(cb.fontSize)
    cb.width = cb.font:getWidth(cb.label) + cb.size
    cb.height = cb.font:getHeight()
    cb.isChecked = false
    return cb
end

function Checkbox:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size, 5, 5)
    if self.isChecked then
        love.graphics.setColor(196/255, 246/255, 89/255)
        love.graphics.rectangle("fill", self.x + 2, self.y + 2, self.size - 4, self.size - 4, 5, 5)
    end
    love.graphics.setColor(1,1,1)
    love.graphics.printf(self.label, self.x + self.size + 5, self.y + self.size / 2 - 6, 100, "left")
end

function Checkbox:mousepressed(x, y, button, istouch, presses)
    if button == 1 and self:isHovered(x, y) then
        self.isChecked = not self.isChecked
        print("Checkbox " .. self.label .. " checked: " .. tostring(self.isChecked))
    end
end

return Checkbox