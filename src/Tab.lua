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
