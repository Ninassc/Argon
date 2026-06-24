CREATE TABLE
    usuario (
        id_usuario INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        email VARCHAR(150) NOT NULL UNIQUE,
        senha VARCHAR(255) NOT NULL,
        telefone VARCHAR(20) UNIQUE,
        dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    processo_minerario (
        id_processo INT AUTO_INCREMENT PRIMARY KEY,
        processo VARCHAR(20),
        numero VARCHAR(20),
        ano VARCHAR(10),
        area_ha VARCHAR(30),
        id_anm VARCHAR(50),
        fase VARCHAR(100),
        ult_evento TEXT,
        nome VARCHAR(150),
        subs VARCHAR(100),
        uso VARCHAR(100),
        uf VARCHAR(5),
        ds_processo VARCHAR(20),
        ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    ativo_minerario (
        id_ativo INT AUTO_INCREMENT PRIMARY KEY,
        id_usuario INT NOT NULL,
        id_processo INT NOT NULL,
        descricao TEXT,
        dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
        FOREIGN KEY (id_processo) REFERENCES processo_minerario (id_processo)
    );

CREATE TABLE
    documento (
        id_arquivo INT AUTO_INCREMENT PRIMARY KEY,
        id_ativo INT NOT NULL,
        nome VARCHAR(200) NOT NULL,
        tipo VARCHAR(50),
        caminho VARCHAR(500) NOT NULL,
        dt_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (id_ativo) REFERENCES ativo_minerario (id_ativo)
    );

CREATE TABLE
    acesso (
        id_acesso INT AUTO_INCREMENT PRIMARY KEY,
        id_usuario INT NOT NULL,
        id_ativo INT NOT NULL,
        status VARCHAR(50) DEFAULT 'pendente',
        dt_solicitacao DATETIME DEFAULT CURRENT_TIMESTAMP,
        dt_acesso DATETIME NULL,
        FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
        FOREIGN KEY (id_ativo) REFERENCES ativo_minerario (id_ativo)
    );

CREATE TABLE
    favoritamento (
        id_favorito INT AUTO_INCREMENT PRIMARY KEY,
        id_usuario INT NOT NULL,
        id_ativo INT NOT NULL,
        dt_favorito DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
        FOREIGN KEY (id_ativo) REFERENCES ativo_minerario (id_ativo),
        UNIQUE (id_usuario, id_ativo)
    );