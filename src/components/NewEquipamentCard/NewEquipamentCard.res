@react.component
let make = (~onFinish, ~onCancel) => {
  let initial_state: Recipe.equipment = {
    tool: {
      name: "",
      hero: "",
    },
    quantity: 0,
  }

  let (equipament, setEquipament) = React.useState(() => initial_state)

  let handleToolName = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"]

    setEquipament((prev) => {
      {...prev, tool: {...prev.tool, name: value}}
    })
  }

  let handleToolHero = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"]

    setEquipament((prev) => {
      {...prev, tool: {...prev.tool, hero: value}}
    })
  }

  let handleQuantity = (e) => {
    ReactEvent.Form.preventDefault(e)

    let value = ReactEvent.Form.target(e)["value"]

    setEquipament((prev) => {
      {...prev, quantity: value}
    })
  }

  let handleSubmit = (e) => {
    ReactEvent.Mouse.preventDefault(e)

    onFinish(equipament)
  }

  let handleCancel = (e) => {
    ReactEvent.Mouse.preventDefault(e)

    onCancel()
  }

  <div>
      {Js.String.length(equipament.tool.hero) > 0 ? <> <img src={equipament.tool.hero} className="recipe-form-hero-preview" /> <br/> </> : <></>}
    <input className="input-type" type_="url" value={equipament.tool.hero} placeholder="Tool hero image url..." onChange={handleToolHero} />
    <input className="input-type" type_="text" value={equipament.tool.name} placeholder="Tool name..." onChange={handleToolName} />
    <input className="input-type" type_="number" value={equipament.quantity |> string_of_int} placeholder="Quantity" onChange={handleQuantity} />

    <section className="button-section">
      <button className="finish-button" onClick={handleSubmit}>{React.string("Add")}</button>
      <button className="finish-button" onClick={handleCancel}>{React.string("Cancel")}</button>
    </section>
  </div>
}