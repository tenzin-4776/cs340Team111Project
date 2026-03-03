-- Citation: https://canvas.oregonstate.edu/courses/2031764/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=26243430


-- --------------------------------------------------------------
-- DELETE a Pokemon from the Pokemon page
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_delete_pokemon;

DELIMITER //

CREATE PROCEDURE sp_delete_pokemon(IN p_pokemon_id INT)
BEGIN
    DELETE FROM Pokemon
    WHERE pokemon_id = p_pokemon_id;
END //

DELIMITER ;
