local BaseComponent = require("components.BaseComponent")

Mask = setmetatable({}, BaseComponent)
Mask.__index = Mask

function Mask:new(x, y, width, height)
    return BaseComponent.new(self, x, y, width, height)
end

function Mask:apply()
    love.graphics.setScissor(self.x, self.y, self.width, self.height)
end

function Mask:remove()
    love.graphics.setScissor()
end

return Mask