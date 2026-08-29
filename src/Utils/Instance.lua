-- Instance Utility for declarative UI creation
local InstanceUtil = {}
local ThemeSystem = require(script.Parent.Parent.Theme)

function InstanceUtil.new(className, properties, children)
    local inst = Instance.new(className)
    
    if properties then
        for k, v in pairs(properties) do
            if k ~= "ThemeTag" then
                inst[k] = v
            end
        end
    end
    
    if children then
        for _, child in pairs(children) do
            if typeof(child) == "Instance" then
                child.Parent = inst
            end
        end
    end
    
    return inst
end

function InstanceUtil.ApplyCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or ThemeSystem.GetTheme().CornerRadius
    corner.Parent = instance
    return corner
end

function InstanceUtil.ApplyStroke(instance, properties)
    local stroke = Instance.new("UIStroke")
    if properties then
        for k, v in pairs(properties) do
            stroke[k] = v
        end
    end
    stroke.Parent = instance
    return stroke
end

return InstanceUtil
