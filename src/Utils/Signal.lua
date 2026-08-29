-- Signal (Custom Event System)
local Signal = {}
Signal.__index = Signal

function Signal.new()
    return setmetatable({
        _connections = {}
    }, Signal)
end

function Signal:Connect(callback)
    local connection = {
        Callback = callback,
        Disconnect = function(selfConn)
            for i, conn in ipairs(self._connections) do
                if conn == selfConn then
                    table.remove(self._connections, i)
                    break
                end
            end
        end
    }
    table.insert(self._connections, connection)
    return connection
end

function Signal:Fire(...)
    for _, connection in ipairs(self._connections) do
        task.spawn(connection.Callback, ...)
    end
end

function Signal:Destroy()
    self._connections = {}
end

return Signal
