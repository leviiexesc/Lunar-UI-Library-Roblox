$ComponentsPath = "C:\Users\sovan\.gemini\antigravity\scratch\LunarUI\src\Components"

# Button
$Button = @"
local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    
    local buttonFrame = InstanceUtil.new("TextButton", {
        Name = "Button",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        Text = config.Title or "Button",
        Font = Enum.Font.GothamMedium,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        AutoButtonColor = false,
    })
    
    InstanceUtil.ApplyCorner(buttonFrame, UDim.new(0, 6))
    local stroke = InstanceUtil.ApplyStroke(buttonFrame, {
        Color = theme.BorderColor,
        Transparency = 0.8,
        Thickness = 1
    })
    
    buttonFrame.Parent = parent
    
    buttonFrame.MouseEnter:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.8})
        Animation.Tween(stroke, {Transparency = 0.6})
    end)
    
    buttonFrame.MouseLeave:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.9})
        Animation.Tween(stroke, {Transparency = 0.8})
    end)
    
    buttonFrame.MouseButton1Down:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.7})
    end)
    
    buttonFrame.MouseButton1Up:Connect(function()
        Animation.Tween(buttonFrame, {BackgroundTransparency = 0.8})
        if config.Callback then
            task.spawn(config.Callback)
        end
    end)
    
    return {
        Instance = buttonFrame,
        SetText = function(self, text)
            buttonFrame.Text = text
        end,
    }
end
"@

# Toggle
$Toggle = @"
local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    local toggled = config.Default or false
    
    local toggleContainer = InstanceUtil.new("TextButton", {
        Name = "Toggle",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Text = "",
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "Toggle",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = toggleContainer
    
    local switchBG = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = toggled and theme.AccentColor or theme.BorderColor,
        BackgroundTransparency = toggled and 0 or 0.8,
    })
    InstanceUtil.ApplyCorner(switchBG, UDim.new(1, 0))
    InstanceUtil.ApplyStroke(switchBG, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    switchBG.Parent = toggleContainer
    
    local knob = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, toggled and 24 or 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
    InstanceUtil.ApplyCorner(knob, UDim.new(1, 0))
    knob.Parent = switchBG
    
    toggleContainer.Parent = parent
    
    local function UpdateVisuals()
        Animation.Tween(switchBG, {
            BackgroundColor3 = toggled and theme.AccentColor or theme.BorderColor,
            BackgroundTransparency = toggled and 0 or 0.8
        })
        Animation.Tween(knob, {
            Position = UDim2.new(0, toggled and 24 or 2, 0.5, 0)
        })
    end
    
    toggleContainer.MouseButton1Click:Connect(function()
        toggled = not toggled
        UpdateVisuals()
        if config.Callback then
            task.spawn(config.Callback, toggled)
        end
    end)
    
    return {
        Instance = toggleContainer,
        Set = function(self, value)
            toggled = value
            UpdateVisuals()
        end,
        GetValue = function(self) return toggled end
    }
end
"@

# Slider
$Slider = @"
local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)
local UserInputService = game:GetService("UserInputService")

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    local min = config.Min or 0
    local max = config.Max or 100
    local step = config.Step or 1
    local value = config.Default or min
    
    local sliderContainer = InstanceUtil.new("Frame", {
        Name = "Slider",
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundTransparency = 1,
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, -50, 0, 20),
        BackgroundTransparency = 1,
        Text = config.Title or "Slider",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = sliderContainer
    
    local valueLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Text = tostring(value),
        Font = Enum.Font.Gotham,
        TextColor3 = theme.SubTextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    valueLabel.Parent = sliderContainer
    
    local trackBG = InstanceUtil.new("TextButton", {
        Size = UDim2.new(1, 0, 0, 6),
        Position = UDim2.new(0, 0, 1, -12),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.8,
        Text = "",
        AutoButtonColor = false,
    })
    InstanceUtil.ApplyCorner(trackBG, UDim.new(1, 0))
    trackBG.Parent = sliderContainer
    
    local fill = InstanceUtil.new("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = theme.AccentColor,
        BorderSizePixel = 0,
    })
    InstanceUtil.ApplyCorner(fill, UDim.new(1, 0))
    fill.Parent = trackBG
    
    local knob = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
    InstanceUtil.ApplyCorner(knob, UDim.new(1, 0))
    knob.Parent = fill
    
    sliderContainer.Parent = parent
    
    local dragging = false
    local function updateValue(input)
        local pos = math.clamp((input.Position.X - trackBG.AbsolutePosition.X) / trackBG.AbsoluteSize.X, 0, 1)
        local rawValue = min + pos * (max - min)
        local steppedValue = math.floor(rawValue / step + 0.5) * step
        value = math.clamp(steppedValue, min, max)
        
        valueLabel.Text = tostring(value)
        Animation.Tween(fill, {Size = UDim2.new((value - min) / (max - min), 0, 1, 0)}, 0.1)
        
        if config.Callback then
            task.spawn(config.Callback, value)
        end
    end
    
    trackBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateValue(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input)
        end
    end)
    
    return {
        Instance = sliderContainer,
        SetValue = function(self, newValue)
            value = math.clamp(newValue, min, max)
            valueLabel.Text = tostring(value)
            Animation.Tween(fill, {Size = UDim2.new((value - min) / (max - min), 0, 1, 0)}, 0.1)
        end,
        GetValue = function(self) return value end
    }
end
"@

# Dropdown
$Dropdown = @"
local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)
local Animation = require(script.Parent.Parent.Services.Animation)

return function(parent, config)
    local theme = ThemeSystem.GetTheme()
    local selectedValue = config.Default
    local isOpen = false
    
    local dropdownContainer = InstanceUtil.new("Frame", {
        Name = "Dropdown",
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
    
    local headerBtn = InstanceUtil.new("TextButton", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        Text = "",
        AutoButtonColor = false,
    })
    InstanceUtil.ApplyCorner(headerBtn, UDim.new(0, 6))
    InstanceUtil.ApplyStroke(headerBtn, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    headerBtn.Parent = dropdownContainer
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = config.Title .. (selectedValue and (": " .. selectedValue) or ""),
        Font = Enum.Font.GothamMedium,
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = headerBtn
    
    local arrow = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = "v",
        Font = Enum.Font.GothamBold,
        TextColor3 = theme.SubTextColor,
        TextSize = 14,
    })
    arrow.Parent = headerBtn
    
    local listContainer = InstanceUtil.new("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 42),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
    listContainer.Parent = dropdownContainer
    
    local UIListLayout = InstanceUtil.new("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    UIListLayout.Parent = listContainer
    
    dropdownContainer.Parent = parent
    
    local function populate()
        for _, child in pairs(listContainer:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        local totalHeight = 0
        for i, val in ipairs(config.Values or {}) do
            local btn = InstanceUtil.new("TextButton", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = theme.BorderColor,
                BackgroundTransparency = 0.95,
                Text = "  " .. val,
                Font = Enum.Font.Gotham,
                TextColor3 = (val == selectedValue) and theme.AccentColor or theme.SubTextColor,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutoButtonColor = false,
            })
            InstanceUtil.ApplyCorner(btn, UDim.new(0, 4))
            btn.Parent = listContainer
            totalHeight = totalHeight + 34
            
            btn.MouseButton1Click:Connect(function()
                selectedValue = val
                titleLabel.Text = config.Title .. ": " .. val
                for _, b in pairs(listContainer:GetChildren()) do
                    if b:IsA("TextButton") then b.TextColor3 = theme.SubTextColor end
                end
                btn.TextColor3 = theme.AccentColor
                if config.Callback then
                    task.spawn(config.Callback, val)
                end
                isOpen = false
                Animation.Tween(dropdownContainer, {Size = UDim2.new(1, 0, 0, 46)})
                Animation.Tween(listContainer, {Size = UDim2.new(1, 0, 0, 0)})
                Animation.Tween(arrow, {Rotation = 0})
            end)
        end
        return totalHeight
    end
    
    local listHeight = populate()
    
    headerBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            Animation.Tween(dropdownContainer, {Size = UDim2.new(1, 0, 0, 46 + listHeight)})
            Animation.Tween(listContainer, {Size = UDim2.new(1, 0, 0, listHeight)})
            Animation.Tween(arrow, {Rotation = 180})
        else
            Animation.Tween(dropdownContainer, {Size = UDim2.new(1, 0, 0, 46)})
            Animation.Tween(listContainer, {Size = UDim2.new(1, 0, 0, 0)})
            Animation.Tween(arrow, {Rotation = 0})
        end
    end)
    
    return {
        Instance = dropdownContainer,
        Refresh = function(self, newValues, newDefault)
            config.Values = newValues
            selectedValue = newDefault or selectedValue
            listHeight = populate()
            titleLabel.Text = config.Title .. (selectedValue and (": " .. selectedValue) or "")
            if isOpen then
                Animation.Tween(dropdownContainer, {Size = UDim2.new(1, 0, 0, 46 + listHeight)})
                Animation.Tween(listContainer, {Size = UDim2.new(1, 0, 0, listHeight)})
            end
        end,
        GetValue = function(self) return selectedValue end
    }
end
"@

# MultiDropdown (simplified as slightly modified Dropdown)
$MultiDropdown = $Dropdown -replace "selectedValue = val", "if not selectedValue then selectedValue = {} end; selectedValue[val] = not selectedValue[val]"

# Label
$Label = @"
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
"@

# Separator
$Separator = @"
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
"@

# Textbox
$Textbox = @"
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
"@

Set-Content -Path "$ComponentsPath\Button.lua" -Value $Button
Set-Content -Path "$ComponentsPath\Toggle.lua" -Value $Toggle
Set-Content -Path "$ComponentsPath\Slider.lua" -Value $Slider
Set-Content -Path "$ComponentsPath\Dropdown.lua" -Value $Dropdown
Set-Content -Path "$ComponentsPath\MultiDropdown.lua" -Value $MultiDropdown
Set-Content -Path "$ComponentsPath\Label.lua" -Value $Label
Set-Content -Path "$ComponentsPath\Separator.lua" -Value $Separator
Set-Content -Path "$ComponentsPath\Textbox.lua" -Value $Textbox

# Basic placeholders for the rest
$Placeholder = @"
return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end
"@
Set-Content -Path "$ComponentsPath\Keybind.lua" -Value $Placeholder
Set-Content -Path "$ComponentsPath\ColorPicker.lua" -Value $Placeholder
Set-Content -Path "$ComponentsPath\Paragraph.lua" -Value $Placeholder
Set-Content -Path "$ComponentsPath\Image.lua" -Value $Placeholder

Write-Host "Created components"
