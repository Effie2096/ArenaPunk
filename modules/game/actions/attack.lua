local AttackTarget = prism.Target(prism.components.Health):isActor():range(1)

---@class Attack : Action
---@overload fun(owner: Actor, attacked: Actor): Attack
local Attack = prism.Action:extend("Attack")
Attack.name = "Attack"
Attack.targets = { AttackTarget }
Attack.requiredComponents = { prism.components.Attacker }

function Attack:perform(level, attacked)
   local attacker = self.owner:expect(prism.components.Attacker)

   local damage = prism.actions.Damage(attacked, attacker.damage)
   level:tryPerform(damage)
end

return Attack
