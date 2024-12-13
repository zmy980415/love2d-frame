-- BaseLayout.lua

BaseLayout = {}
BaseLayout.__index = BaseLayout

function BaseLayout:new(name)
    local layout = setmetatable({}, self)
    layout.x = 0
    layout.y = 0
    layout.name = "GridLayout Layout"
    layout.spacing =  0
    layout.components = {}
    -- layout.layouts = {}
    return layout
end

-- function BaseLayout:addLayout(layout)
--     table.insert(self.layouts, layout)
-- end

-- 暂时未能实现
-- function BaseLayout:arrangeChild()
--     print("arrangeChild")
--     print(#self.layouts)
--     for i, v in ipairs(self.layouts) do
--         v:arrange()
--     end
-- end

function BaseLayout:drawChild()
    
    for i, v in ipairs(self.layouts) do
        v:draw()
    end
end

return BaseLayout