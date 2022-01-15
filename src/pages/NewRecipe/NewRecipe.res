%raw("require('./styles.css')")

@react.component
let make = (~data, ~updateRoute) => {
  let initial_state: Recipe.raw = { 
    name: "", 
    description: "", 
    hero: "", 
    ingredients: [], 
    equipaments: []
  }


  let (recipe, setRecipe) = React.useState(() => {
    switch data {
    | Some(el) => el
    | None => initial_state
    }
  })

  let (isAddNewIngredient, setIsAddNewIngredient) = React.useState(() => false)
  let (isAddNewEquipament, setIsAddNewEquipament) = React.useState(() => false)

  let handleRecipeName = React.useCallback((e) => {
    ReactEvent.Form.preventDefault(e);

    let value = ReactEvent.Form.target(e)["value"];

    setRecipe((prev) => {
      { ...prev, name: value };
    })
  })

  let handleRecipeDescription = React.useCallback((e) => {
    ReactEvent.Form.preventDefault(e);

    let value = ReactEvent.Form.target(e)["value"];

    setRecipe((prev) => {
      { ...prev, description: value };
    })
  })

  let handleRecipeHero = React.useCallback((e) => {
    ReactEvent.Form.preventDefault(e);

    let value = ReactEvent.Form.target(e)["value"];

    setRecipe((prev) => {
      { ...prev, hero: value };
    })
  })

  let handleAddNewIngredient = (e) => {
    ReactEvent.Mouse.preventDefault(e);

    setIsAddNewIngredient((_) => true)
  }

  let handleAddNewEquipament = e => {
    ReactEvent.Mouse.preventDefault(e);

    setIsAddNewEquipament((_) => true)
  }

  let handleFinishAddIngredient = (ingredient) => {
    setRecipe((prev) => {
      { ...prev, ingredients: Js.Array.concat([ingredient], prev.ingredients) };
    })

    setIsAddNewIngredient((_) => false)
  }

  let handleFinishAddEquipament = (equipament) => {
    setRecipe((prev) => {
      {...prev, equipaments: Js.Array.concat([equipament], prev.equipaments) };
    })

    setIsAddNewEquipament((_) => false)
  }

  let deleteIngredient = (el: Recipe.ingredient) => {
    setRecipe((prev) => {
      { ...prev, ingredients: Js.Array.filter((ingredient: Recipe.ingredient) => ingredient.food.name != el.food.name, prev.ingredients) };
    })
  }

  let deleteEquipament = (el: Recipe.equipment) => {
    setRecipe((prev) => {
      { ...prev, equipaments: Js.Array.filter((equipament: Recipe.equipment) => equipament.tool.name != el.tool.name, prev.equipaments) };
    })
  }

  let onSubmitForm = e => {
    ReactEvent.Form.preventDefault(e);

    switch data {
    | Some(recipe) => Recipes.deleteRecipe(recipe)
    | None => ()
    }

    Recipes.setRecipe(recipe);

    updateRoute(Route.Home)
  }

  let onGoBack = e => {
    ReactEvent.Mouse.preventDefault(e);

    updateRoute(Route.Home)
  }

  <>
    <button className="go-back-button" onClick={onGoBack}>{React.string("< Voltar")}</button>
    <form onSubmit={onSubmitForm} className="recipe-form">
      <section className="img-space">
        <h1 id="section">{React.string("Hero")}</h1>
        {Js.String.length(recipe.hero) > 0 ? <img src={recipe.hero} className="recipe-form-hero-preview" /> : <></>}
        <input value={recipe.hero} className="input-type" onChange={handleRecipeHero} type_="url" placeholder="Image url..." />
      </section>
      <section className="recipe-form-section">
        <h1 id="section">{React.string("Recipe name and description")}</h1>
        <input value={recipe.name} placeholder="Recipe name..." className="input-type" onChange={handleRecipeName} />
        <textarea value={recipe.description} placeholder="Recipe description..." rows=23 className="input-type text-description" onChange={handleRecipeDescription} />
      </section>
      <section className="ingredient-form-section">
        <h1 id="section">{React.string("Ingredients")}</h1>
        <div className="wrapper">
          {Js.Array.mapi((ingredient, i) => <IngredientCard key={i |> string_of_int} delete={deleteIngredient} ingredient  />, recipe.ingredients) |> React.array}
          {isAddNewIngredient ? <NewIngredientCard onCancel={(_) => setIsAddNewIngredient((_) => false)} onFinish={handleFinishAddIngredient} /> : <button className="add-button" onClick={handleAddNewIngredient}>{React.string("+")}</button>}
        </div>
      </section>
      <section className="equipment-form-section">
        <h1 id="section">{React.string("Equipaments")}</h1>
        <div className="wrapper">
          {Js.Array.mapi((equipament, i) => <EquipamentCard key={i |> string_of_int} delete={deleteEquipament} equipament />, recipe.equipaments) |> React.array}
          {isAddNewEquipament ? <NewEquipamentCard onCancel={(_) => setIsAddNewEquipament((_) => false)} onFinish={handleFinishAddEquipament} /> : <button className="add-button" onClick={handleAddNewEquipament}>{React.string("+")}</button>}
        </div>
      </section>
      <button className="finish-button">{React.string("Add Recipe")}</button>
    </form>
  </>
}