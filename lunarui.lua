-- Lunar UI - A Premium Liquid Glass UI Library for Roblox
-- Version 1.0.0

local Lunar = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ────────────────────────────────────────────────────────────
-- UTILITY FUNCTIONS
-- ────────────────────────────────────────────────────────────

local function CreateTween(obj, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        style,
        direction,
        0, false, 0
    )
    local tween = TweenService:Create(obj, tweenInfo, properties)
    return tween
end

local function CreateUIBlur(parent, size, transparency)
    local blur = Instance.new("BlurEffect")
    blur.Size = size or 24
    blur.Parent = parent or game:GetService("Lighting")
    if transparency then
        blur.Enabled = false
    end
    return blur
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
    
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LunarUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false
    
    -- Main Frame (Window)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 820, 0, 560)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
    mainFrame.BackgroundTransparency = 0.55
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
    mainFrame.ClipsDescendants = true
    
    -- Apply glass effect with corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 24)
    corner.Parent = mainFrame
    
    -- Blur behind window (using background blur with ViewportFrame approach)
    -- Note: This is a simplified approach, actual blur requires ViewportFrame or Lighting effects
    local blurFrame = Instance.new("Frame")
    blurFrame.Name = "BlurFrame"
    blurFrame.Parent = mainFrame
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    blurFrame.BackgroundTransparency = 0.98
    blurFrame.BorderSizePixel = 0
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = mainFrame
    titleBar.Size = UDim2.new(1, 0, 0, 48)
    titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.BackgroundTransparency = 0.95
    titleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 24)
    titleCorner.Parent = titleBar
    
    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Parent = titleBar
    titleText.Size = UDim2.new(0, 200, 1, 0)
    titleText.Position = UDim2.new(0, 20, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = window.Title
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.Gotham
    titleText.TextTransparency = 0.1
    titleText.TextStrokeTransparency = 0.5
    
    -- Moon Icon (simplified)
    local moonIcon = Instance.new("ImageLabel")
    moonIcon.Name = "MoonIcon"
    moonIcon.Parent = titleBar
    moonIcon.Size = UDim2.new(0, 20, 0, 20)
    moonIcon.Position = UDim2.new(0, 20, 0.5, -10)
    moonIcon.BackgroundTransparency = 1
    moonIcon.Image = "rbxassetid://15440914312" -- Placeholder, use a custom moon icon
    moonIcon.ImageTransparency = 0.3
    moonIcon.Visible = false -- Disabled, using text instead
    
    -- Window Controls (Minimize, Maximize, Close)
    local controls = {
        { Name = "Minimize", Color = Color3.fromRGB(255, 200, 60) },
        { Name = "Maximize", Color = Color3.fromRGB(100, 200, 130) },
        { Name = "Close", Color = Color3.fromRGB(255, 90, 90) }
    }
    
    for i, control in ipairs(controls) do
        local btn = Instance.new("Frame")
        btn.Name = control.Name
        btn.Parent = titleBar
        btn.Size = UDim2.new(0, 14, 0, 14)
        btn.Position = UDim2.new(1, -(60 - (i - 1) * 24), 0.5, -7)
        btn.BackgroundColor3 = control.Color
        btn.BackgroundTransparency = 0.8
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(1, 0)
        btnCorner.Parent = btn
        
        local btnHover = Instance.new("Frame")
        btnHover.Name = "Hover"
        btnHover.Parent = btn
        btnHover.Size = UDim2.new(1, 0, 1, 0)
        btnHover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btnHover.BackgroundTransparency = 0.9
        btnHover.BorderSizePixel = 0
        
        local hoverCorner = Instance.new("UICorner")
        hoverCorner.CornerRadius = UDim.new(1, 0)
        hoverCorner.Parent = btnHover
        
        btn.MouseEnter:Connect(function()
            CreateTween(btnHover, {BackgroundTransparency = 0.6}, 0.2):Play()
        end)
        btn.MouseLeave:Connect(function()
            CreateTween(btnHover, {BackgroundTransparency = 0.9}, 0.2):Play()
        end)
    end
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = mainFrame
    sidebar.Size = UDim2.new(0, 160, 1, -48)
    sidebar.Position = UDim2.new(0, 0, 0, 48)
    sidebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sidebar.BackgroundTransparency = 0.95
    sidebar.BorderSizePixel = 0
    
    -- Search Box
    local searchBox = Instance.new("Frame")
    searchBox.Name = "SearchBox"
    searchBox.Parent = sidebar
    searchBox.Size = UDim2.new(0.8, 0, 0, 36)
    searchBox.Position = UDim2.new(0.1, 0, 0, 16)
    searchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.BackgroundTransparency = 0.95
    searchBox.BorderSizePixel = 1
    searchBox.BorderColor3 = Color3.fromRGB(200, 200, 200)
    searchBox.BorderSizePixel = 1
    searchBox.BorderColor3 = Color3.fromRGB(200, 200, 200)
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(1, 0)
    searchCorner.Parent = searchBox
    
    -- Search Icon
    local searchIcon = Instance.new("TextLabel")
    searchIcon.Name = "Icon"
    searchIcon.Parent = searchBox
    searchIcon.Size = UDim2.new(0, 20, 1, 0)
    searchIcon.Position = UDim2.new(0, 8, 0, 0)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Text = "⌕"
    searchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
    searchIcon.TextSize = 14
    searchIcon.Font = Enum.Font.Gotham
    
    -- Search Input
    local searchInput = Instance.new("TextBox")
    searchInput.Name = "Input"
    searchInput.Parent = searchBox
    searchInput.Size = UDim2.new(1, -32, 1, 0)
    searchInput.Position = UDim2.new(0, 28, 0, 0)
    searchInput.BackgroundTransparency = 1
    searchInput.Text = ""
    searchInput.PlaceholderText = "Search..."
    searchInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    searchInput.TextColor3 = Color3.fromRGB(200, 200, 200)
    searchInput.TextSize = 13
    searchInput.Font = Enum.Font.Gotham
    searchInput.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Navigation Buttons
    local navButtons = {
        { Title = "Main", Active = true },
        { Title = "Settings", Active = false },
        { Title = "More", Active = false }
    }
    
    for i, nav in ipairs(navButtons) do
        local btn = Instance.new("TextButton")
        btn.Name = nav.Title
        btn.Parent = sidebar
        btn.Size = UDim2.new(0.8, 0, 0, 36)
        btn.Position = UDim2.new(0.1, 0, 0, 68 + (i - 1) * 46)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = nav.Active and 0.92 or 0.98
        btn.BorderSizePixel = nav.Active and 1 or 0
        btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
        btn.Text = nav.Title
        btn.TextColor3 = nav.Active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
        btn.TextSize = 14
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.TextXAlignment = Enum.TextXAlignment.Center
        btn.TextYAlignment = Enum.TextYAlignment.Center
        btn.AutoButtonColor = false
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 12)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            if not nav.Active then
                CreateTween(btn, {BackgroundTransparency = 0.94}, 0.2):Play()
                CreateTween(btn, {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.2):Play()
            end
        end)
        btn.MouseLeave:Connect(function()
            if not nav.Active then
                CreateTween(btn, {BackgroundTransparency = 0.98}, 0.2):Play()
                CreateTween(btn, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2):Play()
            end
        end)
    end
    
    -- Divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Parent = sidebar
    divider.Size = UDim2.new(0.8, 0, 0, 1)
    divider.Position = UDim2.new(0.1, 0, 0, 182)
    divider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    divider.BackgroundTransparency = 0.9
    divider.BorderSizePixel = 0
    
    -- Main Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = mainFrame
    contentArea.Size = UDim2.new(1, -180, 1, -68)
    contentArea.Position = UDim2.new(0, 170, 0, 58)
    contentArea.BackgroundTransparency = 1
    contentArea.BorderSizePixel = 0
    
    -- ────────────────────────────────────────────────────────────
    -- WINDOW METHODS
    -- ────────────────────────────────────────────────────────────
    
    window.Tabs = {}
    window.CurrentTab = nil
    window.ScreenGui = screenGui
    window.MainFrame = mainFrame
    window.ContentArea = contentArea
    
    function window:AddTab(config)
        config = config or {}
        local tab = {}
        tab.Title = config.Title or "Tab"
        tab.Sections = {}
        
        -- Create tab content frame
        local tabFrame = Instance.new("Frame")
        tabFrame.Name = tab.Title
        tabFrame.Parent = contentArea
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.Visible = not window.CurrentTab
        
        tab.Frame = tabFrame
        
        -- Add to tabs list
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
            sectionFrame.Size = UDim2.new(1, -20, 0, 0)
            sectionFrame.Position = UDim2.new(0, 10, 0, 10)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionFrame.BackgroundTransparency = 0.95
            sectionFrame.BorderSizePixel = 1
            sectionFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
            sectionFrame.BorderSizePixel = 1
            sectionFrame.BorderColor3 = Color3.fromRGB(200, 200, 200)
            sectionFrame.ClipsDescendants = true
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 20)
            sectionCorner.Parent = sectionFrame
            
            -- Section Title
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Parent = sectionFrame
            sectionTitle.Size = UDim2.new(1, -40, 0, 40)
            sectionTitle.Position = UDim2.new(0, 20, 0, 10)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = section.Title
            sectionTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            sectionTitle.TextSize = 15
            sectionTitle.Font = Enum.Font.Gotham
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.TextYAlignment = Enum.TextYAlignment.Center
            
            local elementsContainer = Instance.new("Frame")
            elementsContainer.Name = "ElementsContainer"
            elementsContainer.Parent = sectionFrame
            elementsContainer.Size = UDim2.new(1, -40, 0, 0)
            elementsContainer.Position = UDim2.new(0, 20, 0, 50)
            elementsContainer.BackgroundTransparency = 1
            elementsContainer.AutomaticSize = Enum.AutomaticSize.Y
            
            section.Container = elementsContainer
            section.Frame = sectionFrame
            
            -- Store section
            table.insert(section.Elements, section)
            table.insert(tab.Sections, section)
            
            function section:AddButton(config)
                config = config or {}
                local element = {}
                element.Type = "Button"
                element.Title = config.Title or "Button"
                element.Callback = config.Callback or function() end
                
                -- Button row
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 40)
                row.BackgroundTransparency = 1
                row.AutomaticSize = Enum.AutomaticSize.Y
                
                -- Label
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Button
                local btn = Instance.new("TextButton")
                btn.Name = "Button"
                btn.Parent = row
                btn.Size = UDim2.new(0, 100, 0, 30)
                btn.Position = UDim2.new(0.5, 40, 0.5, -15)
                btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundTransparency = 0.95
                btn.BorderSizePixel = 1
                btn.BorderColor3 = Color3.fromRGB(200, 200, 200)
                btn.Text = config.Text or "Click Me"
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                btn.TextSize = 13
                btn.Font = Enum.Font.Gotham
                btn.AutoButtonColor = false
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(1, 0)
                btnCorner.Parent = btn
                
                btn.MouseEnter:Connect(function()
                    CreateTween(btn, {BackgroundTransparency = 0.92}, 0.15):Play()
                    CreateTween(btn, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15):Play()
                end)
                btn.MouseLeave:Connect(function()
                    CreateTween(btn, {BackgroundTransparency = 0.95}, 0.15):Play()
                    CreateTween(btn, {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.15):Play()
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
                row.Size = UDim2.new(1, 0, 0, 40)
                row.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Toggle Pill
                local toggle = Instance.new("Frame")
                toggle.Name = "Toggle"
                toggle.Parent = row
                toggle.Size = UDim2.new(0, 40, 0, 22)
                toggle.Position = UDim2.new(0.5, 40, 0.5, -11)
                toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggle.BackgroundTransparency = 0.92
                toggle.BorderSizePixel = 1
                toggle.BorderColor3 = Color3.fromRGB(200, 200, 200)
                
                local toggleCorner = Instance.new("UICorner")
                toggleCorner.CornerRadius = UDim.new(1, 0)
                toggleCorner.Parent = toggle
                
                local knob = Instance.new("Frame")
                knob.Name = "Knob"
                knob.Parent = toggle
                knob.Size = UDim2.new(0, 16, 0, 16)
                knob.Position = UDim2.new(0, 2, 0.5, -8)
                knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                knob.BackgroundTransparency = 0.3
                knob.BorderSizePixel = 0
                
                local knobCorner = Instance.new("UICorner")
                knobCorner.CornerRadius = UDim.new(1, 0)
                knobCorner.Parent = knob
                
                element.Toggle = toggle
                element.Knob = knob
                element.Active = element.Default
                
                local function UpdateToggle(value)
                    element.Active = value
                    if value then
                        CreateTween(toggle, {BackgroundTransparency = 0.85}, 0.25):Play()
                        CreateTween(toggle, {BorderColor3 = Color3.fromRGB(140, 200, 160)}, 0.25):Play()
                        CreateTween(knob, {Position = UDim2.new(0, 22, 0.5, -8)}, 0.25):Play()
                        CreateTween(knob, {BackgroundColor3 = Color3.fromRGB(200, 230, 210)}, 0.25):Play()
                    else
                        CreateTween(toggle, {BackgroundTransparency = 0.92}, 0.25):Play()
                        CreateTween(toggle, {BorderColor3 = Color3.fromRGB(200, 200, 200)}, 0.25):Play()
                        CreateTween(knob, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.25):Play()
                        CreateTween(knob, {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}, 0.25):Play()
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
                row.Size = UDim2.new(1, 0, 0, 40)
                row.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Slider Track
                local track = Instance.new("Frame")
                track.Name = "Track"
                track.Parent = row
                track.Size = UDim2.new(0, 120, 0, 4)
                track.Position = UDim2.new(0.5, 30, 0.5, -2)
                track.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                track.BackgroundTransparency = 0.9
                track.BorderSizePixel = 0
                
                local trackCorner = Instance.new("UICorner")
                trackCorner.CornerRadius = UDim.new(1, 0)
                trackCorner.Parent = track
                
                -- Fill
                local fill = Instance.new("Frame")
                fill.Name = "Fill"
                fill.Parent = track
                fill.Size = UDim2.new(0.5, 0, 1, 0)
                fill.BackgroundColor3 = Color3.fromRGB(180, 160, 220)
                fill.BackgroundTransparency = 0.6
                fill.BorderSizePixel = 0
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = fill
                
                -- Handle
                local handle = Instance.new("Frame")
                handle.Name = "Handle"
                handle.Parent = track
                handle.Size = UDim2.new(0, 14, 0, 14)
                handle.Position = UDim2.new(0.5, -7, 0.5, -7)
                handle.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                handle.BackgroundTransparency = 0.2
                handle.BorderSizePixel = 1
                handle.BorderColor3 = Color3.fromRGB(200, 200, 200)
                
                local handleCorner = Instance.new("UICorner")
                handleCorner.CornerRadius = UDim.new(1, 0)
                handleCorner.Parent = handle
                
                -- Value Display
                local valueDisplay = Instance.new("TextLabel")
                valueDisplay.Name = "Value"
                valueDisplay.Parent = row
                valueDisplay.Size = UDim2.new(0, 40, 1, 0)
                valueDisplay.Position = UDim2.new(0.5, 160, 0, 0)
                valueDisplay.BackgroundTransparency = 1
                valueDisplay.Text = tostring(element.Default)
                valueDisplay.TextColor3 = Color3.fromRGB(150, 150, 150)
                valueDisplay.TextSize = 13
                valueDisplay.Font = Enum.Font.Gotham
                valueDisplay.TextXAlignment = Enum.TextXAlignment.Right
                
                element.Value = element.Default
                
                local function UpdateSlider(value)
                    local clamped = math.clamp(value, element.Min, element.Max)
                    element.Value = clamped
                    local percent = (clamped - element.Min) / (element.Max - element.Min)
                    fill.Size = UDim2.new(percent, 0, 1, 0)
                    handle.Position = UDim2.new(percent, -7, 0.5, -7)
                    valueDisplay.Text = tostring(math.round(clamped))
                    
                    if element.Callback then
                        element.Callback(clamped)
                    end
                end
                
                UpdateSlider(element.Default)
                
                -- Slider drag functionality
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
                
                track.MouseMoved:Connect(function()
                    if dragging then
                        local pos = mouse.X
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
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 40)
                row.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Dropdown Box
                local dropdown = Instance.new("Frame")
                dropdown.Name = "Dropdown"
                dropdown.Parent = row
                dropdown.Size = UDim2.new(0, 130, 0, 32)
                dropdown.Position = UDim2.new(0.5, 30, 0.5, -16)
                dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.BackgroundTransparency = 0.95
                dropdown.BorderSizePixel = 1
                dropdown.BorderColor3 = Color3.fromRGB(200, 200, 200)
                dropdown.ClipsDescendants = true
                
                local dropdownCorner = Instance.new("UICorner")
                dropdownCorner.CornerRadius = UDim.new(1, 0)
                dropdownCorner.Parent = dropdown
                
                local dropdownText = Instance.new("TextLabel")
                dropdownText.Name = "Text"
                dropdownText.Parent = dropdown
                dropdownText.Size = UDim2.new(1, -30, 1, 0)
                dropdownText.Position = UDim2.new(0, 12, 0, 0)
                dropdownText.BackgroundTransparency = 1
                dropdownText.Text = element.Default
                dropdownText.TextColor3 = Color3.fromRGB(180, 180, 180)
                dropdownText.TextSize = 13
                dropdownText.Font = Enum.Font.Gotham
                dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                dropdownText.TextYAlignment = Enum.TextYAlignment.Center
                
                local arrow = Instance.new("TextLabel")
                arrow.Name = "Arrow"
                arrow.Parent = dropdown
                arrow.Size = UDim2.new(0, 20, 1, 0)
                arrow.Position = UDim2.new(1, -20, 0, 0)
                arrow.BackgroundTransparency = 1
                arrow.Text = "▾"
                arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
                arrow.TextSize = 12
                arrow.Font = Enum.Font.Gotham
                
                -- Dropdown Menu (hidden by default)
                local menu = Instance.new("Frame")
                menu.Name = "Menu"
                menu.Parent = row
                menu.Size = UDim2.new(0, 130, 0, 0)
                menu.Position = UDim2.new(0.5, 30, 0.5, 18)
                menu.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                menu.BackgroundTransparency = 0.3
                menu.BorderSizePixel = 1
                menu.BorderColor3 = Color3.fromRGB(200, 200, 200)
                menu.Visible = false
                menu.ClipsDescendants = true
                menu.AutomaticSize = Enum.AutomaticSize.Y
                
                local menuCorner = Instance.new("UICorner")
                menuCorner.CornerRadius = UDim.new(0, 12)
                menuCorner.Parent = menu
                
                -- Populate menu
                local menuItems = {}
                for i, value in ipairs(element.Values) do
                    local item = Instance.new("TextButton")
                    item.Name = "Item_" .. i
                    item.Parent = menu
                    item.Size = UDim2.new(1, 0, 0, 30)
                    item.BackgroundTransparency = 1
                    item.Text = value
                    item.TextColor3 = Color3.fromRGB(180, 180, 180)
                    item.TextSize = 13
                    item.Font = Enum.Font.Gotham
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.TextYAlignment = Enum.TextYAlignment.Center
                    item.Position = UDim2.new(0, 12, 0, (i - 1) * 30)
                    item.AutoButtonColor = false
                    
                    item.MouseEnter:Connect(function()
                        CreateTween(item, {BackgroundTransparency = 0.9}, 0.1):Play()
                    end)
                    item.MouseLeave:Connect(function()
                        CreateTween(item, {BackgroundTransparency = 1}, 0.1):Play()
                    end)
                    
                    item.MouseButton1Click:Connect(function()
                        dropdownText.Text = value
                        menu.Visible = false
                        if element.Callback then
                            element.Callback(value)
                        end
                    end)
                    
                    table.insert(menuItems, item)
                end
                
                -- Toggle menu
                dropdown.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        menu.Visible = not menu.Visible
                        if menu.Visible then
                            -- Update menu size
                            local itemCount = #element.Values
                            menu.Size = UDim2.new(0, 130, 0, math.min(itemCount * 30, 150))
                            CreateTween(menu, {BackgroundTransparency = 0.2}, 0.15):Play()
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
                
                local row = Instance.new("Frame")
                row.Name = element.Title
                row.Parent = elementsContainer
                row.Size = UDim2.new(1, 0, 0, 40)
                row.BackgroundTransparency = 1
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.Parent = row
                label.Size = UDim2.new(0.5, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = element.Title
                label.TextColor3 = Color3.fromRGB(180, 180, 180)
                label.TextSize = 14
                label.Font = Enum.Font.Gotham
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                
                -- Multi Dropdown Box
                local dropdown = Instance.new("Frame")
                dropdown.Name = "Dropdown"
                dropdown.Parent = row
                dropdown.Size = UDim2.new(0, 130, 0, 32)
                dropdown.Position = UDim2.new(0.5, 30, 0.5, -16)
                dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dropdown.BackgroundTransparency = 0.95
                dropdown.BorderSizePixel = 1
                dropdown.BorderColor3 = Color3.fromRGB(200, 200, 200)
                dropdown.ClipsDescendants = true
                
                local dropdownCorner = Instance.new("UICorner")
                dropdownCorner.CornerRadius = UDim.new(1, 0)
                dropdownCorner.Parent = dropdown
                
                local dropdownText = Instance.new("TextLabel")
                dropdownText.Name = "Text"
                dropdownText.Parent = dropdown
                dropdownText.Size = UDim2.new(1, -40, 1, 0)
                dropdownText.Position = UDim2.new(0, 12, 0, 0)
                dropdownText.BackgroundTransparency = 1
                dropdownText.Text = "Select..."
                dropdownText.TextColor3 = Color3.fromRGB(180, 180, 180)
                dropdownText.TextSize = 13
                dropdownText.Font = Enum.Font.Gotham
                dropdownText.TextXAlignment = Enum.TextXAlignment.Left
                dropdownText.TextYAlignment = Enum.TextYAlignment.Center
                
                local badge = Instance.new("Frame")
                badge.Name = "Badge"
                badge.Parent = dropdown
                badge.Size = UDim2.new(0, 20, 0, 16)
                badge.Position = UDim2.new(1, -32, 0.5, -8)
                badge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                badge.BackgroundTransparency = 0.9
                badge.BorderSizePixel = 1
                badge.BorderColor3 = Color3.fromRGB(200, 200, 200)
                badge.Visible = false
                
                local badgeCorner = Instance.new("UICorner")
                badgeCorner.CornerRadius = UDim.new(1, 0)
                badgeCorner.Parent = badge
                
                local badgeText = Instance.new("TextLabel")
                badgeText.Name = "Text"
                badgeText.Parent = badge
                badgeText.Size = UDim2.new(1, 0, 1, 0)
                badgeText.BackgroundTransparency = 1
                badgeText.Text = "0"
                badgeText.TextColor3 = Color3.fromRGB(150, 150, 150)
                badgeText.TextSize = 10
                badgeText.Font = Enum.Font.Gotham
                badgeText.TextYAlignment = Enum.TextYAlignment.Center
                
                local arrow = Instance.new("TextLabel")
                arrow.Name = "Arrow"
                arrow.Parent = dropdown
                arrow.Size = UDim2.new(0, 20, 1, 0)
                arrow.Position = UDim2.new(1, -20, 0, 0)
                arrow.BackgroundTransparency = 1
                arrow.Text = "▾"
                arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
                arrow.TextSize = 12
                arrow.Font = Enum.Font.Gotham
                
                -- Menu
                local menu = Instance.new("Frame")
                menu.Name = "Menu"
                menu.Parent = row
                menu.Size = UDim2.new(0, 130, 0, 0)
                menu.Position = UDim2.new(0.5, 30, 0.5, 18)
                menu.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
                menu.BackgroundTransparency = 0.3
                menu.BorderSizePixel = 1
                menu.BorderColor3 = Color3.fromRGB(200, 200, 200)
                menu.Visible = false
                menu.ClipsDescendants = true
                menu.AutomaticSize = Enum.AutomaticSize.Y
                
                local menuCorner = Instance.new("UICorner")
                menuCorner.CornerRadius = UDim.new(0, 12)
                menuCorner.Parent = menu
                
                local menuItems = {}
                for i, value in ipairs(element.Values) do
                    local item = Instance.new("TextButton")
                    item.Name = "Item_" .. i
                    item.Parent = menu
                    item.Size = UDim2.new(1, 0, 0, 30)
                    item.BackgroundTransparency = 1
                    item.Text = "☐ " .. value
                    item.TextColor3 = Color3.fromRGB(180, 180, 180)
                    item.TextSize = 13
                    item.Font = Enum.Font.Gotham
                    item.TextXAlignment = Enum.TextXAlignment.Left
                    item.TextYAlignment = Enum.TextYAlignment.Center
                    item.Position = UDim2.new(0, 12, 0, (i - 1) * 30)
                    item.AutoButtonColor = false
                    
                    item.MouseEnter:Connect(function()
                        CreateTween(item, {BackgroundTransparency = 0.9}, 0.1):Play()
                    end)
                    item.MouseLeave:Connect(function()
                        CreateTween(item, {BackgroundTransparency = 1}, 0.1):Play()
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
                        menu.Visible = not menu.Visible
                        if menu.Visible then
                            local itemCount = #element.Values
                            menu.Size = UDim2.new(0, 130, 0, math.min(itemCount * 30, 150))
                            CreateTween(menu, {BackgroundTransparency = 0.2}, 0.15):Play()
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
            sectionFrame.Size = UDim2.new(1, -20, 0, containerHeight + 60)
            tabFrame.Size = UDim2.new(1, 0, 1, 0)
            
            return section
        end
        
        return tab
    end
    
    -- Add Paragraph (convenience method)
    function window:AddParagraph(title, description, parent)
        parent = parent or contentArea
        local card = Instance.new("Frame")
        card.Name = "ParagraphCard"
        card.Parent = parent
        card.Size = UDim2.new(1, -20, 0, 80)
        card.Position = UDim2.new(0, 10, 0, 10)
        card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        card.BackgroundTransparency = 0.95
        card.BorderSizePixel = 1
        card.BorderColor3 = Color3.fromRGB(200, 200, 200)
        card.ClipsDescendants = true
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 20)
        cardCorner.Parent = card
        
        local titleText = Instance.new("TextLabel")
        titleText.Name = "Title"
        titleText.Parent = card
        titleText.Size = UDim2.new(1, -40, 0, 30)
        titleText.Position = UDim2.new(0, 20, 0, 12)
        titleText.BackgroundTransparency = 1
        titleText.Text = title or "Paragraph"
        titleText.TextColor3 = Color3.fromRGB(200, 200, 200)
        titleText.TextSize = 14
        titleText.Font = Enum.Font.Gotham
        titleText.TextXAlignment = Enum.TextXAlignment.Left
        titleText.TextYAlignment = Enum.TextYAlignment.Bottom
        
        local descText = Instance.new("TextLabel")
        descText.Name = "Description"
        descText.Parent = card
        descText.Size = UDim2.new(1, -40, 0, 24)
        descText.Position = UDim2.new(0, 20, 0, 42)
        descText.BackgroundTransparency = 1
        descText.Text = description or "Description"
        descText.TextColor3 = Color3.fromRGB(130, 130, 130)
        descText.TextSize = 13
        descText.Font = Enum.Font.Gotham
        descText.TextXAlignment = Enum.TextXAlignment.Left
        descText.TextYAlignment = Enum.TextYAlignment.Top
        
        return card
    end
    
    -- ────────────────────────────────────────────────────────────
    -- FLOATING REOPEN BUTTON
    -- ────────────────────────────────────────────────────────────
    
    local reopenBtn = Instance.new("Frame")
    reopenBtn.Name = "ReopenButton"
    reopenBtn.Parent = screenGui
    reopenBtn.Size = UDim2.new(0, 120, 0, 44)
    reopenBtn.Position = UDim2.new(0, 24, 1, -60)
    reopenBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    reopenBtn.BackgroundTransparency = 0.4
    reopenBtn.BorderSizePixel = 1
    reopenBtn.BorderColor3 = Color3.fromRGB(200, 200, 200)
    reopenBtn.BorderSizePixel = 1
    reopenBtn.BorderColor3 = Color3.fromRGB(200, 200, 200)
    
    local reopenCorner = Instance.new("UICorner")
    reopenCorner.CornerRadius = UDim.new(1, 0)
    reopenCorner.Parent = reopenBtn
    
    local circle = Instance.new("Frame")
    circle.Name = "Circle"
    circle.Parent = reopenBtn
    circle.Size = UDim2.new(0, 28, 0, 28)
    circle.Position = UDim2.new(0, 10, 0.5, -14)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BackgroundTransparency = 0.9
    circle.BorderSizePixel = 1
    circle.BorderColor3 = Color3.fromRGB(200, 200, 200)
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    local circleIcon = Instance.new("TextLabel")
    circleIcon.Name = "Icon"
    circleIcon.Parent = circle
    circleIcon.Size = UDim2.new(1, 0, 1, 0)
    circleIcon.BackgroundTransparency = 1
    circleIcon.Text = "🌙"
    circleIcon.TextColor3 = Color3.fromRGB(180, 180, 180)
    circleIcon.TextSize = 14
    circleIcon.Font = Enum.Font.Gotham
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = reopenBtn
    label.Size = UDim2.new(0, 80, 1, 0)
    label.Position = UDim2.new(0, 46, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "open close UI"
    label.TextColor3 = Color3.fromRGB(120, 120, 120)
    label.TextSize = 11
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center
    
    -- ────────────────────────────────────────────────────────────
    -- RETURN WINDOW
    -- ────────────────────────────────────────────────────────────
    
    return window
end

-- ────────────────────────────────────────────────────────────
-- EXPORT
-- ────────────────────────────────────────────────────────────

return Lunar
