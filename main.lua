Class = require("classes/Class")

local SceneManager = require("instances/SceneManager")
local Input = require("instances/Input")

function love.load(arg, unfilteredArg)
    SceneManager.change("Menu")
end

function love.update(dt)
    if SceneManager.scene["update"] then
        SceneManager.scene.update(dt)
    end
end

function love.draw()
    if SceneManager.scene["draw"] then
        SceneManager.scene.draw()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    Input.mousepressed(x, y, button, istouch, presses)

    if SceneManager.scene["mousepressed"] then
        SceneManager.scene.mousepressed(x, y, button, istouch, presses)
    end
end

function love.keypressed(key, scancode, isrepeat)
    Input.keypressed(key, scancode, isrepeat)

    if SceneManager.scene["keypressed"] then
        SceneManager.scene.keypressed(key, scancode, isrepeat)
    end
end

function love.wheelmoved(x, y)
    Input.wheelmoved(x, y)

    if SceneManager.scene["wheelmoved"] then
        SceneManager.scene.wheelmoved(x, y)
    end
end

function love.resize(w, h)
    if SceneManager.scene["resize"] then
        SceneManager.scene.resize(w, h)
    end
end