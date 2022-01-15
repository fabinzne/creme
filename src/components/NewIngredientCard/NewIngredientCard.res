%raw("require('./style.css')")

@react.component
let make = (~onFinish, ~onCancel) => {
  let ingredient_initial_state: Recipe.ingredient = {
    food: {
      name: "",
      hero: "",
    },
    unit: "",
    quantity: 0
  }

  let (ingredient, setIngredient) = React.useState(() => ingredient_initial_state)

  let handleFoodName = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"];

    setIngredient((prev) => {
      {...prev, food: { ...prev.food, name: value } }
    })
  }

  let handleFoodHero = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"];

    setIngredient((prev) => {
      {...prev, food: { ...prev.food, hero: value } }
    })
  }

  let handleQuantity = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"];
    
    setIngredient((prev) => {
      {...prev, quantity: value }
    })
  }

  let handleUnit = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"];

    setIngredient((prev) => {
      {...prev, unit: value }
    })
  }

  let handleFinishAddIngredient = (e) => {
    ReactEvent.Mouse.preventDefault(e)

    onFinish(ingredient)

    setIngredient((_) => ingredient_initial_state)
  }

  let handleCancel = (e) => {
    ReactEvent.Mouse.preventDefault(e)

    onCancel()
  }

  <div className="root-ingredient">
    <div>
      {Js.String.length(ingredient.food.hero) > 0 ? <> <img src={ingredient.food.hero} className="recipe-form-hero-preview" /> <br /> </> : <></>}
      <input className="input-type ingredient-input" type_="url" placeholder="Ingredient image url..." value={ingredient.food.hero} onChange={handleFoodHero} />
      <input className="input-type ingredient-input" type_="text" placeholder="Ingredient name..." value={ingredient.food.name} onChange={handleFoodName} />
    </div>
    <label>
      {React.string("Quantity: ")}
      <input className="input-type ingredient-input" type_="number" value={ingredient.quantity |> string_of_int} onChange={handleQuantity} />
    </label>

    <input className="input-type ingredient-input" type_="text" placeholder="Ingredient unit... (ml, klg)" value={ingredient.unit} onChange={handleUnit} />

    <section className="button-section">
      <button className="finish-button" onClick={handleFinishAddIngredient}>{React.string("Add")}</button>
      <button className="finish-button" onClick={handleCancel}>{React.string("Cancel")}</button>
    </section>
  </div>
}