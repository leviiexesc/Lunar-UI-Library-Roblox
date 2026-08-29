local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    local toggled = config.Default or false
    
    local toggleContainer = InstanceUtil.new("TextButton", {
        Name = "Toggle",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Text = "",
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "Toggle",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = toggleContainer
    
    local switchBG = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = toggled and theme.AccentColor or theme.BorderColor,
        BackgroundTransparency = toggled and 0 or 0.8,
    })
    InstanceUtil.ApplyCorner(switchBG, UDim.new(1, 0))
    InstanceUtil.ApplyStroke(switchBG, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    switchBG.Parent = toggleContainer
    
    local knob = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, toggled and 24 or 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
    InstanceUtil.ApplyCorner(knob, UDim.new(1, 0))
    knob.Parent = switchBG
    
    toggleContainer.Parent = parent
    
    local function UpdateVisuals()
        Animation.Tween(switchBG, {
            BackgroundColor3 = toggled and theme.AccentColor or theme.BorderColor,
            BackgroundTransparency = toggled and 0 or 0.8
        })
        Animation.Tween(knob, {
            Position = UDim2.new(0, toggled and 24 or 2, 0.5, 0)
        })
    end
    
    toggleContainer.MouseButton1Click:Connect(function()
        toggled = not toggled
        UpdateVisuals()
        if config.Callback then
            task.spawn(config.Callback, toggled)
        end
    end)
    
    return {
        Instance = toggleContainer,
        Set = function(self, value)
            toggled = value
            UpdateVisuals()
        end,
        GetValue = function(self) return toggled end
    }
end
