# API 文档

## 组件

### Button

- **new(x, y, width, height, label)**: 创建一个新的按钮。
- **draw()**: 绘制按钮。
- **update(dt, mx, my)**: 更新按钮状态。
- **mousepressed(x, y, button, istouch, presses)**: 处理鼠标按下事件。
- **mousereleased(x, y, button, istouch, presses)**: 处理鼠标释放事件。

### EditBox

- **new(x, y, width, height)**: 创建一个新的文本输入框。
- **draw()**: 绘制输入框。
- **update(dt)**: 更新输入框状态。
- **textinput(t)**: 处理文本输入。
- **keypressed(key)**: 处理按键事件。

### ToggleButton

- **new(x, y, width, height, label)**: 创建一个新的切换按钮。
- **draw()**: 绘制切换按钮。
- **mousepressed(x, y, button, istouch, presses)**: 处理鼠标按下事件。

### Slider

- **new(x, y, width, height, minValue, maxValue)**: 创建一个新的滑块。
- **draw()**: 绘制滑块。
- **mousepressed(x, y, button, istouch, presses)**: 处理鼠标按下事件。
- **mousereleased(x, y, button, istouch, presses)**: 处理鼠标释放事件。
- **mousemoved(x, y, dx, dy, istouch)**: 处理鼠标移动事件。

### Checkbox

- **new(x, y, size, label)**: 创建一个新的复选框。
- **draw()**: 绘制复选框。
- **mousepressed(x, y, button, istouch, presses)**: 处理鼠标按下事件。

### Label

- **new(x, y, text, fontSize)**: 创建一个新的标签。
- **draw()**: 绘制标签。

### ProgressBar

- **new(x, y, width, height, maxValue)**: 创建一个新的进度条。
- **setValue(value)**: 设置当前进度值。
- **draw()**: 绘制进度条。

## 布局

### FixedLayout

- **new(name)**: 创建一个新的固定布局。
- **addComponent(component, x, y)**: 添加组件到布局。
- **draw()**: 绘制布局。
- **arrange()**: 布局组件（固定布局不需要重新排列）。

### VerticalLayout

- **new(x, y, spacing)**: 创建一个新的垂直布局。
- **addComponent(component)**: 添加组件到布局。
- **arrange()**: 布局组件。
- **draw()**: 绘制布局。

### HorizontalLayout

- **new(x, y, spacing)**: 创建一个新的水平布局。
- **addComponent(component)**: 添加组件到布局。
- **arrange()**: 布局组件。
- **draw()**: 绘制布局。

### GridLayout

- **new(x, y, cols, spacing)**: 创建一个新的网格布局。
- **addComponent(component)**: 添加组件到布局。
- **arrange()**: 布局组件。
- **draw()**: 绘制布局。