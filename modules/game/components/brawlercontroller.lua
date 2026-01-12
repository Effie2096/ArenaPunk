--- @class BrawlerController : Controller
--- @overload fun(): BrawlerController
local BrawlerController =
   prism.components.Controller:extend("BrawlerController")

function BrawlerController:act(level, actor)
   local senses = actor:get(prism.components.Senses)
   if not senses then return prism.actions.Wait(actor) end

   local player = senses:query(level, prism.components.PlayerController):first()
   if not player then return prism.actions.Wait(actor) end

   local mover = actor:get(prism.components.Mover)
   if not mover then return prism.actions.Wait(actor) end

   local path = level:findPath(
      actor:getPosition(),
      player:getPosition(),
      actor,
      mover.mask,
      1
   )

   if path then
      local move = prism.actions.Move(actor, path:pop())
      if level:canPerform(move) then return move end
   end

   return prism.actions.Wait(actor)
end

return BrawlerController
