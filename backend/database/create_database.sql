CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),

    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE processo_minerario (
    id_processo INT AUTO_INCREMENT PRIMARY KEY,

    numero VARCHAR(30) NOT NULL UNIQUE,
    municipio VARCHAR(100),
    uso VARCHAR(100),

    substancia VARCHAR(100),
    fase VARCHAR(100),

    area DECIMAL(12,2),

    status VARCHAR(100),

    processo VARCHAR(100),

    ds_processo TEXT,

    nome VARCHAR(150),

    ultima_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ativo_minerario (
    id_ativo INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,
    id_processo INT NOT NULL,

    descricao TEXT,

    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_processo)
        REFERENCES processo_minerario(id_processo)
);

CREATE TABLE documento (
    id_arquivo INT AUTO_INCREMENT PRIMARY KEY,

    id_ativo INT NOT NULL,

    nome VARCHAR(200) NOT NULL,

    tipo VARCHAR(50),

    caminho VARCHAR(500) NOT NULL,

    dt_upload DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_ativo)
        REFERENCES ativo_minerario(id_ativo)
);

CREATE TABLE acesso (
    id_acesso INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,

    status VARCHAR(50) DEFAULT 'pendente',

    dt_solicitacao DATETIME DEFAULT CURRENT_TIMESTAMP,

    dt_acesso DATETIME NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_ativo)
        REFERENCES ativo_minerario(id_ativo)
);

CREATE TABLE favoritamento (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,

    dt_favorito DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_ativo)
        REFERENCES ativo_minerario(id_ativo),

    UNIQUE(id_usuario, id_ativo)
);