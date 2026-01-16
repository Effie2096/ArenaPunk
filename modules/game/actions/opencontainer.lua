local Name = prism.components.Name
local Log = prism.components.Log

local OpenContainerTarget =
   prism.Target():with(prism.components.Container):range(1):sensed()

--- @class OpenContainer : Action
local OpenContainer = prism.Action:extend "OpenContainer"
OpenContainer.targets = { OpenContainerTarget }

--- @param level Level
--- @param container Actor
function OpenContainer:canPerform(level, container)
   local inventory = container:expect(prism.components.Inventory)
   local x, y = container:expectPosition():decompose()

   inventory:query():each(function(item)
      inventory:removeItem(item)
      level:addActor(item, x, y)
   end)

   level:removeActor(container)

   local containerName = Name.get(container)
   Log.addMessage(self.owner, "You open the %s.", containerName)
   Log.addMessageSensed(
      level,
      self,
      "The %s opens the %s",
      Name.get(self.owner),
      containerName
   )
end

return OpenContainer
