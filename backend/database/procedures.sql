USE argon;

DROP PROCEDURE IF EXISTS sp_listar_processos;

DELIMITER / / CREATE PROCEDURE sp_listar_processos (IN p_limite INT, IN p_offset INT) BEGIN
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
FROM
    processo_minerario
ORDER BY
    id_processo DESC
LIMIT
    p_limite
OFFSET
    p_offset;

END / / DELIMITER;

DROP PROCEDURE IF EXISTS sp_total_processos;

DELIMITER / / CREATE PROCEDURE sp_total_processos () BEGIN
SELECT
    COUNT(*) AS total
FROM
    processo_minerario;

END / / DELIMITER;

DROP PROCEDURE IF EXISTS sp_pesquisar_processos;

DELIMITER / / CREATE PROCEDURE sp_pesquisar_processos (
    IN p_termo VARCHAR(150),
    IN p_limite INT,
    IN p_offset INT
) BEGIN
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
FROM
    processo_minerario
WHERE
    processo LIKE CONCAT ('%', p_termo, '%')
    OR nome LIKE CONCAT ('%', p_termo, '%')
    OR subs LIKE CONCAT ('%', p_termo, '%')
ORDER BY
    id_processo DESC
LIMIT
    p_limite
OFFSET
    p_offset;

END / / DELIMITER;

DROP PROCEDURE IF EXISTS sp_total_pesquisa_processos;

DELIMITER / / CREATE PROCEDURE sp_total_pesquisa_processos (IN p_termo VARCHAR(150)) BEGIN
SELECT
    COUNT(*) AS total
FROM
    processo_minerario
WHERE
    processo LIKE CONCAT ('%', p_termo, '%')
    OR nome LIKE CONCAT ('%', p_termo, '%')
    OR subs LIKE CONCAT ('%', p_termo, '%');

END / / DELIMITER;

DROP PROCEDURE IF EXISTS sp_buscar_detalhes_processo;

DELIMITER / / CREATE PROCEDURE sp_buscar_detalhes_processo (IN p_id_processo INT) BEGIN
SELECT
    p.id_processo,
    p.id_anm,
    p.processo,
    p.numero,
    p.ano,
    p.area_ha,
    p.fase,
    p.ult_evento,
    p.nome,
    p.subs,
    p.uso,
    p.uf,
    p.ds_processo,
    p.ultima_atualizacao,
    a.id_ativo,
    a.id_usuario,
    a.descricao,
    a.dt_cadastro,
    u.nome AS nome_usuario
FROM
    processo_minerario p
    LEFT JOIN ativo_minerario a ON a.id_processo = p.id_processo
    LEFT JOIN usuario u ON u.id_usuario = a.id_usuario
WHERE
    p.id_processo = p_id_processo;

END / / DELIMITER;

DROP PROCEDURE IF EXISTS sp_listar_ativos_usuario;

DELIMITER / / CREATE PROCEDURE sp_listar_ativos_usuario (IN p_id_usuario INT) BEGIN
SELECT
    a.id_ativo,
    a.id_usuario,
    a.id_processo,
    a.descricao,
    a.dt_cadastro,
    p.processo,
    p.nome,
    p.subs,
    p.fase,
    p.uf
FROM
    ativo_minerario a
    INNER JOIN processo_minerario p ON p.id_processo = a.id_processo
WHERE
    a.id_usuario = p_id_usuario
ORDER BY
    a.dt_cadastro DESC;

END / / DELIMITER;