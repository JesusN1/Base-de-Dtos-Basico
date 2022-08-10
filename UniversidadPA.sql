-- Procedimiento almacenados
-- Jesus Ninantay
-- 08/08/22

--PA para Escuelas
--Escuelas

use BDUniversidad
go
if OBJECT_ID('spListarEscuela') is not null
	drop proc splistarEscuela
go
create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go

if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as begin
	--Para que el codigo de la escuela no pueda ser doble
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
	--Escuela no puede ser duplicado
		if not exists (select Escuela from TEscuela where Escuela=@Escuela)
		begin
			insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
			select CodError = 0, Mensaje = 'Se inserto la escuela'
		end
		else select CodError = 1, Mensaje = 'Error: Ya se encontro una Escuela'
	else select CodError = 1, Mensaje = 'Error: Ya se encontro un Codigo de Escuela'
end
go

-- Actividad Implementar Eliminar, Actualizar y Buscar
-- Presentado para el dia miecoles 10 de agosto a traves de Aula Virtual

if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se elimino la Escuela'
		end
	else select CodError = 1, Mensaje = 'Error: El codigo de Escuela no existe'
end
go

exec spEliminarEscuela @CodEscuela = 'E03';
go

select * from TEscuela

-- Actualizar 
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			update TEscuela set Escuela = @Escuela, Facultad = @Facultad where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo correctamente la escuela'
		end
	else select CodError = 1, Mensaje = 'Error: El codigo de Escuela no Existe'
end
go

exec spActualizarEscuela @CodEscuela = 'E06', @Escuela = 'Derecho', @Facultad = 'CEAC';
go

select * from TEscuela

-- Buscar
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodEscuela from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se la escuela'
		end
	else select CodError = 1, Mensaje = 'Error: El codigo de Escuela no Existe'
end
go

exec spBuscarEscuela @CodEscuela = 'E04';
go

--Alumnos

if OBJECT_ID('spListarAlumnos') is not null
	drop proc spListarAlumnos
go
create proc spListarAlumnos
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno
end
go

exec spListarAlumnos
go

if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go
create proc spAgregarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)
as begin
	--CodAlumno  no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
	--Escuela debe existir
		if exists (select Escuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
			select CodError = 0, Mensaje = 'Se inserto correctamente nuevo alumno'
		end
		else select CodError = 1, Mensaje = 'Error: Escuela no existe'
	else select CodError = 1, Mensaje = 'Error: CodAlumno duplicado'
end
go



exec spAgregarAlumno @CodAlumno = 'A0001', @Apellidos = 'Huaman Villena', @Nombres = 'Oscar Juan', @LugarNac = 'Cusco', @FechaNac = '2001-07-12 10:22:14', @CodEscuela = 'E01';
go

select * from TAlumno

if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go
create proc spEliminarAlumno
@CodAlumno char(5)
as begin
	--CodAlumno debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			delete from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se elimino alumno'
		end
	else select CodError = 1, Mensaje = 'Error: El Codigo de alumno no existe'
end
go

exec spEliminarAlumno @CodAlumno = 'A0001';
go

select * from TAlumno

if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go
create proc spActualizarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)
as begin
	--CodAlumno debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			update TAlumno set Apellidos = @Apellidos, Nombres = @Nombres, LugarNac = @LugarNac, FechaNac = @FechaNac, CodEscuela = @CodEscuela where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Se actualizo  alumno'
		end
	else select CodError = 1, Mensaje = 'Error: El Codigo de alumno no existe'
end
go

exec spActualizarAlumno @CodAlumno = 'A0001', @Apellidos = 'Villena Rojas', @Nombres = 'Juan Phool', @LugarNac = 'Cusco', @FechaNac = '2003-01-01 12:23:21', @CodEscuela = 'E01';
go

select * from TAlumno

if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
@CodAlumno char(5)
as begin
	--CodEscuela debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select * from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se encontro correctamente alumno'
		end
	else select CodError = 1, Mensaje = 'Error: El Codigo del Alumno no existe'
end
go

exec spBuscarAlumno @CodAlumno = 'A0001';
go

