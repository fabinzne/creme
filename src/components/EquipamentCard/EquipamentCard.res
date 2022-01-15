%raw("require('./style.css')")
@react.component
let make = (~equipament: Recipe.equipment, ~delete, ~withoutButton=false) => {

  let handleDelete = e => {
    ReactEvent.Mouse.preventDefault(e)

    delete(equipament)
  }

  <div className="equipament-root">
    <section>
      <img className="img-card" src={equipament.tool.hero} />
    </section>
    <section id="information-section">
      <h1 id="section">{React.string(equipament.tool.name)}</h1>
      <p id="section">{React.string(equipament.quantity |> string_of_int)}</p>
      {withoutButton ? <></> : <button className="finish-button" onClick={handleDelete}>{React.string("Delete")}</button>}
    </section>
  </div>
}