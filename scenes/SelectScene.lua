local SongManager = require("instances/SongManager")
local SceneManager = require("instances/SceneManager")
local Collision = require("instances/Collision")
local SelectScene = Class:new()

local songsSettings = {spacing=50, x=0, w=0, scroll=0, font=FontList.getFont("Modak.ttf", 20)}

local chartsSettings = {spacing=50, x=0, w=0, scroll=0, font=FontList.getFont("Modak.ttf", 15)}

SelectScene.load = function()

    songsSettings.x = love.graphics.getWidth() / 2
    songsSettings.w = love.graphics.getWidth() / 2

    chartsSettings.x = 0
    chartsSettings.w = love.graphics.getWidth() / 2
end

SelectScene.draw = function()
    love.graphics.push()
    love.graphics.translate(0, songsSettings.scroll)

    love.graphics.setFont(songsSettings.font)

    for i, v in ipairs(SongManager.songs) do
        love.graphics.print(v.name, songsSettings.x, i * songsSettings.spacing)
    end
    
    love.graphics.pop()

    if SongManager.song ~= nil then
        love.graphics.push()
        love.graphics.translate(0, chartsSettings.scroll)

        love.graphics.setFont(chartsSettings.font)

        for i, v in ipairs(SongManager.song.charts) do
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

            SongManager.changeByIndex(index)
        elseif Collision.checkPointBoxX(x, chartsSettings.x,chartsSettings.w) then
            y = y - chartsSettings.scroll
            local index = math.floor(y / chartsSettings.spacing)

            SongManager.song.chart = SongManager.song.charts[index]

            SceneManager.change("Play")
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