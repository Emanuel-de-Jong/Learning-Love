local Play = Class:new()

Play.load = function()
    
end

Play.update = function(dt)

end

Play.draw = function()
    love.graphics.print(Select.currentSong.currentChart.name, 0, 0)
end

return Play