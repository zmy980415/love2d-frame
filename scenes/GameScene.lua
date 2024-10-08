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

local windows = {}
local font

function GameScene:load()
    font = love.graphics.newFont("assets/fonts/simhei.ttf", 14)

    -- 创建第一个窗口，使用 VerticalLayout
    local window1 = Window:new(100, 100, 300, 200, "Vertical Layout")
    local verticalLayout = VerticalLayout:new(0, 30, 10)
    verticalLayout:addComponent(Button:new(0, 0, 280, 30, "Button 1"))
    verticalLayout:addComponent(EditBox:new(0, 0, 280, 30))
    verticalLayout:arrange()
    window1:addComponent(verticalLayout)
    table.insert(windows, window1)

    -- 创建第二个窗口，使用 HorizontalLayout
    local window2 = Window:new(450, 100, 300, 200, "Horizontal Layout")
    local horizontalLayout = HorizontalLayout:new(0, 30, 10)
    horizontalLayout:addComponent(ToggleButton:new(0, 0, 80, 30, "Toggle"))
    horizontalLayout:addComponent(Slider:new(0, 0, 150, 30, 0, 100))
    horizontalLayout:arrange()
    window2:addComponent(horizontalLayout)
    table.insert(windows, window2)

    -- 创建第三个窗口，使用 GridLayout
    local window3 = Window:new(100, 350, 300, 200, "Grid Layout")
    local gridLayout = GridLayout:new(0, 30, 2, 10)
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 1"))
    gridLayout:addComponent(Checkbox:new(0, 0, 20, "Check 2"))
    gridLayout:addComponent(Label:new(0, 0, "Label 1", 14))
    gridLayout:addComponent(Label:new(0, 0, "Label 2", 14))
    gridLayout:arrange()
    window3:addComponent(gridLayout)
    table.insert(windows, window3)
end

function GameScene:update(dt)
    for _, window in ipairs(windows) do
        window:update(dt)
    end
end

function GameScene:draw()
    love.graphics.clear(0.2, 0.3, 0.4)  -- 设置背景颜色为一种好看的蓝色
    love.graphics.setFont(font)
    for _, window in ipairs(windows) do
        window:draw()
    end

    -- 显示鼠标坐标
    local mx, my = love.mouse.getPosition()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(string.format("Mouse: (%d, %d)", mx, my), mx, my)
end

function GameScene:mousepressed(x, y, button, istouch, presses)
    for i = #windows, 1, -1 do
        local window = windows[i]
        if window:isHovered(x, y) then
            table.remove(windows, i)
            table.insert(windows, window)  -- 将点击的窗口移到最上层
            window:mousepressed(x, y, button, istouch, presses)
            break
        end
    end
end

function GameScene:mousereleased(x, y, button, istouch, presses)
    for _, window in ipairs(windows) do
        window:mousereleased(x, y, button, istouch, presses)
    end
end

function GameScene:mousemoved(x, y, dx, dy, istouch)
    for _, window in ipairs(windows) do
        window:mousemoved(x, y, dx, dy, istouch)
    end
end

function GameScene:textinput(t)
    for _, window in ipairs(windows) do
        window:textinput(t)
    end
end

function GameScene:keypressed(key)
    for _, window in ipairs(windows) do
        window:keypressed(key)
    end
end

return GameScene