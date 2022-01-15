type food = {
  name: string,
  hero: string
};

type ingredient = {
  food,
  quantity: int,
  unit: string
};

type tool = {
  name: string,
  hero: string
};

type equipment = {
  tool,
  quantity: int
};

type raw = {
  name: string,
  description: string,
  hero: string,
  ingredients: array<ingredient>,
  equipaments: array<equipment>,
}

