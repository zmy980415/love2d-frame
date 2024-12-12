-- MainMenu.lua

local MainMenu = {}
local Button = require("components.Button")

function MainMenu:load()
    -- 初始化主菜单场景
    self.titleFont = love.graphics.newFont("assets/fonts/simhei.ttf", 48)
    self.buttonFont = love.graphics.newFont("assets/fonts/simhei.ttf", 24)
    self.startButton = Button:new(300, 400, 200, 50, "Start Game")
    self.startButton.onClick = function()
        print("Start Game button clicked!")
        sceneManager:switchTo("game")  -- 切换到贪吃蛇游戏场景
    end
end

function MainMenu:update(dt)
    -- 更新主菜单场景
    local mx, my = love.mouse.getPosition()
    self.startButton:update(dt, mx, my)
end

function MainMenu:draw()
    -- 绘制主菜单场景
    love.graphics.setFont(self.titleFont)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Welcome to My Game", 0, 100, love.graphics.getWidth(), "center")

    love.graphics.setFont(self.buttonFont)
    self.startButton:draw()
end

function MainMenu:mousepressed(x, y, button, istouch, presses)
    self.startButton:mousepressed(x, y, button, istouch, presses)
end

function MainMenu:mousereleased(x, y, button, istouch, presses)
    self.startButton:mousereleased(x, y, button, istouch, presses)
end

return MainMenu