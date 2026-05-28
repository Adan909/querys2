insert into Academico.Carrera (Nombre, Precio) values ('Ingeniería en Sistemas', 15000.00);

update Academico.Carrera set Precio = 16000.00, updated_at = GETDATE() where Nombre = 'Ingeniería en Sistemas';

insert into Seguridad.Usuario (cif, nombre, apellido, pw) values ('12345678A', 'Juan', 'Pérez', HASHBYTES('SHA2_256', 'password123'));
