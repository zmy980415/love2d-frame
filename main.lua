-- main.lua

local SceneManager = require("managers.SceneManager")
local MainMenu = require("scenes.MainMenu")
local GameScene = require("scenes.GameScene")
local SnakeGameScene = require("scenes.SnakeGameScene")  -- 新增


function love.load()
    sceneManager = SceneManager:new()
    sceneManager:addScene("mainMenu", MainMenu)
    sceneManager:addScene("game", GameScene)
    sceneManager:addScene("snakeGame", SnakeGameScene)  -- 新增
    sceneManager:switchTo("mainMenu")  -- 启动时切换到主菜单场景
end

function love.update(dt)
    sceneManager:update(dt)
end

function love.draw()
    sceneManager:draw()
end

local function handleMouseEvent(event, ...)
    sceneManager[event](sceneManager, ...)
end

function love.mousepressed(x, y, button, istouch, presses)
    handleMouseEvent("mousepressed", x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    handleMouseEvent("mousereleased", x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    handleMouseEvent("mousemoved", x, y, dx, dy, istouch)
end

function love.textinput(t)
    sceneManager:textinput(t)
end

function love.keypressed(key)
    sceneManager:keypressed(key)
end