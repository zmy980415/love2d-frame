-- BaseComponent.lua

BaseComponent = {}
BaseComponent.__index = BaseComponent

function BaseComponent:new(x, y, width, height)
    local component = setmetatable({}, self)
    component.x = x
    component.y = y
    component.width = width
    component.height = height
    return component
end

function BaseComponent:isHovered(mx, my)
    return mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + self.height
end

return BaseComponent