-- Lunar UI - Premium Liquid Glass UI Library for Roblox
-- Version 2.0.0 - Fully Functional

local Lunar = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ────────────────────────────────────────────────────────────
-- UTILITY FUNCTIONS
-- ────────────────────────────────────────────────────────────

local function Tween(obj, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    duration = duration or 0.3
    local tweenInfo = TweenInfo.new(duration, style, direction, 0, false, 0)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

local function CreateCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = obj
    return corner
end

local function CreateStroke(obj, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.8
    stroke.Parent = obj
    return stroke
end

-- ────────────────────────────────────────────────────────────
-- LUNAR UI MAIN CLASS
-- ────────────────────────────────────────────────────────────

function Lunar:CreateWindow(config)
    config = config or {}
    local window = {}
    
    -- Window Properties
    window.Title = config.Title or "Lunar UI"
    window.Theme = config.Theme or "LiquidGlass"
    window.Visible = true
    
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LunarUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    
    -- ────────────────────────────────────────────────────────────
    -- MAIN WINDOW
    -- ────────────────────────────────────────────────────────────
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 860, 0, 580)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
    mainFrame.BackgroundTransparency = 0.45
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    
    -- Glass effect with multiple layers
    local glassLayer = Instance.new("Frame")
    glassLayer.Name = "GlassLayer"
    glassLayer.Parent = mainFrame
    glassLayer.Size = UDim2.new(1, 0, 1, 0)
    glassLayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    glassLayer.BackgroundTransparency = 0.97
    glassLayer.BorderSizePixel = 0
    
    -- Main border
    local mainBorder = Instance.new("Frame")
    mainBorder.Name = "MainBorder"
    mainBorder.Parent = mainFrame
    mainBorder.Size = UDim2.new(1, 0, 1, 0)
    mainBorder.BackgroundTransparency = 1
    mainBorder.BorderSizePixel = 0
    
    local borderStroke = Instance.new("UIStroke")
    borderStroke.Color = Color3.fromRGB(255, 255, 255)
    borderStroke.Thickness = 1
    borderStroke.Transparency = 0.85
    borderStroke.Parent = mainBorder
    
    CreateCorner(mainFrame, 24)
    CreateCorner(glassLayer, 24)
    CreateCorner(mainBorder, 24)
    
    -- Inner glow
    local innerGlow = Instance.new("Frame")
    innerGlow.Name = "InnerGlow"
    innerGlow.Parent = mainFrame
    innerGlow.Size = UDim2.new(1, -4, 1, -4)
    innerGlow.Position = UDim2.new(0, 2, 0, 2)
    innerGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    innerGlow.BackgroundTransparency = 0.98
    innerGlow.BorderSizePixel = 0
    
    local glowStroke = Instance.new("UIStroke")
    glowStroke.Color = Color3.fromRGB(180, 160, 255)
    glowStroke.Thickness = 1
    glowStroke.Transparency = 0.9
    glowStroke.Parent = innerGlow
    CreateCorner(innerGlow, 22)
    
    -- ────────────────────────────────────────────────────────────
    -- TITLE BAR
    -- ────────────────────────────────────────────────────────────
    
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = mainFrame
    titleBar.Size = UDim2.new(1, 0, 0, 52)
    titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.BackgroundTransparency = 0.98
    titleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 24)
    titleCorner.Parent = titleBar
    
    -- Title with icon
    local titleGroup = Instance.new("Frame")
    titleGroup.Name = "TitleGroup"
    titleGroup.Parent = titleBar
    titleGroup.Size = UDim2.new(0, 180, 1, 0)
    titleGroup.Position = UDim2.new(0, 20, 0, 0)
    titleGroup.BackgroundTransparency = 1
    
    -- Crescent moon icon (using text for simplicity)
    local moonIcon = Instance.new("TextLabel")
    moonIcon.Name = "MoonIcon"
    moonIcon.Parent = titleGroup
    moonIcon.Size = UDim2.new(0, 24, 0, 24)
    moonIcon.Position = UDim2.new(0, 0, 0.5, -12)
    moonIcon.BackgroundTransparency = 1
    moonIcon.Text = "☽"
    moonIcon.TextColor3 = Color3.fromRGB(200, 180, 255)
    moonIcon.TextSize = 20
    moonIcon.Font = Enum.Font.Gotham
    moonIcon.TextTransparency = 0.2
    
    -- Glow behind moon
    local moonGlow = Instance.new("Frame")
    moonGlow.Name = "MoonGlow"
    moonGlow.Parent = titleGroup
    moonGlow.Size = UDim2.new(0, 40, 0, 40)
    moonGlow.Position = UDim2.new(0, -8, 0.5, -20)
    moonGlow.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
    moonGlow.BackgroundTransparency = 0.95
    moonGlow.BorderSizePixel = 0
    CreateCorner(moonGlow, 20)
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Parent = titleGroup
    titleText.Size = UDim2.new(1, -30, 1, 0)
    titleText.Position = UDim2.new(0, 30, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = window.Title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.TextTransparency = 0.1
    
    -- Window Controls
    local controls = {
        { Name = "Minimize", Color = Color3.fromRGB(255, 200, 60), Trans = 0.7 },
        { Name = "Maximize", Color = Color3.fromRGB(100, 200, 130), Trans = 0.6 },
        { Name = "Close", Color = Color3.fromRGB(255, 90, 90), Trans = 0.7 }
    }
    
    for i, control in ipairs(controls) do
        local btn = Instance.new("TextButton")
        btn.Name = control.Name
        btn.Parent = titleBar
        btn.Size = UDim2.new(0, 14, 0, 14)
        btn.Position = UDim2.new(1, -(48 + (3 - i) * 24), 0.5, -7)
        btn.BackgroundColor3 = control.Color
        btn.BackgroundTransparency = control.Trans
        btn.BorderSizePixel = 0
        btn.Text = ""
        btn.AutoButtonColor = false
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(1, 0)
        btnCorner.Parent = btn
        
        -- Hover effect
        local hover = Instance.new("Frame")
        hover.Name = "Hover"
        hover.Parent = btn
        hover.Size = UDim2.new(1, 0, 1, 0)
        hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hover.BackgroundTransparency = 0.9
        hover.BorderSizePixel = 0
        local hoverCorner = Instance.new("UICorner")
        hoverCorner.CornerRadius = UDim.new(1, 0)
        hoverCorner.Parent = hover
        
        btn.MouseEnter:Connect(function()
            Tween(hover, {BackgroundTransparency = 0.6}, 0.15)
        end)
        btn.MouseLeave:Connect(function()
            Tween(hover, {BackgroundTransparency = 0.9}, 0.15)
        end)
        
        -- Close functionality
        if control.Name == "Close" then
            btn.MouseButton1Click:Connect(function()
                Tween(mainFrame, {BackgroundTransparency = 1}, 0.3)
                Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                task.wait(0.35)
                mainFrame.Visible = false
                window.Visible = false
                -- Show reopen button
                reopenBtn.Visible = true
            end)
        end
    end
    
    -- ────────────────────────────────────────────────────────────
    -- SIDEBAR
    -- ────────────────────────────────────────────────────────────
    
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = mainFrame
    sidebar.Size = UDim2.new(0, 180, 1, -52)
    sidebar.Position = UDim2.new(0, 0, 0, 52)
    sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sidebar.BackgroundTransparency = 0.98
    sidebar.BorderSizePixel = 0
    
    -- Sidebar divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Parent = sidebar
    divider.Size = UDim2.new(0, 1, 1, -40)
    divider.Position = UDim2.new(1, -1, 0, 20)
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.BackgroundTransparency = 0.9
    divider.BorderSizePixel = 0
    
    -- Search Box
    local searchBox = Instance.new("Frame")
    searchBox.Name = "SearchBox"
    searchBox.Parent = sidebar
    searchBox.Size = UDim2.new(0.85, 0, 0, 36)
    searchBox.Position = UDim2.new(0.075, 0, 0, 16)
    searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BackgroundTransparency = 0.93
    searchBox.BorderSizePixel = 1
    searchBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BorderSizePixel = 1
    searchBox.BorderColor3 = Color3.fromRGB(200, 200, 200)
    searchBox.ClipsDescendants = true
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(1, 0)
    searchCorner.Parent = searchBox
    
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Name = "Icon"
    searchIcon.Parent = searchBox
    searchIcon.Size = UDim2.new(0, 24, 1, 0)
    searchIcon.Position = UDim2.new(0, 8, 0, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "⌕"
    searchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
    searchIcon.TextSize = 16
    searchIcon.Font = Enum.Font.Gotham
    
    local searchInput = Instance.new("TextBox")
    searchInput.Name = "Input"
    searchInput.Parent = searchBox
    searchInput.Size = UDim2.new(1, -36, 1, 0)
    searchInput.Position = UDim2.new(0, 32, 0, 0)
    searchInput.BackgroundTransparency = 1
    searchInput.Text = ""
    searchInput.PlaceholderText = "Search..."
    searchInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    searchInput.TextColor3 = Color3.fromRGB(200, 200, 200)
    searchInput.TextSize = 13
    searchInput.Font = Enum.Font.Gotham
    searchInput.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Navigation Buttons
    window.Tabs = {}
    window.TabButtons = {}
    window.CurrentTab = nil
    
    local navContainer = Instance.new("Frame")
    navContainer.Name = "NavContainer"
    navContainer.Parent = sidebar
    navContainer.Size = UDim2.new(1, 0, 0, 200)
    navContainer.Position = UDim2.new(0, 0, 0, 70)
    navContainer.BackgroundTransparency = 1
    
    local function CreateNavButton(tabName, isActive)
        local btn = Instance.new("TextButton")
        btn.Name = tabName
        btn.Parent = navContainer
        btn.Size = UDim2.new(0.85, 0, 0, 40)
        btn.Position = UDim2.new(0.075, 0, 0, (#window.TabButtons) * 46)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = isActive and 0.92 or 0.98
        btn.BorderSizePixel = isActive and 1 or 0
        btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
        btn.Text = tabName
        btn.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Center
        btn.TextYAlignment = Enum.TextYAlignment.Center
        btn.AutoButtonColor = false
        btn.ClipsDescendants = true
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 12)
        btnCorner.Parent = btn
        
        -- Active indicator
        local indicator = Instance.new("Frame")
        indicator.Name = "Indicator"
        indicator.Parent = btn
        indicator.Size = UDim2.new(0, 3, 0.6, 0)
        indicator.Position = UDim2.new(0, 4, 0.2, 0)
        indicator.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
        indicator.BackgroundTransparency = isActive and 0.3 or 1
        indicator.BorderSizePixel = 0
        CreateCorner(indicator, 2)
        
        btn.MouseEnter:Connect(function()
            if not isActive then
                Tween(btn, {BackgroundTransparency = 0.94}, 0.15)
                Tween(btn, {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.15)
            end
        end)
        btn.MouseLeave:Connect(function()
            if not isActive then
                Tween(btn, {BackgroundTransparency = 0.98}, 0.15)
                Tween(btn, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.15)
            end
        end)
        
        return btn, indicator
    end
    
    -- ────────────────────────────────────────────────────────────
    -- CONTENT AREA
    -- ────────────────────────────────────────────────────────────
    
    local contentArea = Instance.new("ScrollingFrame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = mainFrame
    contentArea.Size = UDim2.new(1, -200, 1, -72)
    contentArea.Position = UDim2.new(0, 190, 0, 62)
    contentArea.BackgroundTransparency = 1
    contentArea.BorderSizePixel = 0
    contentArea.ScrollBarThickness = 4
    contentArea.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    contentArea.ScrollBarImageTransparency = 0.8
    contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- ────────────────────────────────────────────────────────────
    -- WINDOW METHODS
    -- ────────────────────────────────────────────────────────────
    
    function window:AddTab(config)
        config = config or {}
        local tabName = config.Title or "Tab"
        local tab = {}
        tab.Title = tabName
        tab.Sections = {}
        tab.Frame = nil
        
        -- Create tab content frame
        local tabFrame = Instance.new("Frame")
        tabFrame.Name = tabName
        tabFrame.Parent = contentArea
        tabFrame.Size = UDim2.new(1, 0, 0, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.Visible = not window.CurrentTab
        tabFrame.AutomaticSize = Enum.AutomaticSize.Y
        
        tab.Frame = tabFrame
        
        -- Create nav button
        local isActive = not window.CurrentTab
        local btn, indicator = CreateNavButton(tabName, isActive)
        window.TabButtons[tabName] = { Button = btn, Indicator = indicator }
        
        btn.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, t in pairs(window.Tabs) do
                if t.Frame then
                    t.Frame.Visible = false
                end
            end
            
            -- Show this tab
            tabFrame.Visible = true
            
            -- Update nav buttons
            for name, data in pairs(window.TabButtons) do
                local isCurrent = (name == tabName)
                Tween(data.Button, {BackgroundTransparency = isCurrent and 0.92 or 0.98}, 0.2)
                Tween(data.Button, {TextColor3 = isCurrent and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)}, 0.2)
                data.Button.BorderSizePixel = isCurrent and 1 or 0
                Tween(data.Indicator, {BackgroundTransparency = isCurrent and 0.3 or 1}, 0.2)
            end
            
            window.CurrentTab = tab
        end)
        
        table.insert(window.Tabs, tab)
        if not window.CurrentTab then
            window.CurrentTab = tab
        end
        
        function tab:AddSection(config)
            config = config or {}
            local section = {}
            section.Title = config.Title or "Section"
            section.Elements = {}
            
            -- Create section frame
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = section.Title
            sectionFrame.Parent = tabFrame
            sectionFrame.Size = UDim2.new(1, -24, 0, 0)
            sectionFrame.Position = UDim2.new(0, 12, 0, 12)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionFrame.BackgroundTransparency = 0.95
            sectionFrame.BorderSizePixel = 0
            sectionFrame.ClipsDescendants = true
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            
            CreateCorner(sectionFrame, 20)
            
            -- Section border
            local sectionBorder = Instance.new("UIStroke")
            sectionBorder.Color = Color3.fromRGB(255, 255, 255)
            sectionBorder.Thickness = 1
            sectionBorder.Transparency = 0.88
            sectionBorder.Parent = sectionFrame
            
            -- Section Title
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Parent = sectionFrame
            sectionTitle.Size = UDim2.new(1, -40, 0, 44)
            sectionTitle.Position = UDim2.new(0, 20, 0, 8)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = section.Title
            sectionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
            sectionTitle.TextSize = 15
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.TextYAlignment = Enum.TextYAlignment.Center
            
            local elementsContainer = Instance.new("Frame")
            elementsContainer.Name = "ElementsContainer"
            elementsContainer.Parent = sectionFrame
            elementsContainer.Size = UDim2.new(1, -40, 0, 0)
            elementsContainer.Position = UDim2.new(0, 20, 0, 52)
            elementsContainer.BackgroundTransparency = 1
            elementsContainer.AutomaticSize = Enum.AutomaticSize.Y
            
            section.Container = elementsContainer
            section.Frame = sectionFrame
            section.ElementsContainer = elementsContainer
            
            -- Store section
            table.insert(section.Elements, section)
            table.insert(tab.Sections, section)
            
            function section:AddButton(config)
                config = config or {}
                local element = {}
                element.Type = "Button"
                element.Title = config.Title or "Button"
                element.Text = config.Text or "Click Me"
                element.Callback = config.Callback or function() end
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                
                -- Bottom divider
                local dividerLine = Instance.new("Frame")
                dividerLine.Name = "DividerLine"
                dividerLine.Parent = row
                dividerLine.Size = UDim2.new(1, 0, 0, 1)
                dividerLine.Position = UDim2.new(0, 0, 1, -1)
                dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dividerLine.BackgroundTransparency = 0.95
                dividerLine.BorderSizePixel = 0
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(190, 190, 190)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                local btn = Instance.new("TextButton")
                btn.Name = "Button"
                btn.Parent = row
                btn.Size = UDim2.new(0, 120, 0, 34)
                btn.Position = UDim2.new(0.5, 20, 0.5, -17)
                btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundTransparency = 0.93
                btn.BorderSizePixel = 1
                btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = element.Text
                btn.TextColor3 = Color3.fromRGB(210, 210, 210)
                btn.TextSize = 13
                btn.Font = Enum.Font.Gotham
                btn.AutoButtonColor = false
                btn.ClipsDescendants = true
                
                CreateCorner(btn, 20)
                
                btn.MouseEnter:Connect(function()
                    Tween(btn, {BackgroundTransparency = 0.85}, 0.15)
                    Tween(btn, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                    Tween(btn, {BorderColor3 = Color3.fromRGB(200, 180, 255)}, 0.15)
                end)
                btn.MouseLeave:Connect(function()
                    Tween(btn, {BackgroundTransparency = 0.93}, 0.15)
                    Tween(btn, {TextColor3 = Color3.fromRGB(210, 210, 210)}, 0.15)
                    Tween(btn, {BorderColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                end)
                
                btn.MouseButton1Click:Connect(function()
                    if element.Callback then
                        element.Callback()
                    end
                end)
                
                element.Row = row
                return element
            end
            
            function section:AddToggle(config)
                config = config or {}
                local element = {}
                element.Type = "Toggle"
                element.Title = config.Title or "Toggle"
                element.Default = config.Default or false
                element.Callback = config.Callback or function() end
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                
                local dividerLine = Instance.new("Frame")
                dividerLine.Name = "DividerLine"
                dividerLine.Parent = row
                dividerLine.Size = UDim2.new(1, 0, 0, 1)
                dividerLine.Position = UDim2.new(0, 0, 1, -1)
                dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dividerLine.BackgroundTransparency = 0.95
                dividerLine.BorderSizePixel = 0
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(190, 190, 190)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                local toggle = Instance.new("Frame")
                toggle.Name = "Toggle"
                toggle.Parent = row
                toggle.Size = UDim2.new(0, 48, 0, 26)
                toggle.Position = UDim2.new(0.5, 20, 0.5, -13)
                toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggle.BackgroundTransparency = 0.9
                toggle.BorderSizePixel = 1
                toggle.BorderColor3 = Color3.fromRGB(200, 200, 200)
                toggle.ClipsDescendants = true
                
                CreateCorner(toggle, 13)
                
                local knob = Instance.new("Frame")
                knob.Name = "Knob"
                knob.Parent = toggle
                knob.Size = UDim2.new(0, 20, 0, 20)
                knob.Position = UDim2.new(0, 3, 0.5, -10)
                knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                knob.BackgroundTransparency = 0.2
                knob.BorderSizePixel = 0
                
                CreateCorner(knob, 10)
                
                element.Toggle = toggle
                element.Knob = knob
                element.Active = element.Default
                
                local function UpdateToggle(value)
                    element.Active = value
                    if value then
                        Tween(toggle, {BackgroundTransparency = 0.7}, 0.25)
                        Tween(toggle, {BorderColor3 = Color3.fromRGB(120, 200, 160)}, 0.25)
                        Tween(knob, {Position = UDim2.new(0, 25, 0.5, -10)}, 0.25)
                        Tween(knob, {BackgroundColor3 = Color3.fromRGB(200, 240, 220)}, 0.25)
                    else
                        Tween(toggle, {BackgroundTransparency = 0.9}, 0.25)
                        Tween(toggle, {BorderColor3 = Color3.fromRGB(200, 200, 200)}, 0.25)
                        Tween(knob, {Position = UDim2.new(0, 3, 0.5, -10)}, 0.25)
                        Tween(knob, {BackgroundColor3 = Color3.fromRGB(220, 220, 220)}, 0.25)
                    end
                end
                
                UpdateToggle(element.Default)
                
                toggle.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateToggle(not element.Active)
                        if element.Callback then
                            element.Callback(element.Active)
                        end
                    end
                end)
                
                element.Row = row
                element.Update = UpdateToggle
                return element
            end
            
            function section:AddSlider(config)
                config = config or {}
                local element = {}
                element.Type = "Slider"
                element.Title = config.Title or "Slider"
                element.Min = config.Min or 0
                element.Max = config.Max or 100
                element.Default = config.Default or 50
                element.Callback = config.Callback or function() end
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                
                local dividerLine = Instance.new("Frame")
                dividerLine.Name = "DividerLine"
                dividerLine.Parent = row
                dividerLine.Size = UDim2.new(1, 0, 0, 1)
                dividerLine.Position = UDim2.new(0, 0, 1, -1)
                dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dividerLine.BackgroundTransparency = 0.95
                dividerLine.BorderSizePixel = 0
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(190, 190, 190)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                local sliderContainer = Instance.new("Frame")
                sliderContainer.Name = "SliderContainer"
                sliderContainer.Parent = row
                sliderContainer.Size = UDim2.new(0, 160, 0, 30)
                sliderContainer.Position = UDim2.new(0.5, 20, 0.5, -15)
                sliderContainer.BackgroundTransparency = 1
                
                -- Track
                local track = Instance.new("Frame")
                track.Name = "Track"
                track.Parent = sliderContainer
                track.Size = UDim2.new(1, -50, 0, 4)
                track.Position = UDim2.new(0, 0, 0.5, -2)
                track.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                track.BackgroundTransparency = 0.85
                track.BorderSizePixel = 0
                CreateCorner(track, 2)
                
                -- Fill
                local fill = Instance.new("Frame")
                fill.Name = "Fill"
                fill.Parent = track
                fill.Size = UDim2.new(0.5, 0, 1, 0)
                fill.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
                fill.BackgroundTransparency = 0.5
                fill.BorderSizePixel = 0
                CreateCorner(fill, 2)
                
                -- Handle
                local handle = Instance.new("Frame")
                handle.Name = "Handle"
                handle.Parent = track
                handle.Size = UDim2.new(0, 16, 0, 16)
                handle.Position = UDim2.new(0.5, -8, 0.5, -8)
                handle.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                handle.BackgroundTransparency = 0.15
                handle.BorderSizePixel = 1
                handle.BorderColor3 = Color3.fromRGB(200, 200, 200)
                CreateCorner(handle, 8)
                
                -- Glow around handle
                local handleGlow = Instance.new("Frame")
                handleGlow.Name = "HandleGlow"
                handleGlow.Parent = handle
                handleGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
                handleGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
                handleGlow.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
                handleGlow.BackgroundTransparency = 0.95
                handleGlow.BorderSizePixel = 0
                CreateCorner(handleGlow, 12)
                
                -- Value Display
                local valueDisplay = Instance.new("TextLabel")
                valueDisplay.Name = "Value"
                valueDisplay.Parent = sliderContainer
                valueDisplay.Size = UDim2.new(0, 40, 1, 0)
                valueDisplay.Position = UDim2.new(1, -40, 0, 0)
                valueDisplay.BackgroundTransparency = 1
                valueDisplay.Text = tostring(element.Default)
                valueDisplay.TextColor3 = Color3.fromRGB(160, 160, 160)
                valueDisplay.TextSize = 13
                valueDisplay.Font = Enum.Font.Gotham
                valueDisplay.TextXAlignment = Enum.TextXAlignment.Right
                
                element.Value = element.Default
                
                local function UpdateSlider(value)
                    local clamped = math.clamp(value, element.Min, element.Max)
                    element.Value = clamped
                    local percent = (clamped - element.Min) / (element.Max - element.Min)
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    handle.Position = UDim2.new(percent, -8, 0.5, -8)
                    valueDisplay.Text = tostring(math.round(clamped))
                    
                    if element.Callback then
                        element.Callback(clamped)
                    end
                end
                
                UpdateSlider(element.Default)
                
                local dragging = false
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        local pos = input.Position.X
                        local size = track.AbsoluteSize.X
                        local percent = math.clamp((pos - track.AbsolutePosition.X) / size, 0, 1)
                        local value = element.Min + percent * (element.Max - element.Min)
                        UpdateSlider(value)
                    end
                end)
                
                track.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local pos = input.Position.X
                        local size = track.AbsoluteSize.X
                        local percent = math.clamp((pos - track.AbsolutePosition.X) / size, 0, 1)
                        local value = element.Min + percent * (element.Max - element.Min)
                        UpdateSlider(value)
                    end
                end)
                
                element.Row = row
                element.Update = UpdateSlider
                return element
            end
            
            function section:AddDropdown(config)
                config = config or {}
                local element = {}
                element.Type = "Dropdown"
                element.Title = config.Title or "Dropdown"
                element.Values = config.Values or {"Option 1", "Option 2", "Option 3"}
                element.Default = config.Default or element.Values[1]
                element.Callback = config.Callback or function() end
                element.Open = false
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                
                local dividerLine = Instance.new("Frame")
                dividerLine.Name = "DividerLine"
                dividerLine.Parent = row
                dividerLine.Size = UDim2.new(1, 0, 0, 1)
                dividerLine.Position = UDim2.new(0, 0, 1, -1)
                dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dividerLine.BackgroundTransparency = 0.95
                dividerLine.BorderSizePixel = 0
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(190, 190, 190)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                local dropdown = Instance.new("Frame")
                dropdown.Name = "Dropdown"
                dropdown.Parent = row
                dropdown.Size = UDim2.new(0, 150, 0, 34)
                dropdown.Position = UDim2.new(0.5, 20, 0.5, -17)
                dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.BackgroundTransparency = 0.93
                dropdown.BorderSizePixel = 1
                dropdown.BorderColor3 = Color3.fromRGB(200, 200, 200)
                dropdown.ClipsDescendants = true
                CreateCorner(dropdown, 12)
                
                local dropdownText = Instance.new("TextLabel")
                dropdownText.Name = "Text"
                dropdownText.Parent = dropdown
                dropdownText.Size = UDim2.new(1, -32, 1, 0)
                dropdownText.Position = UDim2.new(0, 14, 0, 0)
                dropdownText.BackgroundTransparency = 1
                dropdownText.Text = element.Default
                dropdownText.TextColor3 = Color3.fromRGB(200, 200, 200)
                dropdownText.TextSize = 13
                dropdownText.Font = Enum.Font.Gotham
                dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                dropdownText.TextYAlignment = Enum.TextYAlignment.Center
                
                local arrow = Instance.new("TextLabel")
                arrow.Name = "Arrow"
                arrow.Parent = dropdown
                arrow.Size = UDim2.new(0, 24, 1, 0)
                arrow.Position = UDim2.new(1, -24, 0, 0)
                arrow.BackgroundTransparency = 1
                arrow.Text = "▾"
                arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
                arrow.TextSize = 12
                arrow.Font = Enum.Font.Gotham
                arrow.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Dropdown Menu
                local menu = Instance.new("Frame")
                menu.Name = "Menu"
                menu.Parent = row
                menu.Size = UDim2.new(0, 150, 0, 0)
                menu.Position = UDim2.new(0.5, 20, 0.5, 20)
                menu.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                menu.BackgroundTransparency = 0.2
                menu.BorderSizePixel = 1
                menu.BorderColor3 = Color3.fromRGB(200, 200, 200)
                menu.Visible = false
                menu.ClipsDescendants = true
                menu.AutomaticSize = Enum.AutomaticSize.Y
                CreateCorner(menu, 12)
                
                local menuItems = {}
                for i, value in ipairs(element.Values) do
                    local item = Instance.new("TextButton")
                    item.Name = "Item_" .. i
                    item.Parent = menu
                    item.Size = UDim2.new(1, 0, 0, 34)
                    item.BackgroundTransparency = 1
                    item.Text = value
                    item.TextColor3 = Color3.fromRGB(180, 180, 180)
                    item.TextSize = 13
                    item.Font = Enum.Font.Gotham
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.TextYAlignment = Enum.TextYAlignment.Center
                    item.Position = UDim2.new(0, 14, 0, (i - 1) * 34)
                    item.AutoButtonColor = false
                    
                    if value == element.Default then
                        item.TextColor3 = Color3.fromRGB(200, 180, 255)
                    end
                    
                    item.MouseEnter:Connect(function()
                        Tween(item, {BackgroundTransparency = 0.9}, 0.1)
                    end)
                    item.MouseLeave:Connect(function()
                        Tween(item, {BackgroundTransparency = 1}, 0.1)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        dropdownText.Text = value
                        menu.Visible = false
                        element.Open = false
                        Tween(arrow, {Rotation = 0}, 0.2)
                        if element.Callback then
                            element.Callback(value)
                        end
                    end)
                    
                    table.insert(menuItems, item)
                end
                
                dropdown.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        element.Open = not element.Open
                        menu.Visible = element.Open
                        Tween(arrow, {Rotation = element.Open and 180 or 0}, 0.2)
                        if element.Open then
                            local itemCount = #element.Values
                            menu.Size = UDim2.new(0, 150, 0, math.min(itemCount * 34, 150))
                            Tween(menu, {BackgroundTransparency = 0.1}, 0.15)
                        end
                    end
                end)
                
                element.Row = row
                element.Menu = menu
                return element
            end
            
            function section:AddMultiDropdown(config)
                config = config or {}
                local element = {}
                element.Type = "MultiDropdown"
                element.Title = config.Title or "Multi Dropdown"
                element.Values = config.Values or {"Option 1", "Option 2", "Option 3"}
                element.Selected = {}
                element.Callback = config.Callback or function() end
                element.Open = false
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                
                local dividerLine = Instance.new("Frame")
                dividerLine.Name = "DividerLine"
                dividerLine.Parent = row
                dividerLine.Size = UDim2.new(1, 0, 0, 1)
                dividerLine.Position = UDim2.new(0, 0, 1, -1)
                dividerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dividerLine.BackgroundTransparency = 0.95
                dividerLine.BorderSizePixel = 0
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(190, 190, 190)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                local dropdown = Instance.new("Frame")
                dropdown.Name = "Dropdown"
                dropdown.Parent = row
                dropdown.Size = UDim2.new(0, 150, 0, 34)
                dropdown.Position = UDim2.new(0.5, 20, 0.5, -17)
                dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.BackgroundTransparency = 0.93
                dropdown.BorderSizePixel = 1
                dropdown.BorderColor3 = Color3.fromRGB(200, 200, 200)
                dropdown.ClipsDescendants = true
                CreateCorner(dropdown, 12)
                
                local dropdownText = Instance.new("TextLabel")
                dropdownText.Name = "Text"
                dropdownText.Parent = dropdown
                dropdownText.Size = UDim2.new(1, -50, 1, 0)
                dropdownText.Position = UDim2.new(0, 14, 0, 0)
                dropdownText.BackgroundTransparency = 1
                dropdownText.Text = "Select..."
                dropdownText.TextColor3 = Color3.fromRGB(200, 200, 200)
                dropdownText.TextSize = 13
                dropdownText.Font = Enum.Font.Gotham
                dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                dropdownText.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Badge
                local badge = Instance.new("Frame")
                badge.Name = "Badge"
                badge.Parent = dropdown
                badge.Size = UDim2.new(0, 24, 0, 20)
                badge.Position = UDim2.new(1, -44, 0.5, -10)
                badge.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
                badge.BackgroundTransparency = 0.7
                badge.BorderSizePixel = 0
                badge.Visible = false
                CreateCorner(badge, 10)
                
                local badgeText = Instance.new("TextLabel")
                badgeText.Name = "Text"
                badgeText.Parent = badge
                badgeText.Size = UDim2.new(1, 0, 1, 0)
                badgeText.BackgroundTransparency = 1
                badgeText.Text = "0"
                badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
                badgeText.TextSize = 11
                badgeText.Font = Enum.Font.GothamBold
                badgeText.TextYAlignment = Enum.TextYAlignment.Center
                
                local arrow = Instance.new("TextLabel")
                arrow.Name = "Arrow"
                arrow.Parent = dropdown
                arrow.Size = UDim2.new(0, 24, 1, 0)
                arrow.Position = UDim2.new(1, -24, 0, 0)
                arrow.BackgroundTransparency = 1
                arrow.Text = "▾"
                arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
                arrow.TextSize = 12
                arrow.Font = Enum.Font.Gotham
                arrow.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Menu
                local menu = Instance.new("Frame")
                menu.Name = "Menu"
                menu.Parent = row
                menu.Size = UDim2.new(0, 150, 0, 0)
                menu.Position = UDim2.new(0.5, 20, 0.5, 20)
                menu.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                menu.BackgroundTransparency = 0.2
                menu.BorderSizePixel = 1
                menu.BorderColor3 = Color3.fromRGB(200, 200, 200)
                menu.Visible = false
                menu.ClipsDescendants = true
                menu.AutomaticSize = Enum.AutomaticSize.Y
                CreateCorner(menu, 12)
                
                local menuItems = {}
                for i, value in ipairs(element.Values) do
                    local item = Instance.new("TextButton")
                    item.Name = "Item_" .. i
                    item.Parent = menu
                    item.Size = UDim2.new(1, 0, 0, 34)
                    item.BackgroundTransparency = 1
                    item.Text = "☐ " .. value
                    item.TextColor3 = Color3.fromRGB(180, 180, 180)
                    item.TextSize = 13
                    item.Font = Enum.Font.Gotham
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.TextYAlignment = Enum.TextYAlignment.Center
                    item.Position = UDim2.new(0, 14, 0, (i - 1) * 34)
                    item.AutoButtonColor = false
                    
                    item.MouseEnter:Connect(function()
                        Tween(item, {BackgroundTransparency = 0.9}, 0.1)
                    end)
                    item.MouseLeave:Connect(function()
                        Tween(item, {BackgroundTransparency = 1}, 0.1)
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        local index = i
                        if element.Selected[index] then
                            element.Selected[index] = nil
                            item.Text = "☐ " .. value
                        else
                            element.Selected[index] = value
                            item.Text = "☑ " .. value
                        end
                        
                        -- Update badge
                        local count = 0
                        for _ in pairs(element.Selected) do count = count + 1 end
                        if count > 0 then
                            badge.Visible = true
                            badgeText.Text = tostring(count)
                            dropdownText.Text = count .. " selected"
                        else
                            badge.Visible = false
                            dropdownText.Text = "Select..."
                        end
                        
                        if element.Callback then
                            local values = {}
                            for _, v in pairs(element.Selected) do
                                table.insert(values, v)
                            end
                            element.Callback(values)
                        end
                    end)
                    
                    table.insert(menuItems, item)
                end
                
                dropdown.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        element.Open = not element.Open
                        menu.Visible = element.Open
                        Tween(arrow, {Rotation = element.Open and 180 or 0}, 0.2)
                        if element.Open then
                            local itemCount = #element.Values
                            menu.Size = UDim2.new(0, 150, 0, math.min(itemCount * 34, 150))
                            Tween(menu, {BackgroundTransparency = 0.1}, 0.15)
                        end
                    end
                end)
                
                element.Row = row
                element.Menu = menu
                return element
            end
            
            -- Update section size
            task.wait()
            local containerHeight = elementsContainer.AbsoluteSize.Y
            sectionFrame.Size = UDim2.new(1, -24, 0, containerHeight + 60)
            
            return section
        end
        
        return tab
    end
    
    function window:AddParagraph(title, description)
        local card = Instance.new("Frame")
        card.Name = "ParagraphCard"
        card.Parent = contentArea
        card.Size = UDim2.new(1, -24, 0, 80)
        card.Position = UDim2.new(0, 12, 0, 12)
        card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        card.BackgroundTransparency = 0.95
        card.BorderSizePixel = 0
        card.ClipsDescendants = true
        CreateCorner(card, 20)
        
        local cardBorder = Instance.new("UIStroke")
        cardBorder.Color = Color3.fromRGB(255, 255, 255)
        cardBorder.Thickness = 1
        cardBorder.Transparency = 0.88
        cardBorder.Parent = card
        
        local titleText = Instance.new("TextLabel")
        titleText.Name = "Title"
        titleText.Parent = card
        titleText.Size = UDim2.new(1, -40, 0, 30)
        titleText.Position = UDim2.new(0, 20, 0, 14)
        titleText.BackgroundTransparency = 1
        titleText.Text = title or "Paragraph"
        titleText.TextColor3 = Color3.fromRGB(220, 220, 220)
        titleText.TextSize = 15
        titleText.Font = Enum.Font.GothamBold
        titleText.TextXAlignment = Enum.TextXAlignment.Left
        titleText.TextYAlignment = Enum.TextYAlignment.Bottom
        
        local descText = Instance.new("TextLabel")
        descText.Name = "Description"
        descText.Parent = card
        descText.Size = UDim2.new(1, -40, 0, 24)
        descText.Position = UDim2.new(0, 20, 0, 46)
        descText.BackgroundTransparency = 1
        descText.Text = description or "Description"
        descText.TextColor3 = Color3.fromRGB(140, 140, 140)
        descText.TextSize = 13
        descText.Font = Enum.Font.Gotham
        descText.TextXAlignment = Enum.TextXAlignment.Left
        descText.TextYAlignment = Enum.TextYAlignment.Top
        
        return card
    end
    
    -- ────────────────────────────────────────────────────────────
    -- REOPEN BUTTON (FULLY FUNCTIONAL)
    -- ────────────────────────────────────────────────────────────
    
    local reopenBtn = Instance.new("Frame")
    reopenBtn.Name = "ReopenButton"
    reopenBtn.Parent = screenGui
    reopenBtn.Size = UDim2.new(0, 140, 0, 48)
    reopenBtn.Position = UDim2.new(0, 24, 1, -68)
    reopenBtn.BackgroundColor3 = Color3.fromRGB(15, 17, 24)
    reopenBtn.BackgroundTransparency = 0.3
    reopenBtn.BorderSizePixel = 1
    reopenBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    reopenBtn.Visible = false
    reopenBtn.ClipsDescendants = true
    CreateCorner(reopenBtn, 24)
    
    local reopenBorder = Instance.new("UIStroke")
    reopenBorder.Color = Color3.fromRGB(255, 255, 255)
    reopenBorder.Thickness = 1
    reopenBorder.Transparency = 0.85
    reopenBorder.Parent = reopenBtn
    
    local circle = Instance.new("Frame")
    circle.Name = "Circle"
    circle.Parent = reopenBtn
    circle.Size = UDim2.new(0, 32, 0, 32)
    circle.Position = UDim2.new(0, 10, 0.5, -16)
    circle.BackgroundColor3 = Color3.fromRGB(180, 160, 255)
    circle.BackgroundTransparency = 0.8
    circle.BorderSizePixel = 0
    CreateCorner(circle, 16)
    
    local circleIcon = Instance.new("TextLabel")
    circleIcon.Name = "Icon"
    circleIcon.Parent = circle
    circleIcon.Size = UDim2.new(1, 0, 1, 0)
    circleIcon.BackgroundTransparency = 1
    circleIcon.Text = "☽"
    circleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    circleIcon.TextSize = 18
    circleIcon.Font = Enum.Font.Gotham
    circleIcon.TextTransparency = 0.2
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = reopenBtn
    label.Size = UDim2.new(0, 80, 1, 0)
    label.Position = UDim2.new(0, 50, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "open close UI"
    label.TextColor3 = Color3.fromRGB(140, 140, 140)
    label.TextSize = 11
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Reopen functionality
    reopenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Show main window with animation
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            mainFrame.BackgroundTransparency = 1
            Tween(mainFrame, {Size = UDim2.new(0, 860, 0, 580)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            Tween(mainFrame, {BackgroundTransparency = 0.45}, 0.3)
            task.wait(0.35)
            window.Visible = true
            reopenBtn.Visible = false
        end
    end)
    
    -- ────────────────────────────────────────────────────────────
    -- FINALIZE
    -- ────────────────────────────────────────────────────────────
    
    -- Add initial greeting
    window:AddParagraph("Welcome to Lunar UI", "A premium liquid glass interface for Roblox developers")
    
    return window
end

-- ────────────────────────────────────────────────────────────
-- EXPORT
-- ────────────────────────────────────────────────────────────

return Lunar
