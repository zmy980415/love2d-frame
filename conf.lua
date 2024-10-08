function love.conf(t)
    t.window.title = "My Love2D Game"  -- 设置窗口标题
    t.window.width = 800               -- 设置窗口宽度
    t.window.height = 600              -- 设置窗口高度
    t.window.resizable = true          -- 允许窗口大小调整
    t.modules.joystick = false         -- 禁用操纵杆模块
    t.modules.physics = false          -- 禁用物理模块
    -- 你可以根据需要添加更多配置
    
end