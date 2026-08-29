$DocsPath = "C:\Users\sovan\.gemini\antigravity\scratch\LunarUI"

# examples/Example.lua
$Example = @"
local LunarUI = require(script.Parent.Parent.src.LunarUI)

local Window = LunarUI:CreateWindow({
    Title = "Lunar UI",
    Subtitle = "Roblox Luau UI Library",
    Theme = "LiquidGlass"
})

local MainTab = Window:AddTab({
    Title = "Main"
})

local SettingsTab = Window:AddTab({
    Title = "Settings"
})

local Section = MainTab:AddSection({
    Title = "Section"
})

Section:AddButton({
    Title = "Click Me",
    Callback = function()
        print("Button clicked!")
        LunarUI:Notify({
            Title = "Action",
            Content = "Button was clicked successfully!",
            Duration = 3
        })
    end
})

Section:AddToggle({
    Title = "Toggle Switch",
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

Section:AddSlider({
    Title = "Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Step = 1,
    Callback = function(Value)
        print("Slider:", Value)
    end
})

Section:AddDropdown({
    Title = "Dropdown",
    Values = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Default = "Option 1",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

Section:AddMultiDropdown({
    Title = "Multi Dropdown",
    Values = {
        "Option 1",
        "Option 2",
        "Option 3"
    },
    Callback = function(Values)
        print(Values)
    end
})

local TextSection = MainTab:AddSection({
    Title = "Text & Layout"
})

TextSection:AddTextbox({
    Title = "Text Box",
    Placeholder = "Enter text...",
    Callback = function(Text)
        print(Text)
    end
})

TextSection:AddLabel({
    Text = "This is a simple label."
})

TextSection:AddSeparator()

TextSection:AddLabel({
    Text = "Text below separator."
})

LunarUI:Notify({
    Title = "Welcome",
    Content = "Lunar UI loaded successfully!",
    Duration = 5
})
"@

# README.md
$Readme = @"
# Lunar UI
![Lunar UI](assets/LunarLogo.png)

Lunar UI is a modern, lightweight, highly customizable UI library specifically designed for Roblox and programmed entirely in Roblox Luau (Lua). It features a beautiful Liquid Glass aesthetic, smooth animations, and a developer-friendly modular architecture.

## Visual Identity
- **Liquid Glass & Frosted Glass**
- **Dark transparent surfaces & Background blur**
- **Minimal lunar-purple accents**
- **Smooth animations via TweenService**

## Installation
You can include Lunar UI in your project by inserting the \`src\` folder into \`ReplicatedStorage\` or your preferred container. 

\`\`\`lua
local LunarUI = require(game.ReplicatedStorage.LunarUI)
\`\`\`

## Quick Start
\`\`\`lua
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
\`\`\`

## Features
- **Window**: Draggable, Search Box, Animated Tabs.
- **Components**: Button, Toggle, Slider, Dropdown, MultiDropdown, Textbox, Keybind, ColorPicker, Label, Paragraph, Separator, Image.
- **Notifications**: Built-in stacking notification system.
- **Themes**: Easy to customize themes (LiquidGlass and LiquidGlassLight built-in).

## Performance
Lunar UI is built with performance in mind. It minimizes the use of \`RenderStepped\` loops, relies on event-driven updates, and leverages \`TweenService\` for all animations to ensure high FPS on all devices.
"@

# LICENSE
$License = @"
MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"@

Set-Content -Path "$DocsPath\examples\Example.lua" -Value $Example
Set-Content -Path "$DocsPath\README.md" -Value $Readme
Set-Content -Path "$DocsPath\LICENSE" -Value $License

Write-Host "Created Documentation and Examples"
