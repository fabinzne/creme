open Route

@react.component
let make = () => {
  let (route, setRoute) = React.useState(() => Home)

  let handleRoute = (nextRoute) => {
    setRoute((_state) => nextRoute)
  }

  switch route {
  | Home => <Home updateRoute={handleRoute} />
  | NewRecipe => <NewRecipe data={None} updateRoute={handleRoute} />
  | UpdatedRecipe(recipe) => <NewRecipe data={Some(recipe)} updateRoute={handleRoute} />
  | Recipe(recipe) => <RecipeScreen goBack={() => setRoute((_) => Home)} data={recipe} />
  }
}