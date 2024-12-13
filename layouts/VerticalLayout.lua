-- VerticalLayout.lua
local BaseLayout = require("layouts.BaseLayout")

VerticalLayout = setmetatable({}, BaseLayout)
VerticalLayout.__index = VerticalLayout

function VerticalLayout:new(x, y, spacing,name)
    local layout = BaseLayout.new(self,name)
    layout.x = x
    layout.y = y
    layout.name = name or "VerticalLayout Layout"
    layout.spacing = spacing or 0
    return layout
end

function VerticalLayout:addComponent(component)
    table.insert(self.components, component)
end

function VerticalLayout:arrange()
    
    local currentY = self.y  -- 从布局的起始位置开始
    -- self:arrangeChild()
    -- for _, layout in ipairs(self.layouts) do
    --     currentY = currentY + layout.height + self.spacing
    -- end
    for _, component in ipairs(self.components) do
        component.x = self.x
        component.y = currentY
        currentY = currentY + component.height + self.spacing
    end
end

function VerticalLayout:draw()
    -- self:drawChild()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        component:draw()
        love.graphics.pop()
    end
end

return VerticalLayout