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
