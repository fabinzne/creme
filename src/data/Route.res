type raw = 
  | NewRecipe
  | Home
  | UpdatedRecipe(Recipe.raw)
  | Recipe(Recipe.raw)