local controls = require("controls")

---@class GameOverState : GameState
---@field display Display
---@overload fun(display: Display): GameOverState
local GameOverState = spectrum.GameState:extend("GameOverState")

function GameOverState:__new(display)
   self.display = display
end

function GameOverState:draw()
   local midpoint = math.floor(self.display.height / 2)
   local messages = {
      "[r] to restart",
      "[q] to quit",
   }
   local width = 1
   for _, value in ipairs(messages) do
      local length = value:len()
      if length > width then width = length end
   end
   local centered = math.floor((self.display.width / 2) - width / 2) + 1

   self.display:clear()
   self.display:print(
      1,
      midpoint,
      "Game over!",
      nil,
      nil,
      nil,
      "center",
      self.display.width
   )

   local msg = "[r] to restart"
   self.display:print(
      centered,
      midpoint + 3,
      messages[1],
      prism.Color4.GREEN,
      nil,
      nil,
      "left",
      self.display.width
   )
   msg = "[q] to quit"
   self.display:print(
      centered,
      midpoint + 4,
      messages[2],
      prism.Color4.RED,
      nil,
      nil,
      "left",
      self.display.width
   )
   self.display:draw()
end

function GameOverState:update(dt)
   controls:update()

   if controls.quit.pressed then
      love.event.quit()
   elseif controls.restart.pressed then
      love.event.restart()
   end
end

return GameOverState
