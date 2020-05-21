local Song = require("classes/Song")
local SelectScene = Class:new()

local songs = {}
local songsSettings = {spacing=50, x=0, w=0, scroll=0, font=FontList.getFont("Modak.ttf", 20)}

SelectScene.currentSong = nil

local chartsSettings = {spacing=50, x=0, w=0, scroll=0, font=FontList.getFont("Modak.ttf", 15)}

SelectScene.load = function()
    local songPaths = FileSystem.getDirectories(rootPath .. "\\resources\\songs")

    for k, v in pairs(songPaths) do
        table.insert(songs, Song:new(nil, k, v))
    end

    songsSettings.x = love.graphics.getWidth() / 2
    songsSettings.w = love.graphics.getWidth() / 2

    chartsSettings.x = 0
    chartsSettings.w = love.graphics.getWidth() / 2
end

SelectScene.draw = function()
    love.graphics.push()
    love.graphics.translate(0, songsSettings.scroll)

    love.graphics.setFont(songsSettings.font)

    for i, v in ipairs(songs) do
        love.graphics.print(v.name, songsSettings.x, i * songsSettings.spacing)
    end
    
    love.graphics.pop()

    if SelectScene.currentSong ~= nil then
        love.graphics.push()
        love.graphics.translate(0, chartsSettings.scroll)

        love.graphics.setFont(chartsSettings.font)

        for i, v in ipairs(SelectScene.currentSong.charts) do
            love.graphics.print(v.name, chartsSettings.x, i * chartsSettings.spacing)
        end
        
        love.graphics.pop()
    end
end

SelectScene.mousepressed = function(x, y, button, istouch, presses)
    if button == 1 then
        if Collision.checkPointBoxX(x, songsSettings.x,songsSettings.w) then
            y = y - songsSettings.scroll
            local index = math.floor(y / songsSettings.spacing)

            SelectScene.currentSong = songs[index]
        elseif Collision.checkPointBoxX(x, chartsSettings.x,chartsSettings.w) then
            y = y - chartsSettings.scroll
            local index = math.floor(y / chartsSettings.spacing)

            SelectScene.currentSong.currentChart = SelectScene.currentSong.charts[index]
            scene = "PlayScene"
            _G[scene].load()
        end
    end
end

SelectScene.wheelmoved = function(x, y)
    mouseX = love.mouse.getX()
    if Collision.checkPointBoxX(mouseX, songsSettings.x,songsSettings.w) then
        songsSettings.scroll = songsSettings.scroll + (y * 15)
    elseif Collision.checkPointBoxX(mouseX, chartsSettings.x,chartsSettings.w) then
        chartsSettings.scroll = chartsSettings.scroll + (y * 15)
    end
end

return SelectScene