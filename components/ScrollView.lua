-- ScrollView.lua

local BaseComponent = require("components.BaseComponent")

ScrollView = setmetatable({}, BaseComponent)
ScrollView.__index = ScrollView

function ScrollView:new(x, y, width, height, contentHeight)
    local sv = BaseComponent.new(self, x, y, width, height)
    sv.contentHeight = contentHeight
    sv.scrollY = 0
    return sv
end

function ScrollView:draw()
    love.graphics.setScissor(self.x, self.y, self.width, self.height)
    love.graphics.translate(0, -self.scrollY)
    -- 在这里绘制内容
    love.graphics.setScissor()
    love.graphics.origin()
end

function ScrollView:wheelmoved(x, y)
    self.scrollY = math.max(0, math.min(self.scrollY - y * 20, self.contentHeight - self.height))
end

function ScrollView:mousepressed(x, y, button, istouch, presses)
    -- 目前不需要处理鼠标按下事件，但方法必须存在
end

return ScrollView