%raw("require('./style.css')")

@react.component
let make = (~ingredient: Recipe.ingredient, ~delete, ~withoutButton=false) => {
  
  let handleDelete = e => {
    ReactEvent.Mouse.preventDefault(e)

    delete(ingredient)
  }
  
  <div className="ingredient-root">
    <section>
      <img className="img-card" src={ingredient.food.hero} />
    </section>
    <section id="information-section">
      <div> 
        <h1 id="section">{React.string(ingredient.food.name)}</h1>
        <p id="section">{React.string(Js.String.concat(Js.String.concat(ingredient.unit, " "), ingredient.quantity |> string_of_int))}</p>
      </div>
      {
        withoutButton
        ? <></>
        : <button className="finish-button" onClick={handleDelete}>{React.string("Delete")}</button>
      }
    </section>
  </div>
}