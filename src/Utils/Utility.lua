-- General Utility functions
local Utility = {}
local TextService = game:GetService("TextService")

function Utility.GetTextSize(text, font, fontSize, bounds)
    return TextService:GetTextSize(text, fontSize, font, bounds or Vector2.new(math.huge, math.huge))
end

function Utility.Lerp(a, b, t)
    return a + (b - a) * t
end

return Utility
