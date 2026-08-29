-- Load the library
local Lunar = loadstring(game:HttpGet("YOUR_URL/LunarUI.lua"))()

-- Create a window
local Window = Lunar:CreateWindow({
    Title = "Lunar UI",
    Theme = "LiquidGlass"
})

-- Add a tab
local Main = Window:AddTab({ Title = "Main" })

-- Add a section
local Section = Main:AddSection({ Title = "Section" })

-- Add components
Section:AddButton({
    Title = "Button",
    Text = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})

Section:AddToggle({
    Title = "Toggle Switch",
    Default = true,
    Callback = function(value)
        print("Toggle:", value)
    end
})

Section:AddSlider({
    Title = "Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Slider:", value)
    end
})

Section:AddDropdown({
    Title = "Dropdown",
    Values = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1"
})

Section:AddMultiDropdown({
    Title = "Multi Dropdown",
    Values = {"Option 1", "Option 2", "Option 3"}
})

-- Add a paragraph
Window:AddParagraph("Paragraph", "Description")
