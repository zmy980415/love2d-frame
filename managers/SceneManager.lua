-- SceneManager.lua

SceneManager = {}
SceneManager.__index = SceneManager

function SceneManager:new()
    local manager = setmetatable({}, SceneManager)
    manager.scenes = {}
    manager.currentScene = nil
    return manager
end

function SceneManager:addScene(name, scene)
    self.scenes[name] = scene
end

function SceneManager:switchTo(name)
    if self.scenes[name] then
        self.currentScene = self.scenes[name]
        if self.currentScene.load then
            self.currentScene:load()
        end
    else
        error("Scene " .. name .. " does not exist!")
    end
end

function SceneManager:update(dt)
    if self.currentScene and self.currentScene.update then
        self.currentScene:update(dt)
    end
end

function SceneManager:draw()
    if self.currentScene and self.currentScene.draw then
        self.currentScene:draw()
    end
end

function SceneManager:mousepressed(x, y, button, istouch, presses)
    if self.currentScene and self.currentScene.mousepressed then
        self.currentScene:mousepressed(x, y, button, istouch, presses)
    end
end

function SceneManager:mousereleased(x, y, button, istouch, presses)
    if self.currentScene and self.currentScene.mousereleased then
        self.currentScene:mousereleased(x, y, button, istouch, presses)
    end
end

function SceneManager:mousemoved(x, y, dx, dy, istouch)
    if self.currentScene and self.currentScene.mousemoved then
        self.currentScene:mousemoved(x, y, dx, dy, istouch)
    end
end

function SceneManager:textinput(t)
    if self.currentScene and self.currentScene.textinput then
        self.currentScene:textinput(t)
    end
end

function SceneManager:keypressed(key)
    if self.currentScene and self.currentScene.keypressed then
        self.currentScene:keypressed(key)
    end
end

return SceneManager