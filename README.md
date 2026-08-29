# Lunar UI
![Lunar UI](assets/LunarLogo.png)

Lunar UI is a modern, lightweight, highly customizable UI library specifically designed for Roblox and programmed entirely in Roblox Luau (Lua). It features a beautiful Liquid Glass aesthetic, smooth animations, and a developer-friendly modular architecture.

## Visual Identity
- **Liquid Glass & Frosted Glass**
- **Dark transparent surfaces & Background blur**
- **Minimal lunar-purple accents**
- **Smooth animations via TweenService**

## Installation
You can include Lunar UI in your project by inserting the \src\ folder into \ReplicatedStorage\ or your preferred container. 

\\\lua
local LunarUI = require(game.ReplicatedStorage.LunarUI)
\\\

## Quick Start
\\\lua
local LunarUI = require(path.to.LunarUI)

local Window = LunarUI:CreateWindow({
    Title = "Lunar UI",
    Theme = "LiquidGlass"
})

local Tab = Window:AddTab({ Title = "Main" })
local Section = Tab:AddSection({ Title = "Controls" })

Section:AddButton({
    Title = "Hello World",
    Callback = function()
        print("Hello!")
    end
})
\\\

## Features
- **Window**: Draggable, Search Box, Animated Tabs.
- **Components**: Button, Toggle, Slider, Dropdown, MultiDropdown, Textbox, Keybind, ColorPicker, Label, Paragraph, Separator, Image.
- **Notifications**: Built-in stacking notification system.
- **Themes**: Easy to customize themes (LiquidGlass and LiquidGlassLight built-in).

## Performance
Lunar UI is built with performance in mind. It minimizes the use of \RenderStepped\ loops, relies on event-driven updates, and leverages \TweenService\ for all animations to ensure high FPS on all devices.
