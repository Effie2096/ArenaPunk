prism.registerActor("Brawler", function()
   return prism.Actor.fromComponents({
      prism.components.Position(),
      prism.components.Collider(),
      prism.components.Drawable({ index = "b", color = prism.Color4.RED }),
      prism.components.Senses(),
      prism.components.Sight({ range = 12, fov = true }),
      prism.components.Mover({ "walk" }),
      prism.components.BrawlerController(),
   })
end)
