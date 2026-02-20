-- Data manipulation queries for Bill's PC Pokemon Database
-- Matches ddl.sql table/column names:
-- Types, Pokemon, Trainers, Locations, Captures

-- --------------------------------------------------------------
-- Types Page
-- --------------------------------------------------------------

-- Display all types
SELECT type_id, type_name, description, strong_against, weak_against
FROM Types
ORDER BY type_name;

-- Add a type
INSERT INTO Types (type_name, description, strong_against, weak_against)
VALUES (@type_nameInput, @descriptionInput, @strong_againstInput, @weak_againstInput);

-- Update a type
UPDATE Types
SET type_name = @type_nameInput,
    description = @descriptionInput,
    strong_against = @strong_againstInput,
    weak_against = @weak_againstInput
WHERE type_id = @type_idFromForm;

-- Delete a type
DELETE FROM Types
WHERE type_id = @type_idFromForm;


-- --------------------------------------------------------------
-- Pokemon Page
-- --------------------------------------------------------------

-- Display all Pokemon (UI-friendly: show type_name via JOIN)
SELECT
  p.pokemon_id,
  p.pokemon_name,
  p.type_id,
  t.type_name AS type_name,
  p.level,
  p.shiny_status,
  p.can_evolve,
  p.evolution_stage,
  p.category
FROM Pokemon p
JOIN Types t ON p.type_id = t.type_id
ORDER BY p.pokemon_id;

-- Dropdown menu for Pokemon.type_id
SELECT type_id, type_name
FROM Types
ORDER BY type_name;

-- Add a Pokemon
INSERT INTO Pokemon (type_id, pokemon_name, level, shiny_status, can_evolve, evolution_stage, category)
VALUES (@type_idDropdown, @pokemon_nameInput, @levelInput, @shiny_statusInput, @can_evolveInput, @evolution_stageInput, @categoryInput);

-- Update a Pokemon
UPDATE Pokemon
SET type_id = @type_idDropdown,
    pokemon_name = @pokemon_nameInput,
    level = @levelInput,
    shiny_status = @shiny_statusInput,
    can_evolve = @can_evolveInput,
    evolution_stage = @evolution_stageInput,
    category = @categoryInput
WHERE pokemon_id = @pokemon_idFromForm;

-- Delete a Pokemon
DELETE FROM Pokemon
WHERE pokemon_id = @pokemon_idFromForm;


-- --------------------------------------------------------------
-- Trainers Page
-- --------------------------------------------------------------

-- Display all trainers
SELECT trainer_id, trainer_name
FROM Trainers
ORDER BY trainer_id;

-- Add a trainer
INSERT INTO Trainers (trainer_name)
VALUES (@trainer_nameInput);

-- Update a trainer
UPDATE Trainers
SET trainer_name = @trainer_nameInput
WHERE trainer_id = @trainer_idFromForm;

-- Delete a trainer
DELETE FROM Trainers
WHERE trainer_id = @trainer_idFromForm;


-- --------------------------------------------------------------
-- Locations Page
-- --------------------------------------------------------------

-- Display all locations
SELECT location_id, location_name, environment, region
FROM Locations
ORDER BY location_id;

-- Add a location
INSERT INTO Locations (location_name, environment, region)
VALUES (@location_nameInput, @environmentInput, @regionInput);

-- Update a location
UPDATE Locations
SET location_name = @location_nameInput,
    environment = @environmentInput,
    region = @regionInput
WHERE location_id = @location_idFromForm;

-- Delete a location
DELETE FROM Locations
WHERE location_id = @location_idFromForm;


-- --------------------------------------------------------------
-- Captures Page
-- --------------------------------------------------------------

-- Display all captures (joined for readability)
SELECT
  c.capture_id,
  c.pokemon_id,
  p.pokemon_name,
  t.type_name AS pokemon_type,
  c.trainer_id,
  tr.trainer_name,
  c.location_id,
  l.location_name,
  l.region,
  c.capture_date,
  c.capture_status
FROM Captures c
JOIN Pokemon p   ON c.pokemon_id = p.pokemon_id
JOIN Types t     ON p.type_id = t.type_id
JOIN Trainers tr ON c.trainer_id = tr.trainer_id
JOIN Locations l ON c.location_id = l.location_id
ORDER BY c.capture_id;

-- Dropdowns for Add/Update Capture
SELECT pokemon_id, pokemon_name FROM Pokemon ORDER BY pokemon_name;
SELECT trainer_id, trainer_name FROM Trainers ORDER BY trainer_name;
SELECT location_id, location_name FROM Locations ORDER BY location_name;

-- Add a capture
INSERT INTO Captures (pokemon_id, trainer_id, location_id, capture_date, capture_status)
VALUES (@pokemon_idDropdown, @trainer_idDropdown, @location_idDropdown, @capture_dateInput, @capture_statusInput);

-- Update a capture
UPDATE Captures
SET pokemon_id = @pokemon_idDropdown,
    trainer_id = @trainer_idDropdown,
    location_id = @location_idDropdown,
    capture_date = @capture_dateInput,
    capture_status = @capture_statusInput
WHERE capture_id = @capture_idFromForm;

-- Delete a capture
DELETE FROM Captures
WHERE capture_id = @capture_idFromForm;

