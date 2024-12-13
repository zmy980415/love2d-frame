-- HorizontalLayout.lua
local BaseLayout = require("layouts.BaseLayout")

HorizontalLayout = setmetatable({}, BaseLayout)
HorizontalLayout.__index = HorizontalLayout

function HorizontalLayout:new(x, y, spacing,name)
    local layout = BaseLayout.new(self,name)
    layout.x = x
    layout.y = y
    layout.name = name or "HorizontalLayout Layout"
    layout.spacing = spacing or 0
    return layout
end

function HorizontalLayout:addComponent(component)
    table.insert(self.components, component)
end

function HorizontalLayout:arrange()
    
    local currentX = self.x  -- 从布局的起始位置开始
    -- self:arrangeChild()
    -- for _, layout in ipairs(self.layouts) do
    --     currentX = currentX + layout.width + self.spacing
    -- end
    for _, component in ipairs(self.components) do
        component.x = currentX
        component.y = self.y
        currentX = currentX + component.width + self.spacing
    end
end

function HorizontalLayout:draw()
    -- self:drawChild()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        component:draw()
        love.graphics.pop()
    end
end

return HorizontalLayout