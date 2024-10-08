-- SnakeGameScene.lua

local SnakeGameScene = {}

function SnakeGameScene:load()
    -- 初始化贪吃蛇游戏场景
    self.snake = {{x = 5, y = 5}}
    self.direction = "right"
    self.gridSize = 20
    self.timer = 0
    self.speed = 0.1
    self.food = {x = math.random(0, 39), y = math.random(0, 29)}
end

function SnakeGameScene:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.speed then
        self.timer = 0
        self:moveSnake()
    end
end

function SnakeGameScene:draw()
    love.graphics.setColor(0, 1, 0)
    for _, segment in ipairs(self.snake) do
        love.graphics.rectangle("fill", segment.x * self.gridSize, segment.y * self.gridSize, self.gridSize, self.gridSize)
    end

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.food.x * self.gridSize, self.food.y * self.gridSize, self.gridSize, self.gridSize)
end

function SnakeGameScene:keypressed(key)
    if key == "up" and self.direction ~= "down" then
        self.direction = "up"
    elseif key == "down" and self.direction ~= "up" then
        self.direction = "down"
    elseif key == "left" and self.direction ~= "right" then
        self.direction = "left"
    elseif key == "right" and self.direction ~= "left" then
        self.direction = "right"
    end
end

function SnakeGameScene:moveSnake()
    local head = {x = self.snake[1].x, y = self.snake[1].y}

    if self.direction == "up" then
        head.y = head.y - 1
    elseif self.direction == "down" then
        head.y = head.y + 1
    elseif self.direction == "left" then
        head.x = head.x - 1
    elseif self.direction == "right" then
        head.x = head.x + 1
    end

    table.insert(self.snake, 1, head)

    if head.x == self.food.x and head.y == self.food.y then
        self.food = {x = math.random(0, 39), y = math.random(0, 29)}
    else
        table.remove(self.snake)
    end
end

return SnakeGameScene