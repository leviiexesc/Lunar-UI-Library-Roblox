local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)

return function(parent)
    local theme = ThemeSystem.GetTheme()
    
    local separator = InstanceUtil.new("Frame", {
        Name = "Separator",
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
    })
    
    local container = InstanceUtil.new("Frame", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
    })
    separator.Position = UDim2.new(0, 0, 0.5, 0)
    separator.AnchorPoint = Vector2.new(0, 0.5)
    separator.Parent = container
    
    container.Parent = parent
    
    return { Instance = container }
end
