SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Captures;
DROP TABLE IF EXISTS Pokemon;
DROP TABLE IF EXISTS Trainers;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Types;

SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------
-- Types
-- -----------------------
CREATE TABLE Types (
  type_id INT NOT NULL AUTO_INCREMENT,
  type_name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NULL,
  strong_against VARCHAR(255) NULL,
  weak_against VARCHAR(255) NULL,
  PRIMARY KEY (type_id),
  UNIQUE KEY uq_types_type_name (type_name)
) ENGINE=InnoDB;

-- -----------------------
-- Pokemon
-- -----------------------
CREATE TABLE Pokemon (
  pokemon_id INT NOT NULL AUTO_INCREMENT,
  pokemon_name VARCHAR(255) NOT NULL,
  type_id INT NOT NULL,
  level INT NOT NULL,
  shiny_status TINYINT(1) NOT NULL DEFAULT 0,
  can_evolve TINYINT(1) NOT NULL DEFAULT 0,
  evolution_stage TINYINT(1) NOT NULL,
  category VARCHAR(255) NULL,
  PRIMARY KEY (pokemon_id),
  CONSTRAINT fk_pokemon_type
    FOREIGN KEY (type_id)
    REFERENCES Types(type_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------
-- Trainers
-- -----------------------
CREATE TABLE Trainers (
  trainer_id INT NOT NULL AUTO_INCREMENT,
  trainer_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (trainer_id)
) ENGINE=InnoDB;

-- -----------------------
-- Locations
-- -----------------------
CREATE TABLE Locations (
  location_id INT NOT NULL AUTO_INCREMENT,
  location_name VARCHAR(45) NOT NULL,
  environment VARCHAR(45) NOT NULL,
  region VARCHAR(45) NOT NULL,
  PRIMARY KEY (location_id)
) ENGINE=InnoDB;

-- -----------------------
-- Captures 
-- -----------------------
CREATE TABLE Captures (
  capture_id INT NOT NULL AUTO_INCREMENT,
  pokemon_id INT NOT NULL,
  trainer_id INT NOT NULL,
  location_id INT NOT NULL,
  capture_date DATE NOT NULL,
  capture_status VARCHAR(45) NOT NULL,
  PRIMARY KEY (capture_id),
  CONSTRAINT fk_captures_pokemon
    FOREIGN KEY (pokemon_id)
    REFERENCES Pokemon(pokemon_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_captures_trainer
    FOREIGN KEY (trainer_id)
    REFERENCES Trainers(trainer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_captures_location
    FOREIGN KEY (location_id)
    REFERENCES Locations(location_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Sample Data 


INSERT INTO Types (type_name, description, strong_against, weak_against) VALUES
  ('Fire', 'Hot and aggressive type.', 'Grass, Ice, Bug, Steel', 'Water, Rock, Ground'),
  ('Water', 'Adaptable and fluid type.', 'Fire, Rock, Ground', 'Electric, Grass'),
  ('Grass', 'Nature-based type.', 'Water, Rock, Ground', 'Fire, Ice, Flying, Bug'),
  ('Electric', 'Fast and high-voltage type.', 'Water, Flying', 'Ground'),
  ('Flying', 'Aerial mobility type.', 'Grass, Bug, Fighting', 'Electric, Rock, Ice');

INSERT INTO Trainers (trainer_name) VALUES
  ('Ash Ketchum'),
  ('Misty'),
  ('Brock'),
  ('Julian');

INSERT INTO Locations (location_name, environment, region) VALUES
  ('Pallet Town', 'Town', 'Kanto'),
  ('Viridian Forest', 'Forest', 'Kanto'),
  ('Cerulean City', 'City', 'Kanto'),
  ('Pewter City', 'City', 'Kanto'),
  ('Mt. Moon', 'Cave', 'Kanto');

INSERT INTO Pokemon (pokemon_name, type_id, level, shiny_status, can_evolve, evolution_stage, category) VALUES
  ('Charmander', (SELECT type_id FROM Types WHERE type_name='Fire'), 12, 0, 1, 1, 'Lizard'),
  ('Squirtle',   (SELECT type_id FROM Types WHERE type_name='Water'), 10, 0, 1, 1, 'Tiny Turtle'),
  ('Bulbasaur',  (SELECT type_id FROM Types WHERE type_name='Grass'), 11, 0, 1, 1, 'Seed'),
  ('Pikachu',    (SELECT type_id FROM Types WHERE type_name='Electric'), 15, 1, 1, 2, 'Mouse'),
  ('Pidgey',     (SELECT type_id FROM Types WHERE type_name='Flying'),  7, 0, 1, 1, 'Tiny Bird');

-- Captures demonstrates:
--  - same trainer in multiple captures (Ash)
--  - same pokemon in multiple captures (Pikachu)
--  - FKs line up
INSERT INTO Captures (pokemon_id, trainer_id, location_id, capture_date, capture_status) VALUES
  (
    (SELECT pokemon_id FROM Pokemon WHERE pokemon_name='Bulbasaur'),
    (SELECT trainer_id FROM Trainers WHERE trainer_name='Ash Ketchum'),
    (SELECT location_id FROM Locations WHERE location_name='Pallet Town'),
    '2026-02-01',
    'Captured'
  ),
  (
    (SELECT pokemon_id FROM Pokemon WHERE pokemon_name='Pikachu'),
    (SELECT trainer_id FROM Trainers WHERE trainer_name='Ash Ketchum'),
    (SELECT location_id FROM Locations WHERE location_name='Viridian Forest'),
    '2026-02-02',
    'Captured'
  ),
  (
    (SELECT pokemon_id FROM Pokemon WHERE pokemon_name='Pikachu'),
    (SELECT trainer_id FROM Trainers WHERE trainer_name='Julian'),
    (SELECT location_id FROM Locations WHERE location_name='Cerulean City'),
    '2026-02-03',
    'Captured'
  ),
  (
    (SELECT pokemon_id FROM Pokemon WHERE pokemon_name='Charmander'),
    (SELECT trainer_id FROM Trainers WHERE trainer_name='Brock'),
    (SELECT location_id FROM Locations WHERE location_name='Pewter City'),
    '2026-02-04',
    'Captured'
  );