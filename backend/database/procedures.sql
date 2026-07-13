USE argon;

DROP PROCEDURE IF EXISTS sp_listar_processos;

DELIMITER //

CREATE PROCEDURE sp_listar_processos(
    IN p_limite INT,
    IN p_offset INT
)
BEGIN
    SELECT
        id_processo,
        processo,
        numero,
        ano,
        area_ha,
        id_anm,
        fase,
        ult_evento,
        nome,
        subs,
        uso,
        uf,
        ds_processo,
        ultima_atualizacao
    FROM processo_minerario
    ORDER BY id_processo DESC
    LIMIT p_limite OFFSET p_offset;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_total_processos;

DELIMITER //

CREATE PROCEDURE sp_total_processos()
BEGIN
    SELECT COUNT(*) AS total
    FROM processo_minerario;
END //

DELIMITER ;