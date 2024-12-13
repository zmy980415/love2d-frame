-- FixedLayout.lua
local BaseLayout = require("layouts.BaseLayout")

FixedLayout = setmetatable({}, BaseLayout)
FixedLayout.__index = FixedLayout

function FixedLayout:new(name)
    local layout = BaseLayout.new(self,name)
    layout.name = name or "FixedLayout Layout"
    layout.visible = true  -- 默认显示
    return layout
end

function FixedLayout:addComponent(component, x, y)
    component.x = x
    component.y = y
    table.insert(self.components, component)
end

function FixedLayout:draw()
    -- self:drawChild()
    if not self.visible then return end  -- 如果不可见，则不绘制
    for _, component in ipairs(self.components) do
        component:draw()
    end
end

function FixedLayout:arrange()
    -- self:arrangeChild()
    -- FixedLayout 不需要重新排列组件，因为它们的位置在添加时已经确定
end

return FixedLayout