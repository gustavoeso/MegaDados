DROP DATABASE IF EXISTS coemu;
CREATE SCHEMA coemu;
USE coemu;

DROP TABLE IF EXISTS usuario;
CREATE TABLE IF NOT EXISTS usuario(
	id_usuario int  NOT NULL,
    nome VARCHAR(100) NOT NULL,
    nickname VARCHAR(30) NOT NULL,
    data_cadastro DATETIME NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_usuario)
);

DROP TABLE IF EXISTS comunidade;
CREATE TABLE IF NOT EXISTS comunidade(
	id_comunidade int NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    descricao LONGTEXT,
    data_criacao DATETIME NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_comunidade)
);

CREATE TABLE usuario_has_comunidade (
    id_usuario INT,
    id_comunidade INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_comunidade) REFERENCES comunidade(id_comunidade),
    PRIMARY KEY (id_usuario, id_comunidade)
);


DROP TABLE IF EXISTS discussao;
CREATE TABLE IF NOT EXISTS discussao(
	id_discussao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(90) NOT NULL,
    data_criacao DATETIME NOT NULL,
    ativa TINYINT NOT NULL,
    id_comunidade INT NOT NULL,
    FOREIGN KEY(id_comunidade) REFERENCES comunidade(id_comunidade),
    id_usuario_criador INT NOT NULL,
    FOREIGN KEY(id_usuario_criador) REFERENCES usuario(id_usuario)
);

DROP TABLE IF EXISTS mensagem;
CREATE TABLE mensagem (
    id_mensagem INT NOT NULL AUTO_INCREMENT,
    texto MEDIUMTEXT NOT NULL,
    oculta TINYINT NOT NULL,
    id_usuario_envio INT NOT NULL,
    id_discussao INT NOT NULL,
    data_envio DATETIME NOT NULL,
    PRIMARY KEY (id_mensagem),
    FOREIGN KEY (id_usuario_envio) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_discussao) REFERENCES discussao(id_discussao)
);