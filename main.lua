-- main.lua

local SceneManager = require("managers.SceneManager")
local MainMenu = require("scenes.MainMenu")
local GameScene = require("scenes.GameScene")

local sceneManager

function love.load()
    sceneManager = SceneManager:new()
    sceneManager:addScene("mainMenu", MainMenu)
    sceneManager:addScene("game", GameScene)
    sceneManager:switchTo("game")  -- 启动时切换到游戏场景
end

function love.update(dt)
    sceneManager:update(dt)
end

function love.draw()
    sceneManager:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    sceneManager:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    sceneManager:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    sceneManager:mousemoved(x, y, dx, dy, istouch)
end

function love.textinput(t)
    sceneManager:textinput(t)
end

function love.keypressed(key)
    sceneManager:keypressed(key)
end