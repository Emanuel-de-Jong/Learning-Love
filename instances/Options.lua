local Options = Class:new()

Options.options = {
    volume = 0,
    scrollSpeed = 10,
    -- noteColor = {
    --     value= 'white',
    --     choices = {'white', 'red', 'green', 'blue'}
    -- }
}

function saveConfig()
    ConfigManager.save("Options", Options.options)
end

function loadConfig()
    local data = ConfigManager.load("Options")
    if data ~= nil then
        Options.options = data
    end
end

Options.change = function(options)
    Options.options = options
    saveConfig()
end

Options.changeValue = function(key, value)
    Options.options[key] = value
    saveConfig()
end

Options.load = function()
    loadConfig()
end

return Options