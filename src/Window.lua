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
