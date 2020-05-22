local SceneManager = require("instances/SceneManager")
local InputManager = Class:new()

InputManager.mousepressed = function(x, y, button, istouch, presses)

end

InputManager.keypressed = function(key, scancode, isrepeat)
    if key == "backspace" then
        SceneManager.goBack()
    end
end

InputManager.wheelmoved = function(x, y)
    
end

return InputManager