
// Required Packages
require("dotenv").config();
const express = require("express");
const { engine } = require("express-handlebars");
const db = require("./database/db-connector");

const app = express();
const PORT = 9112;

console.log("🔥 SERVER FILE LOADED FROM:", __dirname);

// View Engine Setup
app.engine(".hbs", engine({ extname: ".hbs" }));
app.set("view engine", ".hbs");
app.set("views", "./views");

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));

// Routes

// Home

app.get("/", (req, res) => {
  res.render("index");
});

// --------------------------------------------------------------
// TYPES
// --------------------------------------------------------------

app.get("/types", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Types;");
  res.render("types", { rows });
});

app.post("/types/add", async (req, res) => {
  try {
    const { type_name, description, strong_against, weak_against } = req.body;
    await db.query("CALL sp_add_type(?, ?, ?, ?, @type_id);", [type_name, description, strong_against, weak_against]);
    res.redirect("/types");
    console.log("Type added successfully");
  } catch (err) {
    console.error("Error adding type:", err);
    res.status(500).send("Add failed");
  }
});

app.post("/types/update", async (req, res) => {
  try {
    const { type_id, type_name, description, strong_against, weak_against } = req.body;
    await db.query("CALL sp_update_type(?, ?, ?, ?, ?);", [type_id, type_name, description, strong_against, weak_against]);
    res.redirect("/types");
    console.log("Type updated successfully");
  } catch (err) {
    console.error("Error updating type:", err);
    res.status(500).send("Update failed");
  }
});

app.post("/types/delete", async (req, res) => {
  try {
    const typeID = req.body.type_id;
    await db.query("CALL sp_delete_type(?);", [typeID]);

    res.redirect("/types");
  } catch (err) {
    console.error("Error deleting type:", err);
    res.status(500).send("Delete failed because the type is still referenced by a pokemon. Please delete the pokemon first.");
  }
});

// --------------------------------------------------------------
// POKEMON 
// --------------------------------------------------------------

app.get("/pokemon", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Pokemon;");
  const [types] = await db.query("SELECT type_id, type_name FROM Types;");
  res.render("pokemon", { rows, types });
});

app.post('/pokemon/add', async (req, res) => {
  try {
    const { type_id, pokemon_name, level, shiny_status, can_evolve, evolution_stage, category } = req.body;
    await db.query("CALL sp_add_pokemon(?, ?, ?, ?, ?, ?, ?, @pokemon_id);", [pokemon_name, type_id, level, shiny_status, can_evolve, evolution_stage, category]);

    res.redirect("/pokemon");
  } catch (err) {
    console.error("Error adding pokemon:", err);
    res.status(500).send("Add failed");
  }
});

app.post('/pokemon/update', async (req, res) => {
  try {
    const { pokemon_id, type_id, pokemon_name, level, shiny_status, can_evolve, evolution_stage, category } = req.body;
    await db.query("CALL sp_update_pokemon(?, ?, ?, ?, ?, ?, ?, ?);", [pokemon_id, pokemon_name, type_id, level, shiny_status, can_evolve, evolution_stage, category]);

    res.redirect("/pokemon");
  } catch (err) {
    console.error("Error updating pokemon:", err);
    res.status(500).send("Update failed");
  }
});

app.post("/pokemon/delete", async (req, res) => {
  try {
    const pokemonID = req.body.pokemon_id;
    await db.query("CALL sp_delete_pokemon(?);", [pokemonID]);
    
    res.redirect("/pokemon");
  } catch (err) {
    console.error("Error deleting pokemon:", err);
    res.status(500).send("Delete failed");
  }
});

// --------------------------------------------------------------
// TRAINERS
// --------------------------------------------------------------

app.get("/trainers", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Trainers;");
  res.render("trainers", { rows });
});

app.post("/trainers/add", async (req, res) => {
  try {
    const { trainer_name } = req.body;
    await db.query("CALL sp_add_trainer(?, @trainer_id);", [trainer_name]);
    
    res.redirect("/trainers");
  } catch (err) {
    console.error("Error adding trainer:", err);
    res.status(500).send("Add failed");
  }
});

app.post("/trainers/update", async (req, res) => {
  try {
    const { trainer_id, trainer_name } = req.body;
    await db.query("CALL sp_update_trainer(?, ?);", [trainer_id, trainer_name]);
    
    res.redirect("/trainers");
  } catch (err) {
    console.error("Error updating trainer:", err);
    res.status(500).send("Update failed");
  }
});

app.post("/trainers/delete", async (req, res) => {
  try {
    const { trainer_id } = req.body;
    await db.query("CALL sp_delete_trainer(?);", [trainer_id]);
    
    res.redirect("/trainers");
  } catch (err) {
    console.error("Error deleting trainer:", err);
    res.status(500).send("Delete failed");
  }
});

// --------------------------------------------------------------
// LOCATIONS
// --------------------------------------------------------------

app.get("/locations", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Locations;");
  res.render("locations", { rows });
});

app.post("/locations/add", async (req, res) => {
  try {
    const { location_name, environment, region } = req.body;
    await db.query("CALL sp_add_location(?, ?, ?, @location_id);", [location_name, environment, region]);

    res.redirect("/locations");
  } catch (err) {
    console.error("Error adding location:", err);
    res.status(500).send("Add failed");
  }
});

app.post("/locations/update", async (req, res) => {
  try {
    const { location_id, location_name, environment, region } = req.body;
    await db.query("CALL sp_update_location(?, ?, ?, ?);", [location_id, location_name, environment, region]);
    
    res.redirect("/locations");
  } catch (err) {
    console.error("Error updating location:", err);
    res.status(500).send("Update failed");
  }
});

app.post("/locations/delete", async (req, res) => {
  try {
    const { location_id } = req.body;
    await db.query("CALL sp_delete_location(?);", [location_id]);
    
    res.redirect("/locations");
  } catch (err) {
    console.error("Error deleting location:", err);
    res.status(500).send("Delete failed");
  }
});

// --------------------------------------------------------------
// CAPTURES 
// --------------------------------------------------------------

app.get("/captures", async (req, res) => {
  const [rows] = await db.query(`
    SELECT 
      c.capture_id,
      c.pokemon_id,
      p.pokemon_name,
      c.trainer_id,
      t.trainer_name,
      c.location_id,
      l.location_name,
      c.capture_date,
      c.capture_status
    FROM Captures c
    JOIN Pokemon p ON c.pokemon_id = p.pokemon_id
    JOIN Trainers t ON c.trainer_id = t.trainer_id
    JOIN Locations l ON c.location_id = l.location_id;
  `);

  const [pokemon] = await db.query("SELECT pokemon_id, pokemon_name FROM Pokemon;");
  const [trainers] = await db.query("SELECT trainer_id, trainer_name FROM Trainers;");
  const [locations] = await db.query("SELECT location_id, location_name FROM Locations;");

  res.render("captures", {
    rows,
    pokemon,
    trainers,
    locations
  });
});

app.post("/captures/add", async (req, res) => {
  try {
    const { pokemon_id, trainer_id, location_id, capture_date, capture_status } = req.body;
    await db.query("CALL sp_add_capture(?, ?, ?, ?, ?, @capture_id);", [pokemon_id, trainer_id, location_id, capture_date, capture_status]);
    
    res.redirect("/captures");
  } catch (err) {
    console.error("Error adding capture:", err);
    res.status(500).send("Add failed");
  }
});

app.post("/captures/update", async (req, res) => {
  try {
    const { capture_id, pokemon_id, trainer_id, location_id, capture_date, capture_status } = req.body;
    await db.query("CALL sp_update_capture(?, ?, ?, ?, ?, ?);", [capture_id, pokemon_id || null, trainer_id || null, location_id || null, capture_date || null, capture_status || null]);
    
    res.redirect("/captures");
  } catch (err) {
    console.error("Error updating capture:", err);
    res.status(500).send("Update failed");
  }
});

app.post("/captures/delete", async (req, res) => {
  try {
    const { capture_id } = req.body;
    await db.query("CALL sp_delete_capture(?);", [capture_id]);
    
    res.redirect("/captures");
  } catch (err) {
    console.error("Error deleting capture:", err);
    res.status(500).send("Delete failed");
  }
});

// --------------------------------------------------------------
// RESET Database
// --------------------------------------------------------------

app.get('/reset', async (req, res) => {
  try {
    await db.query('CALL sp_reset();');
    res.redirect('/');
  } catch (err) {
    console.error('RESET ERROR:', err);
    res.status(500).send('Reset failed. Check server logs.');
  }
});

// Start Server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});