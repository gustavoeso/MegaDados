SELECT * FROM coemu.usuario;

ALTER TABLE usuario
ADD CONSTRAINT nickname_unico UNIQUE (nickname);

ALTER TABLE usuario
MODIFY COLUMN id_usuario INT AUTO_INCREMENT;
