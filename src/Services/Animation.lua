local TweenService = game:GetService("TweenService")
local ThemeSystem = require(script.Parent.Parent.Theme)

local Animation = {}

function Animation.Tween(instance, properties, duration, style, direction)
    duration = duration or ThemeSystem.GetTheme().AnimationSpeed
    style = style or Enum.EasingStyle.Quart
    direction = direction or Enum.EasingDirection.Out
    
    local tweenInfo = TweenInfo.new(duration, style, direction)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

return Animation
