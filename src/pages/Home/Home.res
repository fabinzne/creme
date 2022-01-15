%raw("require('./styles.css')")

open Route
open Js.String

type action = Update | Search(string)
type state = Recipe.raw  

let reducer = (_state, action) => {

  switch action {
  | Update => {
      let newRecipes = Recipes.getRecipes() 
      newRecipes
    }
  | Search(text) => {
    let recipes = Recipes.getRecipes()

    length(text) > 0 ?
      Js.Array.filter((recipe: Recipe.raw) => {
        includes(toLocaleLowerCase(text), toLocaleLowerCase(recipe.name))
      }, recipes) : recipes
    }
  }
}

@react.component
let make = (~updateRoute: Route.raw => unit) => {

  let (state, dispatch) = React.useReducer(reducer, Recipes.getRecipes())

  let delete = React.useCallback((data) => {
    Recipes.deleteRecipe(data)

    dispatch(Update)
  })

  let update = React.useCallback((data) => {
    updateRoute(UpdatedRecipe(data))
  })

  let handle = (_) => {
    updateRoute(NewRecipe)

    dispatch(Update)
  }

  let handleSearch = (e) => {
    ReactEvent.Form.preventDefault(e)
    
    let value = ReactEvent.Form.target(e)["value"]

    dispatch(Search(value))
  }

  let handleOnClick = (data) => {
    updateRoute(Recipe(data))
  }

  <div className="app-root">
    <section className="search-bar">
      <input type_="text" className="search" placeholder="Search for a recipe..." onChange={handleSearch} />
      <button className="create-new" onClick={handle}>{React.string("New Recipe")}</button>
    </section>
    <section className="wrapper">
      {Js.Array.mapi((recipe: Recipe.raw, i) => <Card onClick={handleOnClick} delete update key={string_of_int(i)} data={recipe} />, state) |> React.array}
    </section>
  </div>
}