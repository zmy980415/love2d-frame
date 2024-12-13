-- GridLayout.lua
local BaseLayout = require("layouts.BaseLayout")

GridLayout = setmetatable({}, BaseLayout)
GridLayout.__index = GridLayout

function GridLayout:new(x, y, cols, spacing,name,isAlignment)
    local layout = BaseLayout.new(self,name)
    layout.x = x
    layout.y = y
    layout.cols = cols
    layout.name = name or "GridLayout Layout"
    layout.spacing = spacing or 0
    layout.isAlignment = isAlignment or true -- 是否对齐
    return layout
end

function GridLayout:addComponent(component)
    table.insert(self.components, component)
end

function GridLayout:arrange()
    local currentX = self.x  -- 从布局的起始位置开始
    local currentY = self.y
    local colCount = 0
    -- self:arrangeChild()
    local maxWidth = 0
    local widthArr = {}
    local heightArr = {}
    if self.isAlignment then
        for _, component in ipairs(self.components) do
            component.x = currentX
            component.y = currentY
            colCount = colCount + 1
            widthArr["".. colCount] = math.max(component.width, widthArr["".. colCount] or 0)
            heightArr["".. colCount] = math.max(component.height, heightArr["".. colCount] or 0)
            if colCount >= self.cols then
                colCount = 0
            end
        end
    end
    for _, component in ipairs(self.components) do
        component.x = currentX
        component.y = currentY
        colCount = colCount + 1

        if self.isAlignment then
            if colCount >= self.cols then
                colCount = 0
                currentX = self.x
                currentY = currentY + heightArr["".. colCount+1] + self.spacing
            else
                currentX = currentX + widthArr["".. colCount] + self.spacing
            end
            
        else
            if colCount >= self.cols then
                colCount = 0
                currentX = self.x
                currentY = currentY + component.height + self.spacing
            else
                currentX = currentX + component.width + self.spacing
            end
        end
        
    end
end

function GridLayout:draw()
    -- self:drawChild()
    for _, component in ipairs(self.components) do
        love.graphics.push()
        -- love.graphics.translate(component.x, component.y)
        component:draw()
        love.graphics.pop()
    end
end

return GridLayout