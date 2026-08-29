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
