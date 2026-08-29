return function(parent, config)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,30)
    f.BackgroundTransparency = 1
    f.Parent = parent
    return {Instance = f}
end
