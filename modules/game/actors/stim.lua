prism.registerActor("Stim", function()
   return prism.Actor.fromComponents({
      prism.components.Name("Stim"),
      prism.components.Position(),
      prism.components.Drawable({ index = "+", color = prism.Color4.BLUE }),
      prism.components.Item({
         stackable = "Stim",
         stackLimit = 5,
      }),
   })
end)
