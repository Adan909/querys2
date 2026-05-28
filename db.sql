--base de datos llamada UniversidadDB la cual maneja dos modulos: Academico y seguridad 

--Modulo Academico: Carrera y Estudiante

--Modulo Seguridad: Cargo y Usuario

Use master
go
if exists (select * from sys.databases where name = 'UniversidadDB')
begin
	drop database UniversidadDB
end
go

CREATE DATABASE UniversidadDB
go
USE UniversidadDB
go

--Schema: Contenedor Logico que sirve para organizar los objetos de la base de datos
create schema Academico
go
create schema Seguridad
go


create table Academico.Carrera
(
	IdCarrera int primary key identity(1,1),
	Nombre nvarchar(50) not null,
	Precio decimal(10,2) not null,
	created_at datetime not null default sysdatetime(),
	updated_at datetime null,
	deleted_at datetime,

)
go

create table Academico.Estudiante
(
	id int primary key identity(1,1),
	Nombre nvarchar(50) not null,
	Apellido nvarchar(50) not null,
	fechaNac datetime null, 
	cif varchar(20) not null,
	IdCarrera int foreign key references Academico.Carrera(IdCarrera),
	mail varchar(100) null

)
go


create table Seguridad.Cargo
(
	id int primary key identity(1,1),
	Nombre nvarchar(50) not null,
	created_at datetime not null default sysdatetime(),
	updated_at datetime null,
	deleted_at datetime null
)
go

create table Seguridad.Usuario
(
	idUsuario int primary key identity(1,1),
	cif varchar(20) unique not null,
	Nombre nvarchar(50) not null,
	Apellido nvarchar(50) not null,
	email varchar(100) null,
	fechaNac datetime null,
	pw varbinary(60) not null,
	mail nvarchar(100) null,
	created_at datetime not null default sysdatetime(),
	updated_at datetime null,
	deleted_at datetime null
)

ALTER TABLE Academico.Estudiante
	add created_at datetime not null default sysdatetime(),
	updated_at datetime null,
	deleted_at datetime null,
	constraint UQ_Estudiante_cif unique (cif),
	constraint UQ_Estudiante_mail unique (mail),
	constraint FK_Estudiante_Carrera foreign key (IdCarrera) references Academico.Carrera(IdCarrera)

	go

ALTER TABLE Academico.Carrera
	add constraint CK_Carrera_Precio CHECK (Precio > 0),
	
	constraint CK_Carrera_UpdatedAt CHECK (updated_at > created_at),
	constraint CK_Carrera_DeletedAt CHECK (deleted_at > created_at)


	go

ALTER TABLE Seguridad.Usuario
	add constraint CK_Usuario_pw CHECK (LEN(pw) >= 8)
go










