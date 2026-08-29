local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    
    local buttonFrame = InstanceUtil.new("TextButton", {
        Name = "Button",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        Text = config.Title or "Button",
        Font = Enum.Font.GothamMedium,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        AutoButtonColor = false,
    })
    
    InstanceUtil.ApplyCorner(buttonFrame, UDim.new(0, 6))
    local stroke = InstanceUtil.ApplyStroke(buttonFrame, {
        Color = theme.BorderColor,
        Transparency = 0.8,
        Thickness = 1
    })
    
    buttonFrame.Parent = parent
    
    buttonFrame.MouseEnter:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.8})
        Animation.Tween(stroke, {Transparency = 0.6})
    end)
    
    buttonFrame.MouseLeave:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.9})
        Animation.Tween(stroke, {Transparency = 0.8})
    end)
    
    buttonFrame.MouseButton1Down:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.7})
    end)
    
    buttonFrame.MouseButton1Up:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.8})
        if config.Callback then
            task.spawn(config.Callback)
        end
    end)
    
    return {
        Instance = buttonFrame,
        SetText = function(self, text)
            buttonFrame.Text = text
        end,
    }
end
