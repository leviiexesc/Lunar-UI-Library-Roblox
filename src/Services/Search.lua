local Signal = require(script.Parent.Parent.Utils.Signal)

local Search = {
    OnSearchQueryChanged = Signal.new(),
    CurrentQuery = ""
}

function Search.UpdateQuery(query)
    Search.CurrentQuery = string.lower(query)
    Search.OnSearchQueryChanged:Fire(Search.CurrentQuery)
end

function Search.Match(text)
    if Search.CurrentQuery == "" then return true end
    return string.find(string.lower(text), Search.CurrentQuery) ~= nil
end

return Search
