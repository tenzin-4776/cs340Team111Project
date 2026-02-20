const express = require("express");
const { engine } = require("express-handlebars");

const app = express();
const PORT = 9111; 

app.engine(".hbs", engine({ extname: ".hbs" }));
app.set("view engine", ".hbs");
app.set("views", "./views");

app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

const sampleTypes = [
  { type_id: 1, type_name: "Electric", description: "High voltage", strong_against: "Water", weak_against: "Ground" },
  { type_id: 2, type_name: "Fire", description: "Burns stuff", strong_against: "Grass", weak_against: "Water" },
  { type_id: 3, type_name: "Water", description: "Splash", strong_against: "Fire", weak_against: "Electric" },
];

const samplePokemon = [
  { pokemon_id: 1, type_id: 1, pokemon_name: "Pikachu", level: 12, shiny_status: 0, can_evolve: 1, evolution_stage: 1, category: "Mouse" },
  { pokemon_id: 2, type_id: 2, pokemon_name: "Charmander", level: 9, shiny_status: 0, can_evolve: 1, evolution_stage: 1, category: "Lizard" },
];

const sampleTrainers = [
  { trainer_id: 1, trainer_name: "Ash" },
  { trainer_id: 2, trainer_name: "Misty" },
];

const sampleLocations = [
  { location_id: 1, location_name: "Viridian Forest", environment: "Forest", region: "Kanto" },
  { location_id: 2, location_name: "Pewter City", environment: "City", region: "Kanto" },
];

const sampleCaptures = [
  { capture_id: 1, pokemon_id: 1, trainer_id: 1, location_id: 1, capture_date: "2026-02-10", capture_status: "Caught" },
];

// --- Routes ---
app.get("/", (req, res) => {
  res.render("index");
});

app.get("/types", (req, res) => {
  res.render("types", { rows: sampleTypes });
});

app.get("/pokemon", (req, res) => {
  res.render("pokemon", { rows: samplePokemon, types: sampleTypes });
});

app.get("/trainers", (req, res) => {
  res.render("trainers", { rows: sampleTrainers });
});

app.get("/locations", (req, res) => {
  res.render("locations", { rows: sampleLocations });
});

app.get("/captures", (req, res) => {
  const pokemonMap = Object.fromEntries(samplePokemon.map(p => [p.pokemon_id, p.pokemon_name]));
  const trainerMap = Object.fromEntries(sampleTrainers.map(t => [t.trainer_id, t.trainer_name]));
  const locationMap = Object.fromEntries(sampleLocations.map(l => [l.location_id, l.location_name]));

  const viewRows = sampleCaptures.map(c => ({
    ...c,
    pokemon_label: pokemonMap[c.pokemon_id] ? `${pokemonMap[c.pokemon_id]} (ID ${c.pokemon_id})` : `ID ${c.pokemon_id}`,
    trainer_label: trainerMap[c.trainer_id] ? `${trainerMap[c.trainer_id]} (ID ${c.trainer_id})` : `ID ${c.trainer_id}`,
    location_label: locationMap[c.location_id] ? `${locationMap[c.location_id]} (ID ${c.location_id})` : `ID ${c.location_id}`,
  }));

  res.render("captures", {
    rows: viewRows,
    pokemon: samplePokemon,
    trainers: sampleTrainers,
    locations: sampleLocations,
  });
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});