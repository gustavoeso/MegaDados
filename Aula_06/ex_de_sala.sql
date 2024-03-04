USE coemu;

SELECT * FROM usuario;
SHOW TABLES;
DESCRIBE usuario;

INSERT INTO usuario
VALUES (50, 'Diogo Lobo', 'Lobinho', '2018-01-01', 1);

INSERT INTO usuario
(nome, nickname, data_cadastro, ativo)
VALUES 
('Pedro Gomes', 'Pedrogames', '2018-02-01', 0),
('Gustavo Mendes', 'gugufofão', '2019-04-25', 0);

SELECT * FROM comunidade;
DESCRIBE comunidade;

INSERT INTO comunidade
(titulo, descricao, DATA_CRIACAO, ativo, id_usuario_dono)
VALUES
('Amo acordar cedo', 'É mentira, mas vamos fingir!', '2024-02-26', 1, 59);

SELECT * FROM usuario_has_comunidade;
DESCRIBE usuario_has_comunidade;

SELECT * FROM usuario;

UPDATE usuario
SET nome = 'Diogo Lobo',
nickname = 'Lobinho'
WHERE id_usuario = 50;
