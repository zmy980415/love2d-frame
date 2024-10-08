-- Label.lua

local BaseComponent = require("components.BaseComponent")

Label = setmetatable({}, BaseComponent)
Label.__index = Label

function Label:new(x, y, text, fontSize)
    local lbl = BaseComponent.new(self, x, y, 0, 0)
    lbl.text = text
    lbl.fontSize = fontSize or 14
    lbl.font = love.graphics.newFont(lbl.fontSize)
    lbl.width = lbl.font:getWidth(text)
    lbl.height = lbl.font:getHeight()
    return lbl
end

function Label:draw()
    -- love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.text, self.x, self.y)
end

return Label