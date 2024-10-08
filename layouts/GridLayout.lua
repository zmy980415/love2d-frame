-- GridLayout.lua

GridLayout = {}
GridLayout.__index = GridLayout

function GridLayout:new(x, y, cols, spacing)
    local layout = setmetatable({}, GridLayout)
    layout.x = x
    layout.y = y
    layout.cols = cols
    layout.name = name or "GridLayout Layout"
    layout.spacing = spacing or 0
    layout.components = {}
    return layout
end

function GridLayout:addComponent(component)
    table.insert(self.components, component)
end

function GridLayout:arrange()
    local currentX = self.x  -- 从布局的起始位置开始
    local currentY = self.y
    local colCount = 0

    for _, component in ipairs(self.components) do
        component.x = currentX
        component.y = currentY
        colCount = colCount + 1

        if colCount >= self.cols then
            colCount = 0
            currentX = self.x
            currentY = currentY + component.height + self.spacing
        else
            currentX = currentX + component.width + self.spacing
        end
    end
end

function GridLayout:draw()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        -- love.graphics.translate(component.x, component.y)
        component:draw()
        love.graphics.pop()
    end
end

return GridLayout