local UserInputService = game:GetService("UserInputService")
local Signal = require(script.Parent.Parent.Utils.Signal)

local Input = {
    OnInputBegan = Signal.new(),
    OnInputEnded = Signal.new(),
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        Input.OnInputBegan:Fire(input)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed then
        Input.OnInputEnded:Fire(input)
    end
end)

function Input.MakeDraggable(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

return Input
