local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)
local UserInputService = game:GetService("UserInputService")

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    local min = config.Min or 0
    local max = config.Max or 100
    local step = config.Step or 1
    local value = config.Default or min
    
    local sliderContainer = InstanceUtil.new("Frame", {
        Name = "Slider",
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundTransparency = 1,
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, -50, 0, 20),
        BackgroundTransparency = 1,
        Text = config.Title or "Slider",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = sliderContainer
    
    local valueLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(value),
        Font = Enum.Font.Gotham,
        TextColor3 = theme.SubTextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    valueLabel.Parent = sliderContainer
    
    local trackBG = InstanceUtil.new("TextButton", {
        Size = UDim2.new(1, 0, 0, 6),
        Position = UDim2.new(0, 0, 1, -12),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.8,
        Text = "",
        AutoButtonColor = false,
    })
    InstanceUtil.ApplyCorner(trackBG, UDim.new(1, 0))
    trackBG.Parent = sliderContainer
    
    local fill = InstanceUtil.new("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = theme.AccentColor,
        BorderSizePixel = 0,
    })
    InstanceUtil.ApplyCorner(fill, UDim.new(1, 0))
    fill.Parent = trackBG
    
    local knob = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
    InstanceUtil.ApplyCorner(knob, UDim.new(1, 0))
    knob.Parent = fill
    
    sliderContainer.Parent = parent
    
    local dragging = false
    local function updateValue(input)
        local pos = math.clamp((input.Position.X - trackBG.AbsolutePosition.X) / trackBG.AbsoluteSize.X, 0, 1)
        local rawValue = min + pos * (max - min)
        local steppedValue = math.floor(rawValue / step + 0.5) * step
        value = math.clamp(steppedValue, min, max)
        
        valueLabel.Text = tostring(value)
        Animation.Tween(fill, {Size = UDim2.new((value - min) / (max - min), 0, 1, 0)}, 0.1)
        
        if config.Callback then
            task.spawn(config.Callback, value)
        end
    end
    
    trackBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateValue(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input)
        end
    end)
    
    return {
        Instance = sliderContainer,
        SetValue = function(self, newValue)
            value = math.clamp(newValue, min, max)
            valueLabel.Text = tostring(value)
            Animation.Tween(fill, {Size = UDim2.new((value - min) / (max - min), 0, 1, 0)}, 0.1)
        end,
        GetValue = function(self) return value end
    }
end
