-- VerticalLayout.lua

VerticalLayout = {}
VerticalLayout.__index = VerticalLayout

function VerticalLayout:new(x, y, spacing)
    local layout = setmetatable({}, VerticalLayout)
    layout.x = x
    layout.y = y
    layout.name = name or "VerticalLayout Layout"
    layout.spacing = spacing or 0
    layout.components = {}
    return layout
end

function VerticalLayout:addComponent(component)
    table.insert(self.components, component)
end

function VerticalLayout:arrange()
    local currentY = self.y  -- 从布局的起始位置开始
    for _, component in ipairs(self.components) do
        component.x = self.x
        component.y = currentY
        currentY = currentY + component.height + self.spacing
    end
end

function VerticalLayout:draw()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        -- love.graphics.translate(component.x, component.y)
        component:draw()
        love.graphics.pop()
    end
end

return VerticalLayout