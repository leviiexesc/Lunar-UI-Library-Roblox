$SrcPath = "C:\Users\sovan\.gemini\antigravity\scratch\LunarUI\src"

# Section.lua
$Section = @"
local InstanceUtil = require(script.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Theme)
local Config = require(script.Parent.Config)

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
local ComponentsPath = script.Parent.Components
for _, componentModule in ipairs(ComponentsPath:GetChildren()) do
    if componentModule:IsA("ModuleScript") then
        local componentName = componentModule.Name
        Section["Add" .. componentName] = function(self, config)
            local componentConstructor = require(componentModule)
            return componentConstructor(self.Container, config)
        end
    end
end

return Section
"@

# Tab.lua
$Tab = @"
local InstanceUtil = require(script.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Theme)
local Config = require(script.Parent.Config)
local Section = require(script.Parent.Section)
local Animation = require(script.Parent.Services.Animation)

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
"@

# Window.lua
$Window = @"
local InstanceUtil = require(script.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Theme)
local Input = require(script.Parent.Services.Input)
local Animation = require(script.Parent.Services.Animation)
local Search = require(script.Parent.Services.Search)
local Tab = require(script.Parent.Tab)

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
"@

# LunarUI.lua
$LunarUI = @"
local Config = require(script.Config)
local ThemeSystem = require(script.Theme)
local Window = require(script.Window)
local Notification = require(script.Services.Notification)
local Animation = require(script.Services.Animation)
local InstanceUtil = require(script.Utils.Instance)

local LunarUI = {}
LunarUI.Types = require(script.Types)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local function GetParentGui()
    local success, parent = pcall(function()
        return CoreGui
    end)
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
"@

Set-Content -Path "$SrcPath\Section.lua" -Value $Section
Set-Content -Path "$SrcPath\Tab.lua" -Value $Tab
Set-Content -Path "$SrcPath\Window.lua" -Value $Window
Set-Content -Path "$SrcPath\LunarUI.lua" -Value $LunarUI

Write-Host "Created Core files"
