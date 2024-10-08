-- FixedLayout.lua

FixedLayout = {}
FixedLayout.__index = FixedLayout

function FixedLayout:new(name)
    local layout = setmetatable({}, FixedLayout)
    layout.name = name or "FixedLayout Layout"
    layout.components = {}
    layout.visible = true  -- 默认显示
    return layout
end

function FixedLayout:addComponent(component, x, y)
    component.x = x
    component.y = y
    table.insert(self.components, component)
end

function FixedLayout:draw()
    if not self.visible then return end  -- 如果不可见，则不绘制
    for _, component in ipairs(self.components) do
        component:draw()
    end
end

function FixedLayout:arrange()
    -- FixedLayout 不需要重新排列组件，因为它们的位置在添加时已经确定
end

return FixedLayout