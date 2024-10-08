-- MainMenu.lua

local MainMenu = {}

function MainMenu:load()
    -- 初始化主菜单场景
    print("Main Menu Loaded")
end

function MainMenu:update(dt)
    -- 更新主菜单场景
end

function MainMenu:draw()
    -- 绘制主菜单场景
    love.graphics.print("Main Menu", 100, 100)
end

local function handleEvent(event, ...)
    -- 处理事件的通用函数
end

function MainMenu:mousepressed(x, y, button, istouch, presses)
    handleEvent("mousepressed", x, y, button, istouch, presses)
end

function MainMenu:mousereleased(x, y, button, istouch, presses)
    handleEvent("mousereleased", x, y, button, istouch, presses)
end

function MainMenu:mousemoved(x, y, dx, dy, istouch)
    handleEvent("mousemoved", x, y, dx, dy, istouch)
end

function MainMenu:textinput(t)
    handleEvent("textinput", t)
end

function MainMenu:keypressed(key)
    handleEvent("keypressed", key)
end

return MainMenu