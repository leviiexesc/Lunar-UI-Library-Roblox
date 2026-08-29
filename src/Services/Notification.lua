local Animation = require(script.Parent.Animation)
local InstanceUtil = require(script.Parent.Parent.Utils.Instance)
local ThemeSystem = require(script.Parent.Parent.Theme)

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
