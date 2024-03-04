SELECT * FROM coemu.comunidade;

ALTER TABLE comunidade
ADD COLUMN id_usuario_dono INT,
ADD CONSTRAINT fk_usuario_dono
    FOREIGN KEY (id_usuario_dono)
    REFERENCES usuario(id_usuario);
