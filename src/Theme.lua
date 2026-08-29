-- Lunar UI Themes
local Themes = {}

Themes.LiquidGlass = {
    Name = "LiquidGlass",
    MainColor = Color3.fromRGB(20, 20, 25),
    AccentColor = Color3.fromRGB(140, 80, 255),
    BackgroundColor = Color3.fromRGB(10, 10, 12),
    TextColor = Color3.fromRGB(240, 240, 240),
    SubTextColor = Color3.fromRGB(180, 180, 180),
    BorderColor = Color3.fromRGB(255, 255, 255),
    BorderTransparency = 0.9,
    BackgroundTransparency = 0.3,
    SectionTransparency = 0.5,
    ElementTransparency = 0.7,
    BlurIntensity = 15,
    CornerRadius = UDim.new(0, 8),
    AnimationSpeed = 0.3,
}

Themes.LiquidGlassLight = {
    Name = "LiquidGlassLight",
    MainColor = Color3.fromRGB(240, 240, 245),
    AccentColor = Color3.fromRGB(120, 60, 240),
    BackgroundColor = Color3.fromRGB(250, 250, 252),
    TextColor = Color3.fromRGB(20, 20, 25),
    SubTextColor = Color3.fromRGB(80, 80, 80),
    BorderColor = Color3.fromRGB(0, 0, 0),
    BorderTransparency = 0.9,
    BackgroundTransparency = 0.3,
    SectionTransparency = 0.5,
    ElementTransparency = 0.7,
    BlurIntensity = 15,
    CornerRadius = UDim.new(0, 8),
    AnimationSpeed = 0.3,
}

local ThemeSystem = {
    CurrentTheme = Themes.LiquidGlass,
}

function ThemeSystem.SetTheme(themeName)
    if Themes[themeName] then
        ThemeSystem.CurrentTheme = Themes[themeName]
    end
end

function ThemeSystem.GetTheme()
    return ThemeSystem.CurrentTheme
end

return ThemeSystem
