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
