local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    
    local container = InstanceUtil.new("Frame", {
        Name = "Textbox",
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = config.Title or "Textbox",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = container
    
    local boxBG = InstanceUtil.new("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        Position = UDim2.new(0, 0, 1, -34),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
    })
    InstanceUtil.ApplyCorner(boxBG, UDim.new(0, 6))
    local stroke = InstanceUtil.ApplyStroke(boxBG, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    boxBG.Parent = container
    
    local input = InstanceUtil.new("TextBox", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText = config.Placeholder or "",
        Text = "",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        PlaceholderColor3 = theme.SubTextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
    })
    input.Parent = boxBG
    
    container.Parent = parent
    
    input.Focused:Connect(function()
        Animation.Tween(stroke, {Transparency = 0.4})
    end)
    
    input.FocusLost:Connect(function(enterPressed)
        Animation.Tween(stroke, {Transparency = 0.8})
        if config.Callback then
            task.spawn(config.Callback, input.Text)
        end
    end)
    
    return {
        Instance = container,
        SetText = function(self, text) input.Text = text end,
        GetText = function(self) return input.Text end
    }
end
