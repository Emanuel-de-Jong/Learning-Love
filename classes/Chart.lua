local Chart = Class:new()

Chart.typePerCategory = {
    Format = "format",
    General = "setting",
    Editor = "setting",
    Metadata = "setting",
    Difficulty = "setting",
    Events = "event",
    TimingPoints = "event",
    HitObjects = "event",
}

Chart.construct = function(self, path)
    self.path = path

    self:syncWithFile()
end

Chart.syncWithFile = function(self)
    self.Format = nil
    self.General = {}
    self.Editor = {}
    self.Metadata = {}
    self.Difficulty = {}
    self.Events = {}
    self.TimingPoints = {}
    self.HitObjects = {}

    local category = "Format"
    local type = "format"
    local colonPos = nil

    for line in io.lines(self.path) do
        if #line ~= 0 and string.sub(line, 1, 2) ~= "//" then
            if string.sub(line, 1, 1) == "[" then
                category = string.sub(line, 2, #line - 1)
                type = Chart.typePerCategory[category]
            else
                if type == "format" then
                    self.Format = string.sub(line, #line - 1)
                elseif type == "setting" then
                    colonPos = string.find(line, ":")
                    self[category][string.sub(line, 1, colonPos - 1)] = string.sub(line, colonPos + 1)
                elseif type == "event" then
                    table.insert(self[category], line)
                end
            end
        end
    end
    
    self.name = self.Metadata.Version
end

return Chart