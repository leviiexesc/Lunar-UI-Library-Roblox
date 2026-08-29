local LunarUI_Modules = {}
local function require(name)
    if not LunarUI_Modules[name] then error('Module not found: ' .. tostring(name)) end
    if not LunarUI_Modules[name].IsLoaded then
        LunarUI_Modules[name].Value = LunarUI_Modules[name].Func()
        LunarUI_Modules[name].IsLoaded = true
    end
    return LunarUI_Modules[name].Value
end

LunarUI_Modules['Config'] = {IsLoaded = false, Func = function()
local script = {}
-- Lunar UI Config
local Config = {
    DefaultTheme = "LiquidGlass",
    Padding = UDim.new(0, 8),
    SectionPadding = UDim.new(0, 12),
    ItemSpacing = UDim.new(0, 6),
    SectionSpacing = UDim.new(0, 10),
    Font = Font.new("rbxasset://fonts/families/GothamSSm.json"),
    ZIndex = 100,
}

return Config

end}

LunarUI_Modules['LunarUI'] = {IsLoaded = false, Func = function()
local script = {}
local Config = require("Config")
local ThemeSystem = require("Theme")
local Window = require("Window")
local Notification = require("Notification")
local Animation = require("Animation")
local InstanceUtil = require("Instance")

local LunarUI = {}
LunarUI.Types = require("Types)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local function GetParentGui()
    local success, parent = pcall(function()
        return CoreGui
    end")
    if not success or not parent then
        parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return parent
end

function LunarUI:CreateWindow(config)
    if config.Theme then
        ThemeSystem.SetTheme(config.Theme)
    end
    
    local parentGui = GetParentGui()
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LunarUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = parentGui
    
    Notification.Init(screenGui)
    
    local window = Window.new(config)
    window.Instance.Parent = screenGui
    
    local theme = ThemeSystem.GetTheme()
    local floatingBtn = InstanceUtil.new("TextButton", {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 20, 1, -70),
        BackgroundColor3 = theme.MainColor,
        BackgroundTransparency = 0.5,
        Text = "🌙",
        Font = Enum.Font.GothamBold,
        TextColor3 = theme.TextColor,
        TextSize = 24,
    })
    InstanceUtil.ApplyCorner(floatingBtn, UDim.new(1, 0))
    InstanceUtil.ApplyStroke(floatingBtn, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    floatingBtn.Parent = screenGui
    
    local isOpen = true
    floatingBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            window.Instance.Visible = true
            Animation.Tween(window.Instance, {Size = UDim2.new(0, 700, 0, 450), BackgroundTransparency = theme.BackgroundTransparency})
        else
            Animation.Tween(window.Instance, {Size = UDim2.new(0, 700, 0, 0), BackgroundTransparency = 1})
            task.delay(ThemeSystem.GetTheme().AnimationSpeed, function()
                if not isOpen then window.Instance.Visible = false end
            end)
        end
    end)
    
    return window
end

function LunarUI:Notify(config)
    Notification.Notify(config)
end

return LunarUI

end}

LunarUI_Modules['Section'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Config = require("Config")

local Section = {}
Section.__index = Section

function Section.new(parentTab, config)
    local theme = ThemeSystem.GetTheme()
    
    local sectionContainer = InstanceUtil.new("Frame", {
        Name = "Section_" .. (config.Title or "Unnamed"),
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = theme.MainColor,
        BackgroundTransparency = theme.SectionTransparency,
    })
    
    InstanceUtil.ApplyCorner(sectionContainer, theme.CornerRadius)
    InstanceUtil.ApplyStroke(sectionContainer, {Color = theme.BorderColor, Transparency = 0.9, Thickness = 1})
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Name = "SectionTitle",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Text = config.Title or "Section",
        Font = Enum.Font.GothamBold,
        TextColor3 = theme.TextColor,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    titleLabel.Parent = sectionContainer
    
    local contentContainer = InstanceUtil.new("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -20, 1, -50),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundTransparency = 1,
    })
    contentContainer.Parent = sectionContainer
    
    local UIListLayout = InstanceUtil.new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = Config.ItemSpacing,
    })
    UIListLayout.Parent = contentContainer
    
    sectionContainer.Parent = parentTab
    
    local self = setmetatable({
        Instance = sectionContainer,
        Container = contentContainer,
        Layout = UIListLayout,
    }, Section)
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sectionContainer.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 50)
    end)
    
    return self
end

-- Component Adders
Section.AddButton = function(self, config) return require("Container, config") end
Section.AddToggle = function(self, config) return require("Container, config") end
Section.AddSlider = function(self, config) return require("Container, config") end
Section.AddDropdown = function(self, config) return require("Container, config") end
Section.AddMultiDropdown = function(self, config) return require("Container, config") end
Section.AddTextbox = function(self, config) return require("Container, config") end
Section.AddKeybind = function(self, config) return require("Container, config") end
Section.AddColorPicker = function(self, config) return require("Container, config") end
Section.AddLabel = function(self, config) return require("Container, config") end
Section.AddParagraph = function(self, config) return require("Container, config") end
Section.AddSeparator = function(self, config) return require("Container, config") end
Section.AddImage = function(self, config) return require("Container, config") end

return Section


end}

LunarUI_Modules['Tab'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Config = require("Config")
local Section = require("Section")
local Animation = require("Animation")

local Tab = {}
Tab.__index = Tab

function Tab.new(window, config)
    local theme = ThemeSystem.GetTheme()
    
    local tabContainer = InstanceUtil.new("ScrollingFrame", {
        Name = "Tab_" .. (config.Title or "Unnamed"),
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = theme.SubTextColor,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false,
    })
    
    local UIListLayout = InstanceUtil.new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = Config.SectionSpacing,
    })
    UIListLayout.Parent = tabContainer
    
    local UIPadding = InstanceUtil.new("UIPadding", {
        PaddingRight = UDim.new(0, 10)
    })
    UIPadding.Parent = tabContainer
    
    tabContainer.Parent = window.ContentArea
    
    local self = setmetatable({
        Instance = tabContainer,
        Layout = UIListLayout,
        Title = config.Title or "Tab",
        Sections = {},
        Window = window,
    }, Tab)
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    return self
end

function Tab:AddSection(config)
    local section = Section.new(self.Instance, config)
    table.insert(self.Sections, section)
    return section
end

function Tab:Show()
    self.Instance.Visible = true
    Animation.Tween(self.Instance, {ScrollBarImageTransparency = 0})
end

function Tab:Hide()
    self.Instance.Visible = false
end

return Tab

end}

LunarUI_Modules['Theme'] = {IsLoaded = false, Func = function()
local script = {}
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

end}

LunarUI_Modules['Types'] = {IsLoaded = false, Func = function()
local script = {}
-- Lunar UI Types
export type Theme = {
    Name: string,
    MainColor: Color3,
    AccentColor: Color3,
    BackgroundColor: Color3,
    TextColor: Color3,
    SubTextColor: Color3,
    BorderColor: Color3,
    BackgroundTransparency: number,
    BlurIntensity: number,
    CornerRadius: UDim,
    Font: Font,
    AnimationSpeed: number,
}

export type LunarUI = {
    CreateWindow: (self: LunarUI, config: WindowConfig) -> Window,
    Notify: (self: LunarUI, config: NotificationConfig) -> (),
}

export type WindowConfig = {
    Title: string,
    Subtitle: string?,
    Theme: string?,
}

export type Window = {
    AddTab: (self: Window, config: TabConfig) -> Tab,
}

export type TabConfig = {
    Title: string,
    Icon: string?,
}

export type Tab = {
    AddSection: (self: Tab, config: SectionConfig) -> Section,
}

export type SectionConfig = {
    Title: string,
}

export type Section = {
    AddButton: (self: Section, config: any) -> any,
    AddToggle: (self: Section, config: any) -> any,
    AddSlider: (self: Section, config: any) -> any,
    AddDropdown: (self: Section, config: any) -> any,
    AddMultiDropdown: (self: Section, config: any) -> any,
    AddTextbox: (self: Section, config: any) -> any,
    AddKeybind: (self: Section, config: any) -> any,
    AddColorPicker: (self: Section, config: any) -> any,
    AddLabel: (self: Section, config: any) -> any,
    AddParagraph: (self: Section, config: any) -> any,
    AddSeparator: (self: Section) -> any,
    AddImage: (self: Section, config: any) -> any,
}

export type NotificationConfig = {
    Title: string,
    Content: string,
    Duration: number?,
    Type: string?,
}

return {}

end}

LunarUI_Modules['Window'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Input = require("Input")
local Animation = require("Animation")
local Search = require("Search")
local Tab = require("Tab")

local Window = {}
Window.__index = Window

function Window.new(config)
    local theme = ThemeSystem.GetTheme()
    
    local mainFrame = InstanceUtil.new("Frame", {
        Name = "LunarUI_Main",
        Size = UDim2.new(0, 700, 0, 450),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.MainColor,
        BackgroundTransparency = theme.BackgroundTransparency,
        ClipsDescendants = true,
    })
    InstanceUtil.ApplyCorner(mainFrame, theme.CornerRadius)
    InstanceUtil.ApplyStroke(mainFrame, {Color = theme.BorderColor, Transparency = theme.BorderTransparency, Thickness = 1})
    
    local titleBar = InstanceUtil.new("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
    })
    titleBar.Parent = mainFrame
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "Lunar UI",
        Font = Enum.Font.GothamBold,
        TextColor3 = theme.TextColor,
        TextSize = 16,
    })
    titleLabel.Parent = titleBar
    
    local topSeparator = InstanceUtil.new("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
    })
    topSeparator.Parent = mainFrame
    
    local sidebar = InstanceUtil.new("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 200, 1, -41),
        Position = UDim2.new(0, 0, 0, 41),
        BackgroundTransparency = 1,
    })
    sidebar.Parent = mainFrame
    
    local sidebarSeparator = InstanceUtil.new("Frame", {
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
    })
    sidebarSeparator.Parent = sidebar
    
    local searchBox = InstanceUtil.new("TextBox", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = theme.BorderColor,
        BackgroundTransparency = 0.9,
        PlaceholderText = "Search...",
        Text = "",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.TextColor,
        PlaceholderColor3 = theme.SubTextColor,
        TextSize = 13,
    })
    InstanceUtil.ApplyCorner(searchBox, UDim.new(0, 6))
    InstanceUtil.ApplyStroke(searchBox, {Color = theme.BorderColor, Transparency = 0.8, Thickness = 1})
    searchBox.Parent = sidebar
    
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        Search.UpdateQuery(searchBox.Text)
    end)
    
    local tabsList = InstanceUtil.new("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -60),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
    })
    local tabsLayout = InstanceUtil.new("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    tabsLayout.Parent = tabsList
    tabsList.Parent = sidebar
    
    local contentArea = InstanceUtil.new("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -200, 1, -41),
        Position = UDim2.new(0, 200, 0, 41),
        BackgroundTransparency = 1,
    })
    contentArea.Parent = mainFrame
    
    Input.MakeDraggable(mainFrame, titleBar)
    
    local self = setmetatable({
        Instance = mainFrame,
        ContentArea = contentArea,
        TabsList = tabsList,
        Tabs = {},
        ActiveTab = nil,
        Buttons = {},
    }, Window)
    
    return self
end

function Window:AddTab(config)
    local tab = Tab.new(self, config)
    local theme = ThemeSystem.GetTheme()
    
    local tabBtn = InstanceUtil.new("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = theme.AccentColor,
        BackgroundTransparency = 1,
        Text = config.Title or "Tab",
        Font = Enum.Font.Gotham,
        TextColor3 = theme.SubTextColor,
        TextSize = 14,
        AutoButtonColor = false,
    })
    InstanceUtil.ApplyCorner(tabBtn, UDim.new(0, 6))
    local btnStroke = InstanceUtil.ApplyStroke(tabBtn, {Color = theme.BorderColor, Transparency = 1, Thickness = 1})
    tabBtn.Parent = self.TabsList
    
    table.insert(self.Tabs, tab)
    table.insert(self.Buttons, tabBtn)
    
    tabBtn.MouseButton1Click:Connect(function()
        self:SelectTab(tab, tabBtn, btnStroke)
    end)
    
    if not self.ActiveTab then
        self:SelectTab(tab, tabBtn, btnStroke)
    end
    
    return tab
end

function Window:SelectTab(tab, tabBtn, btnStroke)
    local theme = ThemeSystem.GetTheme()
    if self.ActiveTab then
        self.ActiveTab:Hide()
    end
    
    for i, btn in ipairs(self.Buttons) do
        Animation.Tween(btn, {BackgroundTransparency = 1, TextColor3 = theme.SubTextColor})
        Animation.Tween(btn:FindFirstChild("UIStroke"), {Transparency = 1})
    end
    
    self.ActiveTab = tab
    self.ActiveTab:Show()
    
    Animation.Tween(tabBtn, {BackgroundTransparency = 0.8, TextColor3 = theme.TextColor})
    Animation.Tween(btnStroke, {Transparency = 0.7})
end

return Window

end}

LunarUI_Modules['Button'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)

return function(parent, config")
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

end}

LunarUI_Modules['ColorPicker'] = {IsLoaded = false, Func = function()
local script = {}
return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end

end}

LunarUI_Modules['Dropdown'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)

return function(parent, config")
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

end}

LunarUI_Modules['Image'] = {IsLoaded = false, Func = function()
local script = {}
return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end

end}

LunarUI_Modules['Keybind'] = {IsLoaded = false, Func = function()
local script = {}
return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end

end}

LunarUI_Modules['Label'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme)

return function(parent, config")
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

end}

LunarUI_Modules['MultiDropdown'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)

return function(parent, config")
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
                if not selectedValue then selectedValue = {} end; selectedValue[val] = not selectedValue[val]
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

end}

LunarUI_Modules['Paragraph'] = {IsLoaded = false, Func = function()
local script = {}
return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end

end}

LunarUI_Modules['Separator'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme)

return function(parent")
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

end}

LunarUI_Modules['Slider'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)
local UserInputService = game:GetService("UserInputService")

return function(parent, config")
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

end}

LunarUI_Modules['Textbox'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)

return function(parent, config")
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

end}

LunarUI_Modules['Toggle'] = {IsLoaded = false, Func = function()
local script = {}
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")
local Animation = require("Animation)

return function(parent, config")
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

end}

LunarUI_Modules['Animation'] = {IsLoaded = false, Func = function()
local script = {}
local TweenService = game:GetService("TweenService")
local ThemeSystem = require("Theme")

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

end}

LunarUI_Modules['Input'] = {IsLoaded = false, Func = function()
local script = {}
local UserInputService = game:GetService("UserInputService")
local Signal = require("Signal")

local Input = {
    OnInputBegan = Signal.new(),
    OnInputEnded = Signal.new(),
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        Input.OnInputBegan:Fire(input)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed then
        Input.OnInputEnded:Fire(input)
    end
end)

function Input.MakeDraggable(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

return Input

end}

LunarUI_Modules['Notification'] = {IsLoaded = false, Func = function()
local script = {}
local Animation = require("Animation")
local InstanceUtil = require("Instance")
local ThemeSystem = require("Theme")

local Notification = {}
local Container = nil

function Notification.Init(parentGui)
    if not Container then
        Container = InstanceUtil.new("Frame", {
            Name = "NotificationContainer",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -20, 1, -20),
            Size = UDim2.new(0, 300, 1, -40),
            AnchorPoint = Vector2.new(1, 1),
            ZIndex = 1000,
        })
        
        local UIListLayout = InstanceUtil.new("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, 10)
        })
        UIListLayout.Parent = Container
        Container.Parent = parentGui
    end
end

function Notification.Notify(config)
    if not Container then return end
    
    local theme = ThemeSystem.GetTheme()
    
    local notifFrame = InstanceUtil.new("Frame", {
        Name = "Notification",
        Size = UDim2.new(1, 0, 0, 80),
        BackgroundColor3 = theme.MainColor,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 50, 0, 0),
    })
    
    InstanceUtil.ApplyCorner(notifFrame, theme.CornerRadius)
    InstanceUtil.ApplyStroke(notifFrame, {
        Color = theme.BorderColor,
        Transparency = 1,
        Thickness = 1
    })
    
    local titleLabel = InstanceUtil.new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 10),
        Size = UDim2.new(1, -30, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = config.Title or "Notification",
        TextColor3 = theme.TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1,
    })
    titleLabel.Parent = notifFrame
    
    local contentLabel = InstanceUtil.new("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 35),
        Size = UDim2.new(1, -30, 0, 35),
        Font = Enum.Font.Gotham,
        Text = config.Content or "",
        TextColor3 = theme.SubTextColor,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        TextTransparency = 1,
    })
    contentLabel.Parent = notifFrame
    
    notifFrame.Parent = Container
    
    Animation.Tween(notifFrame, {BackgroundTransparency = theme.BackgroundTransparency, Position = UDim2.new(0, 0, 0, 0)})
    Animation.Tween(notifFrame.UIStroke, {Transparency = theme.BorderTransparency})
    Animation.Tween(titleLabel, {TextTransparency = 0})
    Animation.Tween(contentLabel, {TextTransparency = 0})
    
    task.delay(config.Duration or 3, function()
        if notifFrame and notifFrame.Parent then
            Animation.Tween(notifFrame, {BackgroundTransparency = 1, Position = UDim2.new(1, 50, 0, 0)})
            Animation.Tween(notifFrame.UIStroke, {Transparency = 1})
            Animation.Tween(titleLabel, {TextTransparency = 1})
            Animation.Tween(contentLabel, {TextTransparency = 1})
            task.wait(theme.AnimationSpeed)
            notifFrame:Destroy()
        end
    end)
end

return Notification

end}

LunarUI_Modules['Search'] = {IsLoaded = false, Func = function()
local script = {}
local Signal = require("Signal")

local Search = {
    OnSearchQueryChanged = Signal.new(),
    CurrentQuery = ""
}

function Search.UpdateQuery(query)
    Search.CurrentQuery = string.lower(query)
    Search.OnSearchQueryChanged:Fire(Search.CurrentQuery)
end

function Search.Match(text)
    if Search.CurrentQuery == "" then return true end
    return string.find(string.lower(text), Search.CurrentQuery) ~= nil
end

return Search

end}

LunarUI_Modules['Instance'] = {IsLoaded = false, Func = function()
local script = {}
-- Instance Utility for declarative UI creation
local InstanceUtil = {}
local ThemeSystem = require("Theme")

function InstanceUtil.new(className, properties, children)
    local inst = Instance.new(className)
    
    if properties then
        for k, v in pairs(properties) do
            if k ~= "ThemeTag" then
                inst[k] = v
            end
        end
    end
    
    if children then
        for _, child in pairs(children) do
            if typeof(child) == "Instance" then
                child.Parent = inst
            end
        end
    end
    
    return inst
end

function InstanceUtil.ApplyCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or ThemeSystem.GetTheme().CornerRadius
    corner.Parent = instance
    return corner
end

function InstanceUtil.ApplyStroke(instance, properties)
    local stroke = Instance.new("UIStroke")
    if properties then
        for k, v in pairs(properties) do
            stroke[k] = v
        end
    end
    stroke.Parent = instance
    return stroke
end

return InstanceUtil

end}

LunarUI_Modules['Signal'] = {IsLoaded = false, Func = function()
local script = {}
-- Signal (Custom Event System)
local Signal = {}
Signal.__index = Signal

function Signal.new()
    return setmetatable({
        _connections = {}
    }, Signal)
end

function Signal:Connect(callback)
    local connection = {
        Callback = callback,
        Disconnect = function(selfConn)
            for i, conn in ipairs(self._connections) do
                if conn == selfConn then
                    table.remove(self._connections, i)
                    break
                end
            end
        end
    }
    table.insert(self._connections, connection)
    return connection
end

function Signal:Fire(...)
    for _, connection in ipairs(self._connections) do
        task.spawn(connection.Callback, ...)
    end
end

function Signal:Destroy()
    self._connections = {}
end

return Signal

end}

LunarUI_Modules['Utility'] = {IsLoaded = false, Func = function()
local script = {}
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

end}

return require('LunarUI')

