@react.component
let make = (~data: Recipe.raw, ~goBack) => {

  let handleGoback = (_) => {
    goBack()
  }

  <>
    <button className="go-back-button" onClick={handleGoback}>{React.string("< Voltar")}</button>
    <div>
      <h1 id="section">{React.string(data.name)}</h1>
      <p id="section">{React.string(data.description)}</p>
      <section className="wrapper">
        {Js.Array.mapi((ingredient, i) => <IngredientCard key={i |> string_of_int} delete={(_) => {let _ = Js.null}} ingredient withoutButton={true} />, data.ingredients) |> React.array}
      </section>
      <section className="wrapper">
        {Js.Array.mapi((equipament, i) => <EquipamentCard key={i |> string_of_int} delete={(_) =>{let _ = Js.null}} equipament withoutButton={true} />, data.equipaments) |> React.array}
      </section>
    </div>
  </>
}