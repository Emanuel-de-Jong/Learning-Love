local Chart = require("classes/Chart")
local Song = Class:new()

Song.path = ""
Song.name = ""
Song.charts = {}

Song.construct = function(self, name, path)
    self.name = name
    self.path = path
    self:load()
end

Song.load = function(self)
    local chartPaths = FileSystem.getFiles(self.path, ".osu")

    for k, v in pairs(chartPaths) do
        table.insert(self.charts, Chart:new(nil, k, v))
    end
end

return Song