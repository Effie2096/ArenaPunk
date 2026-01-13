require "debugger"
require "prism"

prism.loadModule("prism/spectrum")
prism.loadModule("prism/geometer")
prism.loadModule("prism/extra/sight")
prism.loadModule("prism/extra/log")
prism.loadModule("modules/game")

-- Used by Geometer for new maps
prism.defaultCell = prism.cells.Pit

-- Load a sprite atlas and configure the terminal-style display,
love.graphics.setDefaultFilter("nearest", "nearest")
local spriteAtlas =
   spectrum.SpriteAtlas.fromASCIIGrid("display/wanderlust_16x16.png", 16, 16)
local display = spectrum.Display(81, 41, spriteAtlas, prism.Vector2(16, 16))

-- Automatically size the window to match the terminal dimensions
display:fitWindowToTerminal()

-- spin up our state machine
--- @type GameStateManager
local manager = spectrum.StateManager()

-- we put out levelstate on top here, but you could create a main menu
--- @diagnostic disable-next-line
function love.load(args)
   if args[1] == "--debug" then
      local levelgen = require("levelgen")
      local builder = prism.LevelBuilder()
      local seed = prism.RNG(love.timer.getTime())
      local function generator()
         levelgen(seed, prism.actors.Player(), 60, 30, builder)
      end

      manager:push(
         spectrum.gamestates.MapGeneratorState(generator, builder, display)
      )
   else
      manager:push(spectrum.gamestates.GameLevelState(display))
   end
   manager:hook()
   spectrum.Input:hook()
end
