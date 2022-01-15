@val @scope("localStorage") external getItem: string => Js.Nullable.t<string> = "getItem"
@val @scope("localStorage") external setItem: (string, string) => unit = "setItem"

@scope("JSON") @val
external parseToRecipe: string => array<Recipe.raw> = "parse"

open Js.Json

let setRecipe = (value: Recipe.raw) => {
  let recipes = Js.Nullable.toOption(getItem("recipes"))


  let curr_recipes = switch recipes {
  | Some(value) => parseToRecipe(value)
  | None => []
  }

  let _ = Js.Array.push(value, curr_recipes) 

  let stringified = stringifyAny(curr_recipes)

  switch stringified {
  | None => Js.log("Could not stringify recipe")
  | Some(string) => setItem("recipes", string) 
  }
}

let getRecipes = () => {
  let stringified = Js.Nullable.toOption(getItem("recipes"))

  switch stringified {
  | Some(value) => parseToRecipe(value)
  | None => []
  }
}

let deleteRecipe = (resToDelete: Recipe.raw) => {
  let recipes = Js.Nullable.toOption(getItem("recipes"))

  let curr_recipes = switch recipes {
  | Some(value) => parseToRecipe(value)
  | None => []
  }

  let recipesWithoutDeleted = Js.Array.filter((recipe: Recipe.raw) => recipe.name != resToDelete.name,curr_recipes) 

  let stringified = stringifyAny(recipesWithoutDeleted)

  switch stringified {
  | None => Js.log("Could not stringify recipe")
  | Some(string) => setItem("recipes", string) 
  }
}

let updateRecipe = (resToUpdate: Recipe.raw) => {
  let recipes = Js.Nullable.toOption(getItem("recipes"))

  let curr_recipes = switch recipes {
  | Some(value) => parseToRecipe(value)
  | None => []
  }

  let recipesToUpdate = Js.Array.filter((recipe: Recipe.raw) => recipe.name != resToUpdate.name,curr_recipes)

  let newRecipes = Js.Array.push(resToUpdate, recipesToUpdate)
    
  let stringified = stringifyAny(newRecipes)

  switch stringified {
  | None => Js.log("Could not stringify recipe")
  | Some(string) => setItem("recipes", string) 
  }
}