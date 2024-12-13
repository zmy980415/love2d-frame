-- GameScene.lua

local Button = require("components.Button")
local EditBox = require("components.EditBox")
local ToggleButton = require("components.ToggleButton")
local Slider = require("components.Slider")
local Checkbox = require("components.Checkbox")
local Label = require("components.Label")
local Window = require("components.Window")
local VerticalLayout = require("layouts.VerticalLayout")
local HorizontalLayout = require("layouts.HorizontalLayout")
local GridLayout = require("layouts.GridLayout")

local GameScene = {}

function GameScene:load()
    self.font = love.graphics.newFont("assets/fonts/simhei.ttf", 14)
    self.windows = {}

    -- 创建第一个窗口，使用 VerticalLayout
    local window1 = Window:new(100, 100, 300, 200, "Vertical Layout")
    local verticalLayout = VerticalLayout:new(0, 30, 10)
    local btn = Button:new(0, 0, 280, 30, "Button 1")
    btn.onClick = function()
        print("Button 1")
        
    end
    verticalLayout:addComponent(btn)
    verticalLayout:addComponent(EditBox:new(0, 0, 280, 30))
    verticalLayout:arrange()
    window1:addComponent(verticalLayout)
    table.insert(self.windows, window1)

    -- 创建第二个窗口，使用 HorizontalLayout
    local window2 = Window:new(450, 100, 300, 200, "Horizontal Layout")
    local horizontalLayout = HorizontalLayout:new(0, 30, 10)
    horizontalLayout:addComponent(ToggleButton:new(0, 0, 80, 30, "Toggle"))
    horizontalLayout:addComponent(Slider:new(0, 0, 150, 30, 0, 100))
    horizontalLayout:arrange()
    window2:addComponent(horizontalLayout)
    table.insert(self.windows, window2)

    -- 创建第三个窗口，使用 GridLayout
    local window3 = Window:new(100, 350, 300, 200, "Grid Layout")
    local gridLayout = GridLayout:new(0, 30, 2, 10)
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 1"))
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 2"))
    gridLayout:addComponent(Label:new(0, 0, "Label 1", 14))
    gridLayout:addComponent(Label:new(0, 0, "Label 2", 14))
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 1"))
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 2"))

    gridLayout:arrange()
    window3:addComponent(gridLayout)
    table.insert(self.windows, window3)
end

function GameScene:update(dt)
    for _, window in ipairs(self.windows) do
        window:update(dt)
    end
end

function GameScene:draw()
    love.graphics.clear(0.2, 0.3, 0.4)  -- 设置背景颜色为一种好看的蓝色
    love.graphics.setFont(self.font)
    for _, window in ipairs(self.windows) do
        window:draw()
    end
end

local function handleWindowEvent(windows, event, ...)
    for _, window in ipairs(windows) do
        if window[event] then  -- 检查事件处理函数是否存在
            window[event](window, ...)
        else
            print("Warning: Event handler for '" .. event .. "' not found in window.")
        end
    end
end

function GameScene:mousepressed(x, y, button, istouch, presses)
    for i = #self.windows, 1, -1 do
        local window = self.windows[i]
        if window:isHovered(x, y) then
            table.remove(self.windows, i)
            table.insert(self.windows, window)  -- 将点击的窗口移到最上层
            window:mousepressed(x, y, button, istouch, presses)
            break
        end
    end
end

function GameScene:mousereleased(x, y, button, istouch, presses)
    handleWindowEvent(self.windows, "mousereleased", x, y, button, istouch, presses)
end

function GameScene:mousemoved(x, y, dx, dy, istouch)
    handleWindowEvent(self.windows, "mousemoved", x, y, dx, dy, istouch)
end

function GameScene:textinput(t)
    handleWindowEvent(self.windows, "textinput", t)
end

function GameScene:keypressed(key)
    handleWindowEvent(self.windows, "keypressed", key)
end

return GameScene