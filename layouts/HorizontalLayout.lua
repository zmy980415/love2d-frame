-- HorizontalLayout.lua

HorizontalLayout = {}
HorizontalLayout.__index = HorizontalLayout

function HorizontalLayout:new(x, y, spacing)
    local layout = setmetatable({}, HorizontalLayout)
    layout.x = x
    layout.y = y
    layout.name = name or "HorizontalLayout Layout"
    layout.spacing = spacing or 0
    layout.components = {}
    return layout
end

function HorizontalLayout:addComponent(component)
    table.insert(self.components, component)
end

function HorizontalLayout:arrange()
    local currentX = self.x  -- 从布局的起始位置开始
    for _, component in ipairs(self.components) do
        component.x = currentX
        component.y = self.y
        currentX = currentX + component.width + self.spacing
    end
end

function HorizontalLayout:draw()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        -- love.graphics.translate(component.x, component.y)
        component:draw()
        -- 显示组件坐标
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(string.format("(%d, %d)", component.x, component.y), component.x, component.y)
        love.graphics.pop()
    end
end

return HorizontalLayout