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
