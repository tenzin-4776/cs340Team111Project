-- --------------------------------------------------------------
-- DELETE a Pokemon from the Pokemon page
-- --------------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_DeletePokemon;

DELIMITER //

CREATE PROCEDURE sp_DeletePokemon(IN p_pokemon_id INT)
BEGIN
    DECLARE rows_deleted INT;
    START TRANSACTION;

    DELETE FROM Pokemon
    WHERE pokemon_id = p_pokemon_id;

    IF rows_deleted = 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
    
END //

DELIMITER ;
