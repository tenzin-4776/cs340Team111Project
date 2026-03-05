-- Citation: https://canvas.oregonstate.edu/courses/2031764/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=26243430

-- --------------------------------------------------------------
-- ADD a Type 
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_add_type;

DELIMITER //

CREATE PROCEDURE sp_add_type(
    IN p_type_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_strong_against VARCHAR(255),
    IN p_weak_against VARCHAR(255),
    OUT p_type_id INT)
BEGIN
    INSERT INTO Types (type_name, description, strong_against, weak_against)
    VALUES (p_type_name, p_description, p_strong_against, p_weak_against);

    SELECT LAST_INSERT_ID() into p_type_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- UPDATE a Type 
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_update_type;

DELIMITER //

CREATE PROCEDURE sp_update_type(
    IN p_type_id INT,
    IN p_type_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_strong_against VARCHAR(255),
    IN p_weak_against VARCHAR(255)
)
BEGIN
    UPDATE Types
    SET type_name = p_type_name,
        description = p_description,
        strong_against = p_strong_against,
        weak_against = p_weak_against
    WHERE type_id = p_type_id;
END //

DELIMITER ;

-- --------------------------------------------------------------
-- DELETE a Type
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_type;

DELIMITER //

CREATE PROCEDURE sp_delete_type(IN p_type_id INT)
BEGIN
        DELETE FROM Types
        WHERE type_id = p_type_id;

END //

DELIMITER ;

-- --------------------------------------------------------------
-- ADD a Pokemon
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_add_pokemon;

DELIMITER //

CREATE PROCEDURE sp_add_pokemon(
    IN p_pokemon_name VARCHAR(255),
    IN p_type_id INT,
    IN p_level INT,
    IN p_shiny_status TINYINT(1),
    IN p_can_evolve TINYINT(1),
    IN p_evolution_stage TINYINT(1),
    IN p_category VARCHAR(255),
    OUT p_pokemon_id INT)
BEGIN
    INSERT INTO Pokemon (pokemon_name, type_id, level, shiny_status, can_evolve, evolution_stage, category)
    VALUES (p_pokemon_name, p_type_id, p_level, p_shiny_status, p_can_evolve, p_evolution_stage, p_category);

    -- Store ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_pokemon_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- UPDATE a Pokemon
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_update_pokemon;

DELIMITER //

CREATE PROCEDURE sp_update_pokemon(
    IN p_pokemon_id INT,
    IN p_pokemon_name VARCHAR(255),
    IN p_type_id INT,
    IN p_level INT,
    IN p_shiny_status TINYINT(1),
    IN p_can_evolve TINYINT(1),
    IN p_evolution_stage TINYINT(1),
    IN p_category VARCHAR(255)
)
BEGIN
    UPDATE Pokemon
    SET pokemon_name = p_pokemon_name,
        type_id = p_type_id,
        level = p_level,
        shiny_status = p_shiny_status,
        can_evolve = p_can_evolve,
        evolution_stage = p_evolution_stage,
        category = p_category
    WHERE pokemon_id = p_pokemon_id;
END //

DELIMITER ;

-- --------------------------------------------------------------
-- DELETE a Pokemon
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_pokemon;

DELIMITER //

CREATE PROCEDURE sp_delete_pokemon(IN p_pokemon_id INT)
BEGIN
    DELETE FROM Pokemon
    WHERE pokemon_id = p_pokemon_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- ADD a Trainer 
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_add_trainer;
DELIMITER //

CREATE PROCEDURE sp_add_trainer(IN p_trainer_name VARCHAR(45), OUT p_trainer_id INT)
BEGIN
    INSERT INTO Trainers (trainer_name)
    VALUES (p_trainer_name);

    SELECT LAST_INSERT_ID() into p_trainer_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- UPDATE a Trainer 
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_update_trainer;

DELIMITER //
CREATE PROCEDURE sp_update_trainer(IN p_trainer_id INT, IN p_trainer_name VARCHAR(45))
BEGIN
    UPDATE Trainers
    SET trainer_name = p_trainer_name
    WHERE trainer_id = p_trainer_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- DELETE a Trainer
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_delete_trainer;
DELIMITER //

CREATE PROCEDURE sp_delete_trainer(IN p_trainer_id INT)
BEGIN
    DELETE FROM Trainers
    WHERE trainer_id = p_trainer_id;
END //
DELIMITER ;

-- --------------------------------------------------------------
-- ADD a Location
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_add_location;
DELIMITER //

CREATE PROCEDURE sp_add_location(
    IN p_location_name VARCHAR(45),
    IN p_environment VARCHAR(45),
    IN p_region VARCHAR(45),
    OUT p_location_id INT
)
BEGIN
    INSERT INTO Locations (location_name, environment, region)
    VALUES (p_location_name, p_environment, p_region);

    SELECT LAST_INSERT_ID() into p_location_id;
END //
DELIMITER ;

-- --------------------------------------------------------------
-- UPDATE a Location
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_update_location;
DELIMITER //

CREATE PROCEDURE sp_update_location(
    IN p_location_id INT,
    IN p_location_name VARCHAR(45),
    IN p_environment VARCHAR(45),
    IN p_region VARCHAR(45)
)
BEGIN
    UPDATE Locations
    SET location_name = p_location_name,
        environment = p_environment,
        region = p_region
    WHERE location_id = p_location_id;
END //
DELIMITER ;

-- --------------------------------------------------------------
-- DELETE a Location
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_delete_location;
DELIMITER //

CREATE PROCEDURE sp_delete_location(IN p_location_id INT)
BEGIN
    DELETE FROM Locations
    WHERE location_id = p_location_id;
END //
DELIMITER ;

-- --------------------------------------------------------------
-- ADD a Capture
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_add_capture;
DELIMITER //

CREATE PROCEDURE sp_add_capture(
    IN p_pokemon_id INT,
    IN p_trainer_id INT,
    IN p_location_id INT,
    IN p_capture_date DATE,
    IN p_capture_status VARCHAR(45),
    OUT p_capture_id INT
)
BEGIN
    INSERT INTO Captures (pokemon_id, trainer_id, location_id, capture_date, capture_status)
    VALUES (p_pokemon_id, p_trainer_id, p_location_id, p_capture_date, p_capture_status);

    SELECT LAST_INSERT_ID() into p_capture_id;

END //
DELIMITER ;

-- --------------------------------------------------------------
-- UPDATE a Capture
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_update_capture;
DELIMITER //

CREATE PROCEDURE sp_update_capture(
    IN p_capture_id INT,
    IN p_pokemon_id INT,
    IN p_trainer_id INT,
    IN p_location_id INT,
    IN p_capture_date DATE,
    IN p_capture_status VARCHAR(45)
)
BEGIN
    UPDATE Captures
    SET pokemon_id = p_pokemon_id,
        trainer_id = p_trainer_id,
        location_id = p_location_id,
        capture_date = p_capture_date,
        capture_status = p_capture_status
    WHERE capture_id = p_capture_id;

END //
DELIMITER ;
-- --------------------------------------------------------------
-- DELETE a Capture
-- --------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_delete_capture;
DELIMITER //

CREATE PROCEDURE sp_delete_capture(IN p_capture_id INT)
BEGIN
    DELETE FROM Captures
    WHERE capture_id = p_capture_id;
    
END //
DELIMITER ;

-- --------------------------------------------------------------
-- RESET the database
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_reset;
DELIMITER //

CREATE PROCEDURE sp_reset()
BEGIN


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
END//

DELIMITER ;