local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    
    local label = InstanceUtil.new("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 24),
        BackgroundTransparency = 1,
        Text = config.Text or "Label",
        Font = config.Font or Enum.Font.Gotham,
        TextColor3 = config.Color or theme.TextColor,
        TextSize = config.Size or 14,
        TextXAlignment = config.Alignment or Enum.TextXAlignment.Left,
    })
    
    label.Parent = parent
    
    return {
        Instance = label,
        SetText = function(self, text) label.Text = text end
    }
end
