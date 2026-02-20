
// Required Packages
require("dotenv").config();
const express = require("express");
const { engine } = require("express-handlebars");
const db = require("./database/db-connector");

const app = express();
const PORT = 9111;


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


// TYPES
app.get("/types", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Types;");
  res.render("types", { rows });
});


// POKEMON
app.get("/pokemon", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Pokemon;");
  const [types] = await db.query("SELECT type_id, type_name FROM Types;");
  res.render("pokemon", { rows, types });
});


// TRAINERS
app.get("/trainers", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Trainers;");
  res.render("trainers", { rows });
});


// LOCATIONS
app.get("/locations", async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Locations;");
  res.render("locations", { rows });
});

// CAPTURES 
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

// Start Server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});