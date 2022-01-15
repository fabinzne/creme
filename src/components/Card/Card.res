%raw("require('./styles.css')")

@react.component
let make = (~data: Recipe.raw, ~delete, ~update, ~onClick) => {

  let deleteHandler = (e) => {
    ReactEvent.Mouse.stopPropagation(e)

    delete(data)
  }

  let updateHandler = (e) => {
    ReactEvent.Mouse.stopPropagation(e)

    update(data)
  }

  let openRecipe = (e) => {
    ReactEvent.Mouse.stopPropagation(e)

    onClick(data)
  }

  <div className="card-root" onClick={openRecipe}>
    <header>
      <img className="hero-img" src={data.hero} alt={data.name} />
    </header>
    <section className="card-content">
      <h3 id="section">{React.string(data.name)}</h3>
      <section>
        <p id="section">{React.string(Js.String.slice(~from=0, ~to_=50, data.description))}</p>
        {String.length(data.description) > 50 ? <p>{React.string("...")}</p> : <></>}
      </section>
      <form>
        <section className="actions">
          <button className="edit-button" onClick={updateHandler}>{React.string("Edit")}</button>
          <button className="delete-button" onClick={deleteHandler}>{React.string("Delete")}</button>
        </section>
      </form>
    </section>
  </div>
}