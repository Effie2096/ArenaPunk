local KickTarget = prism.Target(prism.components.Collider):range(1):sensed()

--- @class KickAction : Action
local Kick = prism.Action:extend("Kick")
Kick.targets = { KickTarget }
Kick.requiredComponents = {
   prism.components.Controller,
}

function Kick:canPerform(level)
   return true
end

local mask = prism.Collision.createBitmaskFromMovetypes({ "fly" })

function Kick:perform(level, kicked)
   local direction = (kicked:getPosition() - self.owner:getPosition())

   local final = kicked:expectPosition()
   for _ = 1, 3 do
      local nextpos = final + direction
      if not level:getCellPassable(nextpos.x, nextpos.y, mask) then break end
      final = nextpos
   end

   level:moveActor(kicked, final)
end

return Kick
