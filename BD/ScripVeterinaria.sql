create database BDVeterinaria;
go

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
 
use BDVeterinaria
go

drop database BDVeterinaria
------------------------------------------------------------------------------------
---------------------------------Creacion de tablas---------------------------------
------------------------------------------------------------------------------------
 
create table tblTIpoTEl
(
intCod_TITE int identity primary key not null,
strDescripcion_TITE varchar(25) not null
)
go

create table tblCIUdad
(
intCod_CIU int identity primary key not null,
strNombre_CIU varchar(25) not null
)
go

create table tblCARgo
(
intCod_CAR int identity primary key not null,
strDescripcion_CAR varchar(25) not null
)
go

create table tblRAZa
(
intCod_RAZ int identity primary key not null,
strNombre_RAZ varchar(25) not null,
idEMP_RAZ int not null,
idTIMA_RAZ int not null
)
go

create table tblTIpoMAscota
(
intCod_TIMA int identity primary key not null,
strTipo_TIMA varchar(25) not null,
idEMP_TIMA int not null
)
go

create table tblMAScota
(
intID_MAS int identity primary key not null,
strNombre_MAS varchar(25) not null,
idCLI_MAS varchar(20) not null,
idEMP_MAS int not null,
idTIMA_MAS int not null,
idRAZ_MAS int not null,
dtmFechaNacimiento_MAS datetime not null,
bitEstado_MAS bit default 1 not null
)
go

create table tblEMPleado
(
intCodigo_EMP int identity primary key not null,
strCedula_EMP varchar(20) not null,
strNombre_EMP varchar(60) not null,
idCAR_EMP int not null,
strUsuario_EMP varchar(20) not null,
strContra_EMP varchar(20) not null,
bitEstado_EMP bit default 1 not null
)
go

create table tblCLIente
(
strDocumento_CLI varchar(20) primary key not null,
strNombre_CLI varchar(60) not null,
idEMP_CLI int not null,
strEmail_CLI varchar(20) not null,
dtmFechaNacimiento datetime not null
)
go

create table tblTELefono
(
intCodigo_TEL int identity primary key not null,
strNumero_TEL varchar(10) not null,
idTITE_TEL int not null,
idCLI_TEL varchar(20) not null,
idEMP_TEL int not null
)
go

create table tblDIReccion
(
intCodigo_DIR int identity primary key not null,
strDescripcion_DIR varchar(60) not null,
idCLI_DIR varchar(20) not null,
idEMP_DIR int not null,
idCIU_DIR int not null
)
go

create table tblCONtrol
(
intNroControl_CON INT IDENTITY primary key not null,
dtmFecha_CON datetime not null,
idCLI_CON varchar(20) not null,
idMAS_CON int not null,
idEMP_CON int not null,
realPesoMascota_CON real not null,
intEdadMascota_CON int not null,
dtmProximaCita_CON datetime null,
intValor_CON int not null,
)
go

create table tblSERvicio
(
intCodigo_SER int identity primary key not null,
strDescripcion_SER varchar(200) not null,
intCosto_SER int not null,
IdEMP_SER int not null,
idCargo_SER int not null
)
go

create table tblCOntrol_SErvicio
(
intCodigo_COSE int identity primary key not null,
idCON_COSE int not null,
idSER_COSE int not null,
idEMP_COSE int not null,
bitReceta_COSE bit default 1 not null,
intValor_COSE int not null
)
go

create table tblRECeta
(
intCodigo_REC int identity primary key not null,
strRecomendaciones_COSE varchar(4000) null,
idCOSE_REC int not null
)
go

create table tblMEDicamento
(
intCodigo_MED int identity primary key not null,
strNombre_MED varchar(100) null,
idEMP_MED int not null
)
go

create table tblREceta_MEdicamento
(
intCodigo_REME  int identity primary key not null,
idREC_REME int not null,
idMED_REME int not null,
intCantidad_REME int not null,
strDosis_REME varchar(50),
)
go

------------------------------------------------------------------------------------
-------------------------------Creacion de relaciones-------------------------------
------------------------------------------------------------------------------------


--Tabla Telefono--
alter table tblTELefono add FOREIGN key (idTITE_TEL) references tblTIpoTEl (intCod_TITE);
alter table tblTELefono add FOREIGN key (idCLI_TEL) references tblCLIente (strDocumento_CLI);
alter table tblTELefono add FOREIGN key (idEMP_TEL) references tblEMPleado (intCodigo_EMP);

--Tabla Direccion--
alter table tblDIReccion add FOREIGN key (idCLI_DIR) references tblCLIente (strDocumento_CLI);
alter table tblDIReccion add FOREIGN key (idEMP_DIR) references tblEMPleado (intCodigo_EMP);
alter table tblDIReccion add FOREIGN key (idCIU_DIR) references tblCIUdad (intCod_CIU);

--Tabla Cliente--
alter table tblCLIente add FOREIGN key (idEMP_CLI) references tblEMPleado (intCodigo_EMP);

--Tabla Servicio--
alter table tblSERvicio add FOREIGN key (idEMP_SER) references tblEMPleado (intCodigo_EMP);
alter table tblSERvicio add FOREIGN key (idCargo) references tblCARgo (intCod_CAR);

--Tabla Empleado--
alter table tblEMPleado add FOREIGN key (idCAR_EMP) references tblCARgo (intCod_CAR);

--Tabla Mascota--
alter table tblMAScota add FOREIGN key (idRAZ_MAS) references tblRAZa (intCod_RAZ);
alter table tblMAScota add FOREIGN key (idTIMA_MAS) references tblTIpoMAscota (intCod_TIMA);
alter table tblMAScota add FOREIGN key (idCLI_MAS) references tblCLIente (strDocumento_CLI);
alter table tblMAScota add FOREIGN key (idEMP_MAS) references tblEMPleado (intCodigo_EMP);

--Tabla Raza--
alter table tblRAZa add FOREIGN key (idTIMA_RAZ) references tblTIpoMAscota (intCod_TIMA);
alter table tblRAZa add FOREIGN key (idEMP_RAZ) references tblEMPleado (intCodigo_EMP);

--Tabla Tipo Mascota--
alter table tblTIpoMAScota add FOREIGN key (idEMP_TIMA) references tblEMPleado (intCodigo_EMP);

--Tabla Control--
alter table tblCONtrol add FOREIGN key (idCLI_CON) references tblCLIente (strDocumento_CLI);
alter table tblCONtrol add FOREIGN key (idEMP_CON) references tblEMPleado (intCodigo_EMP);
alter table tblCONtrol add FOREIGN key (idMAS_CON) references tblMAScota (intID_MAS);

--Tabla Control_Servicio--
alter table tblCOntrol_SErvicio add FOREIGN key (idCON_COSE) references tblCONtrol (intNroControl_CON);
alter table tblCOntrol_SErvicio add FOREIGN key (idSER_COSE) references tblSERvicio (intCodigo_SER);
alter table tblCOntrol_SErvicio add FOREIGN key (idEMP_COSE) references tblEMPleado (intCodigo_EMP);

--Tabla Receta
alter table tblRECeta add FOREIGN key (idCOSE_REC) references tblCOntrol_SErvicio (intCodigo_COSE);

--Tabla Receta_Medicamento--
alter table tblREceta_MEdicamento add FOREIGN key (idMED_REME) references tblMEDicamento (intCodigo_MED);
alter table tblREceta_MEdicamento add FOREIGN key (idREC_REME) references tblRECeta (intCodigo_REC);


------------------------------------------------------------------------------------
------------------------------------------Insert------------------------------------
------------------------------------------------------------------------------------
insert into tblTIpoTEl values ('CELULAR'),('FIJO'),('FAX');
insert into tblCIUdad values ('MEDELLIN'),('BUCARAMANGA'),('BOGOTA');
insert into tblCARgo values ('Secretaria'),('Veterinario'),('Peluquero');
insert into tblEMPleado values ('702040','Beatriz Zuluaga Ramirez',1,'beatrizzuluaga7020','beatrizzuluaga7020',1);
insert into tblEMPleado values ('909090','Robert Higgin Towers',2,'roberthiggin9090','roberthiggin9090',1);
insert into tblEMPleado values ('702020','Juan P. Cardona A.',3,'juancardona7020','juancardona7020',1);
insert into tblCLIente values ('70500600','Maria José Tobón López',1,'algo@algo.algo','19750812');
insert into tblCLIente values ('800100100','Almacenes Don Juaco Ltda.',1,'algo@algo.algo','19950517');
insert into tblSERvicio values ('Peluqueria',20000,1,3);
insert into tblSERvicio values ('Consulta',25000,1,2);
insert into tblSERvicio values ('Parto',100000,1,2);
insert into tblSERvicio values ('Castramineto',80000,2);
insert into tblSERvicio values ('Purgar',10000,1,3);
insert into tblMEDicamento values ('Kutamicon',1),('Paracetamol',1),('Vacol',1),('Meloxicam',1);
insert into tblTIpoMAscota values ('Perro',1),('Gato',1),('Hamster',1),('Loro',1),('Caballo',1);
insert into tblRAZa values ('Pastor Aleman',1,1),('Weymaraner',1,1),('Pastor Coli',1,1);
insert into tblRAZa values ('Ragdol',1,2),('Persa',1,2),('Bengala',1,2);
insert into tblRAZa values ('Sirio',1,3),('Chino',1,3),('Ruso',1,3);
insert into tblRAZa values ('Cariamarillo',1,4),('Gris',1,4),('Guacamayo aliverde',1,4);
insert into tblRAZa values ('Arabe',1,5),('Percehron',1,5),('Clydesdale',1,5);
insert into tblMAScota values ('Firulais','70500600',1,1,2,'20160614',1);
insert into tblMAScota values ('Mancho','800100100',1,2,3,'20160614',1);
insert into tblMAScota values ('Fraon','800100100',1,2,1,'20160614',1);
insert into tblMAScota values ('Emperador','70500600',1,2,2,'20160614',1);
insert into tblMAScota values ('Chimue','800100100',1,2,2,'20160614',1);
insert into tblTELefono values ('3120450718',1,'800100100',1);
insert into tblTELefono values ('4512517',2,'800100100',1);
insert into tblTELefono values ('3001457812',1,'70500600',1);
insert into tblTELefono values ('4715215487',3,'70500600',1);
insert into tblDIReccion values ('Calle 30 #23-75','70500600',1,3);
insert into tblDIReccion values ('Circular 1 #63-22','70500600',1,1);
insert into tblDIReccion values ('Carrera 78 #57-12','800100100',1,2);
insert into tblCONtrol values (GETDATE(),'70500600',1,1,25,1,null,20000);
insert into tblCONtrol values (GETDATE(),'800100100',2,1,10,1,null,80000); 
insert into tblCOntrol_SErvicio values (1,1,3,0,20000);
insert into tblCOntrol_SErvicio values (2,4,2,1,80000);
insert into tblRECeta values ('Reposo y liempieza de puntos',2);
insert into tblREceta_MEdicamento values (1,2,15,'1 cada 8 horas por 5 dias');
go



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-----------------------------------Stores Control----------------------------------
-------------------------------------------------------------------------------------
CREATE PROCEDURE USP_CONtrol_BuscarGeneral
	AS
		BEGIN
			SELECT intNroControl_CON as Clave,
						CONVERT (varchar(10), dtmFecha_CON, 103) as Fecha,
						strNombre_CLI as Cliente,
						strNombre_MAS as Mascota,
						strNombre_EMP as Empleado,
						realPesoMascota_CON as Peso_Mascota,
						intEdadMascota_CON as Edad_Mascota,
						CONVERT (varchar(10), dtmProximaCita_CON, 103) as Proxima_Cita,
						intValor_CON as Valor
			FROM tblCONtrol inner join tblCLIente on strDocumento_CLI = idCLI_CON
			inner join tblMAScota on intID_MAS = idMAS_CON
			inner join tblEMPleado on intCodigo_EMP = idEMP_CON
			ORDER BY intNroControl_CON
	  END
GO

--exec USP_CONtrol_BuscarGeneral

CREATE PROCEDURE USP_CONtrol_BuscarGrid
@intCodigo int
AS
BEGIN
		
		SELECT intCodigo_SER as Clave,
						strDescripcion_SER as Servicio,
						intValor_COSE as Valor,
						intCodigo_EMP as CodigoEmpleado,
						strNombre_EMP as NombreEmpleado						
			FROM tblCOntrol_SErvicio inner join tblSERvicio on idSER_COSE = intCodigo_SER
			inner join tblEMPleado on idEMP_COSE = intCodigo_EMP
			WHERE idCON_COSE = @intCodigo
		
END
GO

alter PROCEDURE USP_CONtrol_BuscarXCodigo
@intCodigo int

AS
	BEGIN
		SELECT intNroControl_CON as Clave,
						CONVERT (varchar(10), dtmFecha_CON, 103) as Fecha,
						strDocumento_CLI as DocCliente,
						strNombre_CLI as Cliente,
						idMAS_CON as Mascota,
						idEMP_CON as Empleado,
						realPesoMascota_CON as Peso_Mascota,
						intEdadMascota_CON as Edad_Mascota,
						CONVERT (varchar(10), dtmProximaCita_CON, 103) as Proxima_Cita,
						intValor_CON as Valor
			FROM tblCONtrol inner join tblCLIente on strDocumento_CLI = idCLI_CON
			WHERE intNroControl_CON	= @intCodigo
			EXEC USP_CONtrol_BuscarGrid @intCodigo
  END
GO

--exec USP_CONtrol_BuscarXCodigo 1

CREATE PROCEDURE USP_CONtrol_Grabar
	@Fecha datetime,
	@Cliente varchar(20),
	@Mascota int,
	@Empleado int,
	@Peso_Mascota real,
	@Edad_Mascota int,
	@ProximaCita datetime
AS
	BEGIN
	begin transaction tx
	insert into tblCONtrol values (@Fecha,@Cliente,@Mascota,@Empleado,@Peso_Mascota,@Edad_Mascota,@ProximaCita,null);
	if (@@ERROR > 0 )
		begin 
			rollback transaction tx
			select 0 as Rpta
			return 
			end
		commit transaction tx
	SELECT @@IDENTITY as Rpta
	return
	
	
	END
GO
--exec USP_CONtrol_Grabar '2016-06-04','70500600',1,1,25,1,null;

CREATE PROCEDURE USP_CONtrol_Modificar
	@Codigo int,
	@Cliente varchar(20),
	@Mascota int,
	@Empleado int,
	@Peso_Mascota real,
	@Edad_Mascota int,
	@ProximaCita datetime,
	@Valor int
AS
BEGIN
	begin transaction tx
	update tblCONtrol
		set idCLI_CON=@Cliente,
			idMAS_CON=@Mascota,
			idEMP_CON=@Empleado,
			realPesoMascota_CON =@Peso_Mascota,
			intEdadMascota_CON = @Edad_Mascota,
			dtmProximaCita_CON = @ProximaCita,
			intValor_CON=@Valor
		where intNroControl_CON = @Codigo
		if (@@ERROR>0)
			begin 
			rollback transaction tx
			select 0 as Rpta
			return
			end
		commit transaction tx
		select @Codigo as  Rpta
		return

		-- exec USP_Caso_Modificar 1,'702020','PE';
	
	
END
GO
--exec USP_CONtrol_Modificar 4,'70500600',1,1,25,1,null,20000;

alter PROCEDURE USP_CONtrol_AgregarServicio
	@idControl int,
	@idServicio int,
	@idEmpleado int,
	@bitReceta bit
AS
	BEGIN
		if exists (select * from tblCOntrol_SErvicio where idCON_COSE=@idControl and idSER_COSE = @idServicio)
			begin 
				select -1 as Rpta
				return 
			end
		else

			begin
				begin transaction tx
					insert into tblCOntrol_SErvicio values (@idControl, @idServicio, @idEmpleado, @bitReceta,(select intCosto_SER from tblSERvicio where intCodigo_SER = @idServicio))
					
					if (@@ERROR>0)
						begin 
							rollback transaction tx
							select 0 as Rpta
							return
						end
					commit transaction tx
					select @idControl as Rpta
					return
				end
			
	END
GO
--exec USP_CONtrol_AgregarServicio 1,3,2,1;

CREATE PROCEDURE USP_CONtrol_QuitarServicio
	@idControl int,
	@idServicio int
AS
	BEGIN
		if not exists (select * from tblCOntrol_SErvicio where idCON_COSE=@idControl and idSER_COSE = @idServicio)
			begin 
				select -1 as Rpta
				return 
			end
		else

			begin
				begin transaction tx
					delete from tblCOntrol_SErvicio
					where (idCON_COSE=@idControl) and (idSER_COSE = @idServicio)
					if (@@ERROR>0)
						begin 
							rollback transaction tx
							select 0 as Rpta
							return
						end
					commit transaction tx
					select @idControl as Rpta
					return
				end
			
	END
GO

--exec USP_CONtrol_QuitarServicio 4,2;

alter PROCEDURE USP_CONtrol_AgregarValor
	@idControl int,
	@idServicio int
AS
	BEGIN
		if not exists (select intNroControl_CON from tblCONtrol where intNroControl_CON=@idControl)
			begin 
				select -1 as Rpta
				return 
			end
		else

			begin
				begin transaction tx
					update tblCONtrol		
						set intValor_CON=(select intValor_CON from tblCONtrol where intNroControl_CON = @idControl) + (select intValor_COSE from tblCOntrol_SErvicio where idCON_COSE = @idControl and idSER_COSE = @idServicio)
						where intNroControl_CON = @idControl
					if (@@ERROR>0)
						begin 
							rollback transaction tx
							select 0 as Rpta
							return
						end
					commit transaction tx
					select @idControl as Rpta
					return
				end
			
	END
GO
--exec USP_CONtrol_AgregarValor 1,2;




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-----------------------------------Stores Empleado----------------------------------
-------------------------------------------------------------------------------------

CREATE PROCEDURE USP_EMPleado_BuscarGeneral
	AS
		BEGIN
			SELECT intCodigo_EMP as Clave,
						strCedula_EMP as Cedula,
						strNombre_EMP as Nombre,
						strDescripcion_CAR as Cargo,
						bitEstado_EMP as Estado
			FROM tblEMPleado inner join tblCARgo on idCAR_EMP = intCod_CAR
			ORDER BY intCodigo_EMP
	  END
GO

--exec USP_EMPleado_BuscarGeneral;

CREATE PROCEDURE USP_EMPleado_BuscarGrid
@intCodigo int
AS
BEGIN
	
	if((select idCAR_EMP from tblEMPleado where intCodigo_EMP = @intCodigo) = 1)
		begin
			SELECT intNroControl_CON as Clave,
						CONVERT (varchar(10), dtmFecha_CON, 103) as Fecha,
						strNombre_CLI as Cliente,
						strNombre_MAS as Mascota,
						realPesoMascota_CON as Peso_Mascota,
						intEdadMascota_CON as Edad_Mascota,
						CONVERT (varchar(10), dtmProximaCita_CON, 103) as Proxima_Cita,
						intValor_CON as Valor
			FROM tblCONtrol inner join tblCLIente on strDocumento_CLI = idCLI_CON
			inner join tblMAScota on intID_MAS = idMAS_CON
			inner join tblEMPleado on intCodigo_EMP = idEMP_CON
			WHERE idEMP_CON	= @intCodigo
		end
	else
		begin
			SELECT intNroControl_CON as NroControl,
						CONVERT (varchar(10), dtmFecha_CON, 103) as Fecha,
						strNombre_CLI as Cliente,
						strNombre_MAS as Mascota,
						strDescripcion_SER as Servicio
			FROM tblCOntrol_SErvicio inner join tblCONtrol on intNroControl_CON = idCON_COSE
			inner join tblSERvicio on intCodigo_SER = idSER_COSE
			inner join tblEMPleado on intCodigo_EMP = idEMP_COSE
			inner join tblMAScota on idMAS_CON = intID_MAS
			inner join tblCLIente on idCLI_CON = strDocumento_CLI
			WHERE idEMP_COSE = @intCodigo
		end

END
GO

alter PROCEDURE USP_EMPleado_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCodigo_EMP as Clave,
						strCedula_EMP as Cedula,
						strNombre_EMP as Nombre,
						idCAR_EMP as Cargo,
						strUsuario_EMP as Usuario,
						bitEstado_EMP as Estado
			FROM tblEMPleado
			WHERE intCodigo_EMP = @intCodigo
			EXEC USP_EMPleado_BuscarGrid @intCodigo
  END
GO
--exec USP_EMPleado_BuscarXCodigo 4;

CREATE PROCEDURE USP_EMPleado_Grabar
	@Cedula varchar(20),
	@Nombre Varchar(60),
	@idCargo int,
	@Usuario varchar(20),
	@Contrasena varchar(20),
	@bitEstado bit	
AS
	BEGIN
	if exists (select strCedula_EMP from tblEMPleado where strCedula_EMP = @Cedula) 
		begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		insert into tblEMPleado values (@Cedula,@Nombre,@idCargo,@Usuario,@Contrasena,@bitEstado);
		if (@@ERROR > 0 )
			begin 
				rollback transaction tx
				select 0 as Rpta
				return 
				end
			commit transaction tx
		SELECT @@IDENTITY as Rpta
		return
	
	
	END
GO
--exec USP_EMPleado_Grabar '700800900','Hernan Cordoba',2,'hernancordoba','hernancordoba',1;

CREATE PROCEDURE USP_EMPleado_Modificar
	@Codigo int,
	@Cedula varchar(20),
	@Nombre Varchar(60),
	@idCargo int,
	@Usuario varchar(20),
	@Contrasena varchar(20),
	@bitEstado bit	
AS
BEGIN
	if not exists (select strCedula_EMP from tblEMPleado where strCedula_EMP = @Cedula)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblEMPleado
			set strCedula_EMP=@Cedula,
				strNombre_EMP=@Nombre,
				idCAR_EMP=@idCargo,
				strUsuario_EMP =@Usuario,
				strContra_EMP = @Contrasena,
				bitEstado_EMP = @bitEstado
			where intCodigo_EMP = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO
--exec USP_EMPleado_Modificar 4,'700800900','Hernan Cordoba',2,'hernancordoba','hernancordoba',0;

CREATE PROCEDURE USP_CLIente_LlenarComboCargo

AS
BEGIN
	
	SELECT intCod_CAR as Clave, strDescripcion_CAR as Dato

	from tblCARgo
	order by strDescripcion_CAR
	
END
GO

CREATE PROCEDURE USP_EMPleado_LlenarComboPorCargo
@Servicio int

AS
BEGIN
	
	SELECT intCodigo_EMP as Clave, strNombre_EMP as Dato
	from tblSERvicio inner join tblEMPleado on idCAR_EMP=idCargo_SER
	WHERE intCodigo_SER = 1
	order by strDescripcion_SER
	
END
GO
--------------------------------------------------------------------------------------
----------------------------------------stroes cliente--------------------------------
-------------------------------------------------------------------------------------
CREATE PROCEDURE USP_CLIente_BuscarGeneral
	AS
		BEGIN
			SELECT strDocumento_CLI as Clave,
						strNombre_CLI as Nombre,
						strNombre_EMP as Empleado,
						strEmail_CLI as Email,
						CONVERT (varchar(10), dtmFechaNacimiento, 103) as Fecha_de_Nacimiento
			FROM tblCLIente inner join tblEMPleado on idEMP_CLI = intCodigo_EMP
			ORDER BY strDocumento_CLI
		END
GO
--exec USP_CLIente_BuscarGeneral;

CREATE PROCEDURE USP_CLIente_BuscarGrid
@strCodigo varchar(20)
AS
BEGIN
	begin
		SELECT intID_MAS as Clave,
				strNombre_MAS as Mascota,
				strNombre_EMP as Empleado,
				strTipo_TIMA as Tipo,
				strNombre_RAZ as Raza
		FROM tblMAScota inner join tblEMPleado on idEMP_MAS = intCodigo_EMP
		inner join tblTIpoMAscota on idTIMA_MAS = intCod_TIMA
		inner join tblRAZa on idRAZ_MAS = intCod_RAZ
		WHERE idCLI_MAS = @strCodigo
	end

END
GO

CREATE PROCEDURE USP_CLIente_BuscarGridDireccion
@strCodigo varchar(20)
AS
BEGIN
	begin
		SELECT intCodigo_DIR as Clave,
				strDescripcion_DIR as Descripcion,
				strNombre_CIU as Ciudad,
				strNombre_EMP as Empleado
		FROM tblDIReccion inner join tblEMPleado on idEMP_DIR = intCodigo_EMP
		inner join tblCIUdad on idCIU_DIR = intCod_CIU
		WHERE idCLI_DIR = @strCodigo
	end

END
GO

CREATE PROCEDURE USP_CLIente_BuscarGridTelefono
@strCodigo varchar(20)
AS
BEGIN
	begin
		SELECT intCodigo_TEL as Clave,
				strNumero_TEL as Descripcion,
				strDescripcion_TITE as Ciudad,
				strNombre_EMP as Empleado
		FROM tblTELefono inner join tblEMPleado on idEMP_TEL = intCodigo_EMP
		inner join tblTIpoTEl on idTITE_TEL = intCod_TITE
		WHERE idCLI_TEL = @strCodigo
	end

END
GO

alter PROCEDURE USP_CLIente_BuscarXCodigo
@strCodigo varchar(20)

AS
	BEGIN
			SELECT strDocumento_CLI as Clave,
						strNombre_CLI as Nombre,
						idEMP_CLI as Empleado,
						strEmail_CLI as Email,
						CONVERT (varchar(10), dtmFechaNacimiento, 103) as Fecha_de_Nacimiento
			FROM tblCLIente WHERE strDocumento_CLI = @strCodigo
			EXEC USP_CLIente_BuscarGrid @strCodigo
			EXEC USP_CLIente_BuscarGridDireccion @strCodigo
			EXEC USP_CLIente_BuscarGridTelefono @strCodigo
  END
GO
--exec USP_CLIente_BuscarXCodigo '800400300';

CREATE PROCEDURE USP_CLIente_Grabar
	@Cedula varchar(20),
	@Nombre Varchar(60),
	@idEmpleado int,
	@Email varchar(20),
	@FechaNacimiento datetime
AS
	BEGIN
	if exists (select strDocumento_CLI from tblCLIente where strDocumento_CLI = @Cedula) 
		begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		insert into tblCLIente values (@Cedula,@Nombre,@idEmpleado,@Email,@FechaNacimiento);
		if (@@ERROR > 0 )
			begin 
				rollback transaction tx
				select 0 as Rpta
				return 
				end
			commit transaction tx
		SELECT @Cedula as Rpta
		return
	
	
	END
GO
--exec USP_CLIente_Grabar '800400300','Armando Puertas',1,'armandopue@gmail.com','19701010';

CREATE PROCEDURE USP_CLIente_Modificar
	@Cedula varchar(20),
	@Nombre Varchar(60),
	@idEmpleado int,
	@Email varchar(20),
	@FechaNacimiento datetime
AS
BEGIN
	if not exists (select strDocumento_CLI from tblCLIente where strDocumento_CLI = @Cedula)
		begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblCLIente
			set strNombre_CLI=@Nombre,
				idEMP_CLI=@idEmpleado,
				strEmail_CLI =@Email,
				dtmFechaNacimiento = @FechaNacimiento
			where strDocumento_CLI = @Cedula
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Cedula as  Rpta
			return
END
GO
--exec USP_CLIente_Modificar '800400300','Armando Puertas',1,'armandopuertas@gmail.com','19701010';

CREATE PROCEDURE USP_CLIente_AgregarDomicilio
	@idCliente varchar(20),
	@Descripcion varchar(60),
	@idEmpleado int,
	@idCiudad int
AS
	BEGIN
		if exists (select strDescripcion_DIR from tblDIReccion where strDescripcion_DIR=@Descripcion)
			begin 
				select -1 as Rpta
				return 
			end
		else

			begin
				begin transaction tx
					insert into tblDIReccion values (@Descripcion, @idCliente, @idEmpleado, @idCiudad)
					if (@@ERROR>0)
						begin 
							rollback transaction tx
							select 0 as Rpta
							return
						end
					commit transaction tx
					select @@IDENTITY as Rpta
					return
				end
			
	END
GO
--exec USP_CLIente_AgregarDomicilio '800400300','Carrera 50 #30-20',1,1;

CREATE PROCEDURE USP_CLIente_AgregarTelefono
	@idCliente varchar(20),
	@Numero varchar(60),
	@idEmpleado int,
	@idTipo int
AS
	BEGIN
		if exists (select strNumero_TEL from tblTELefono where strNumero_TEL=@Numero)
			begin 
				select -1 as Rpta
				return 
			end
		else

			begin
				begin transaction tx
					insert into tblTELefono values (@Numero, @idTipo, @idCliente, @idEmpleado)
					if (@@ERROR>0)
						begin 
							rollback transaction tx
							select 0 as Rpta
							return
						end
					commit transaction tx
					select @@IDENTITY as Rpta
					return
				end
			
	END
GO
--exec USP_CLIente_AgregarTelefono '800400300','3002014781',1,1;

CREATE PROCEDURE USP_CLIente_LlenarComboTipoTel

AS
BEGIN
	
	SELECT intCod_TITE as Clave, strDescripcion_TITE as Dato

	from tblTIpoTEl
	order by strDescripcion_TITE
	
END
GO

CREATE PROCEDURE USP_CLIente_LlenarComboCiudad

AS
BEGIN
	
	SELECT intCod_CIU as Clave, strNombre_CIU as Dato

	from tblCIUdad
	order by strNombre_CIU
	
END
GO

--------------------------------------------------------------------------------------
----------------------------------------stroes mascota--------------------------------
-------------------------------------------------------------------------------------

CREATE PROCEDURE USP_MAScota_BuscarGeneral
	AS
		BEGIN
			SELECT intID_MAS as Clave,							
						strNombre_MAS as Nombre,
						strNombre_CLI as NombreCliente,
						strNombre_EMP as Empleado,
						strTipo_TIMA as Tipo,
						strNombre_RAZ as Raza,						
						CONVERT (varchar(10), dtmFechaNacimiento_MAS, 103) as Fecha_de_Nacimiento,
						bitEstado_EMP as Estado
			FROM tblMAScota inner join tblEMPleado on idEMP_MAS = intCodigo_EMP
			inner join tblCLIente on idCLI_MAS = strDocumento_CLI
			inner join tblTIpoMAscota on idTIMA_MAS = intCod_TIMA
			inner join tblRAZa on idRAZ_MAS = intCod_RAZ
			ORDER BY strNombre_MAS
		END
GO

--exec USP_MAScota_BuscarGeneral;

CREATE PROCEDURE USP_MAScota_BuscarGrid
@intCodigo int
AS
BEGIN
	begin
		SELECT intNroControl_CON as Clave,
						CONVERT (varchar(10), dtmFecha_CON, 103) as Fecha,
						strNombre_EMP as Empleado,
						realPesoMascota_CON as Peso_Mascota,
						intEdadMascota_CON as Edad_Mascota,
						CONVERT (varchar(10), dtmProximaCita_CON, 103) as Proxima_Cita,
						intValor_CON as Valor
		FROM tblCONtrol inner join tblMAScota on idMAS_CON = intID_MAS
		inner join tblEMPleado on idEMP_CON = intCodigo_EMP
		WHERE idMAS_CON = @intCodigo
	end

END
GO

alter PROCEDURE USP_MAScota_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intID_MAS as Clave,							
						strNombre_MAS as Nombre,
						idCLI_MAS as Cliente,
						idEMP_MAS as Empleado,
						idTIMA_MAS as Tipo,
						idRAZ_MAS as Raza,						
						CONVERT (varchar(10), dtmFechaNacimiento_MAS, 103) as Fecha_de_Nacimiento,
						bitEstado_MAS as Estado
			FROM tblMAScota
			WHERE intID_MAS = @intCodigo
			EXEC USP_MAScota_BuscarGrid @intCodigo
  END
GO

--exec USP_MAScota_BuscarXCodigo 1;


CREATE PROCEDURE USP_MAScota_BuscarGridCliente
@Codigo varchar(20)
AS
BEGIN
	begin
		SELECT intID_MAS as Clave,							
						strNombre_MAS as Nombre,
						strNombre_EMP as Empleado,
						strTipo_TIMA as Tipo,
						strNombre_RAZ as Raza,						
						CONVERT (varchar(10), dtmFechaNacimiento_MAS, 103) as Fecha_de_Nacimiento,
						bitEstado_EMP as Estado
		FROM tblMAScota inner join tblCLIente on idCLI_MAS = strDocumento_CLI
		inner join tblEMPleado on idEMP_MAS = intCodigo_EMP
		inner join tblTIpoMAscota on idTIMA_MAS = intCod_TIMA
		inner join tblRAZa on idRAZ_MAS = intCod_RAZ
		WHERE idCLI_MAS = @Codigo
	end

END
GO

CREATE PROCEDURE USP_MAScota_BuscarXCliente
@Codigo varchar(20)

AS
	BEGIN
			SELECT strDocumento_CLI as Clave,							
						strNombre_CLI as Nombre
			FROM tblCLIente
			WHERE strDocumento_CLI = @Codigo
			EXEC USP_MAScota_BuscarGridCliente @Codigo
  END
GO

--exec USP_MAScota_BuscarXCliente '70500600';

CREATE PROCEDURE USP_MAScota_Grabar
	@strNombre varchar(25),
	@idCliente Varchar(20),
	@idEmpleado int,
	@idTipoMas int,
	@idRaza int,
	@FechaNacimiento datetime
	AS
	BEGIN
		begin transaction tx
		insert into tblMAScota values (@strNombre,@idCliente,@idEmpleado,@idTipoMas,@idRaza,@FechaNacimiento,1);
		if (@@ERROR > 0 )
			begin 
				rollback transaction tx
				select 0 as Rpta
				return 
				end
			commit transaction tx
		SELECT @@IDENTITY as Rpta
		return
	
	
	END
GO
--exec USP_MAScota_Grabar 'Lucas','800400300',1,1,1,'20070406';

CREATE PROCEDURE USP_MAScota_Modificar
	@Codigo int,
	@strNombre varchar(25),
	@idCliente Varchar(20),
	@idEmpleado int,
	@idTipoMas int,
	@idRaza int,
	@FechaNacimiento datetime,
	@Estado bit
AS
BEGIN
	if not exists (select intID_MAS from tblMAScota where intID_MAS = @Codigo)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblMAScota
			set strNombre_MAS=@strNombre,
				idCLI_MAS=@idCliente,
				idEMP_MAS =@idEmpleado,
				idTIMA_MAS = @idTipoMas,
				idRAZ_MAS=@idTipoMas,
				dtmFechaNacimiento_MAS=@FechaNacimiento,
				bitEstado_MAS = @Estado
			where intID_MAS = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 
--exec USP_MAScota_Modificar 6,'Lucas','800400300',1,1,1,'20071106',0;

CREATE PROCEDURE USP_MAScota_LlenarComboTipoMascota

AS
BEGIN
	
	SELECT intCod_TITE as Clave, strDescripcion_TITE as Dato

	from tblTIpoTEl
	order by strDescripcion_TITE
	
END
GO



CREATE PROCEDURE USP_Mascota_LlenarComboRaza
@Tipo int

AS
BEGIN
	
	SELECT intCod_RAZ as Clave, strNombre_RAZ as Dato

	from tblRAZa where idTIMA_RAZ = @Tipo
	order by strNombre_RAZ
	
END
GO

CREATE PROCEDURE USP_Mascota_LlenarComboPorCliente
@Cliente varchar(20)

AS
BEGIN
	
	SELECT intID_MAS as Clave, strNombre_MAS as Dato

	from tblMAScota where idCLI_MAS = @Cliente
	order by strNombre_MAS
	
END
GO

--------------------------------------------------------------------------------------
----------------------------------------stroes medicamento----------------------------
--------------------------------------------------------------------------------------

CREATE PROCEDURE USP_MEDicamento_BuscarGeneral
	AS
		BEGIN
			SELECT intCodigo_MED as Clave,							
						strNombre_MED as Nombre,
						strNombre_EMP as NombreEmpleado
			FROM tblMEDicamento inner join tblEMPleado on intCodigo_EMP = idEMP_MED
			ORDER BY strNombre_MED
		END
GO
--exec USP_MEDicamento_BuscarGeneral;

CREATE PROCEDURE USP_MEDicamento_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCodigo_MED as Clave,							
						strNombre_MED as Nombre,
						idEMP_MED as Empleado
			FROM tblMEDicamento
			WHERE intCodigo_MED = @intCodigo
  END
GO

--exec USP_MEDicamento_BuscarXCodigo 1;

CREATE PROCEDURE USP_MEDicamento_Grabar
	@strNombre varchar(100),
	@idEmpleado int
	AS
	BEGIN
		if exists (select intCodigo_MED from tblMEDicamento where strNombre_MED = @strNombre)
			begin
				select -1 as Rpta
				return
			end
		else
			begin transaction tx
			insert into tblMEDicamento values (@strNombre,@idEmpleado);
			if (@@ERROR > 0 )
				begin 
					rollback transaction tx
					select 0 as Rpta
					return 
					end
				commit transaction tx
			SELECT @@IDENTITY as Rpta
			return	
	END
GO
--exec USP_MEDicamento_Grabar 'Amoxicilina',1;

CREATE PROCEDURE USP_MEDicamento_Modificar
	@Codigo int,
	@strNombre varchar(100),
	@idEmpleado int
AS
BEGIN
	if not exists (select intCodigo_MED from tblMEDicamento where intCodigo_MED = @Codigo)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblMEDicamento
			set strNombre_MED=@strNombre,
				idEMP_MED =@idEmpleado
			where intCodigo_MED = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 
--exec USP_MEDicamento_Modificar 5,'Amoxicilina 50mg',1;

--------------------------------------------------------------------------------------
----------------------------------------stroes raza-----------------------------------
--------------------------------------------------------------------------------------

CREATE PROCEDURE USP_RAZa_BuscarGeneral
	AS
		BEGIN
			SELECT intCod_RAZ as Clave,							
						strNombre_RAZ as Nombre,
						strNombre_EMP as NombreEmpleado,
						strTipo_TIMA as TipoMascota
			FROM tblRAZa inner join tblEMPleado on intCodigo_EMP = idEMP_RAZ
			inner join tblTIpoMAscota on intCod_TIMA = idTIMA_RAZ
			ORDER BY strNombre_RAZ
		END
GO
--exec USP_RAZa_BuscarGeneral;

CREATE PROCEDURE USP_RAZa_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCod_RAZ as Clave,							
						strNombre_RAZ as Nombre,
						idEMP_RAZ as Empleado,
						idTIMA_RAZ as TipoMascota
			FROM tblRAZa 
			WHERE intCod_RAZ = @intCodigo
  END
GO
--exec USP_RAZa_BuscarXCodigo 1;

CREATE PROCEDURE USP_RAZa_Grabar
	@strNombre varchar(25),
	@idEmpleado int,
	@idTipo int
	AS
	BEGIN
		if exists (select intCod_RAZ from tblRAZa where strNombre_RAZ = @strNombre)
			begin
				select -1 as Rpta
				return
			end
		else
			begin transaction tx
			insert into tblRAZa values (@strNombre,@idEmpleado,@idTipo);
			if (@@ERROR > 0 )
				begin 
					rollback transaction tx
					select 0 as Rpta
					return 
					end
				commit transaction tx
			SELECT @@IDENTITY as Rpta
			return	
	END
GO
--exec USP_RAZa_Grabar 'pitbull',1,1;

CREATE PROCEDURE USP_RAZa_Modificar
	@Codigo	int,
	@strNombre varchar(25),
	@idEmpleado int,
	@idTipo int
AS
BEGIN
	if not exists (select intCod_RAZ from tblRAZa where intCod_RAZ = @Codigo)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblRAZa
			set strNombre_RAZ=@strNombre,
				idEMP_RAZ =@idEmpleado,
				idTIMA_RAZ = @idTipo
			where intCod_RAZ = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 
--exec USP_RAZa_Modificar 16,'Pitbull',1,1;

--------------------------------------------------------------------------------------
----------------------------------------stroes receta---------------------------------
--------------------------------------------------------------------------------------

CREATE PROCEDURE USP_RECeta_BuscarGeneral
	AS
		BEGIN
			SELECT intCodigo_REC as Clave,							
						strRecomendaciones_REC as Recomendaciones,
						strNombre_EMP as NombreEmpleado,
						strNombre_MAS as Mascota,
						strNombre_CLI as Cliente,
						intNroControl_CON as NroControl,
						strDescripcion_SER as Servicio
			FROM tblRECeta inner join tblCOntrol_SErvicio on intCodigo_COSE = idCOSE_REC
			inner join tblCONtrol on intNroControl_CON = idCON_COSE
			inner join tblSERvicio on intCodigo_SER = idSER_COSE
			inner join tblMAScota on intID_MAS = idMAS_CON
			inner join tblCLIente on strDocumento_CLI = idCLI_CON
			inner join tblEMPleado on intCodigo_EMP = idEMP_COSE
			ORDER BY intCodigo_REC
		END
GO
--exec USP_RECeta_BuscarGeneral;

CREATE PROCEDURE USP_RECeta_BuscarGrid
@intCodigo int
AS
BEGIN
	begin
		SELECT intCodigo_MED as Clave,
			strNombre_MED as Medicamento,
			intCantidad_REME as Cantidad,
			strDosis_REME as Dosis										
		FROM tblREceta_MEdicamento inner join tblRECeta on idREC_REME = intCodigo_REC
		inner join tblMEDicamento on idMED_REME = intCodigo_MED
		WHERE intCodigo_REC = @intCodigo
	end

END
GO

CREATE PROCEDURE USP_RECeta_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCodigo_REC as Clave,							
						strRecomendaciones_REC as Recomendaciones,
						strNombre_EMP as NombreEmpleado,
						strNombre_MAS as Mascota,
						strNombre_CLI as Cliente,
						intNroControl_CON as NroControl,
						strDescripcion_SER as Servicio
			FROM tblRECeta inner join tblCOntrol_SErvicio on intCodigo_COSE = idCOSE_REC
			inner join tblCONtrol on intNroControl_CON = idCON_COSE
			inner join tblSERvicio on intCodigo_SER = idSER_COSE
			inner join tblMAScota on intID_MAS = idMAS_CON
			inner join tblCLIente on strDocumento_CLI = idCLI_CON
			inner join tblEMPleado on intCodigo_EMP = idEMP_COSE
			WHERE intCodigo_REC = @intCodigo
			EXEC USP_RECeta_BuscarGrid @intCodigo; 			
  END
GO
--exec USP_RECeta_BuscarXCodigo 1;


CREATE PROCEDURE USP_RECeta_BuscarXControl
@Control int

AS
	BEGIN
			SELECT intCodigo_REC as Clave,							
						strRecomendaciones_REC as Recomendaciones
						
			FROM tblRECeta inner join tblCOntrol_SErvicio on intCodigo_COSE = idCOSE_REC
			inner join tblCONtrol on intNroControl_CON = idCON_COSE
			WHERE intNroControl_CON = @Control			
  END
GO

--exec USP_RECeta_BuscarXControl 2;

CREATE PROCEDURE USP_RECeta_Grabar
	@Recomendaciones varchar(4000),
	@idContRec int
	AS
	BEGIN
		if exists (select intCodigo_REC from tblRECeta where idCOSE_REC = @idContRec)
			begin
				select -1 as Rpta
				return
			end
		else
			begin transaction tx
			insert into tblRECeta values (@Recomendaciones,@idContRec);
			if (@@ERROR > 0 )
				begin 
					rollback transaction tx
					select 0 as Rpta
					return 
					end
				commit transaction tx
			SELECT @@IDENTITY as Rpta
			return	
	END
GO
--exec USP_RAZa_Grabar 'pitbull',1,1;

CREATE PROCEDURE USP_RECeta_Modificar
	@Codigo	int,
	@Recomendaciones varchar(4000),
	@idContRec int
AS
BEGIN
	begin transaction tx
		update tblRECeta
			set strRecomendaciones_REC=@Recomendaciones,
				idCOSE_REC =@idContRec
			where intCodigo_REC = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 

--------------------------------------------------------------------------------------
----------------------------------------stroes servicio-------------------------------
--------------------------------------------------------------------------------------

CREATE PROCEDURE USP_SERvicio_BuscarGeneral
	AS
		BEGIN
			SELECT intCodigo_SER as Clave,							
						strDescripcion_SER as Servicio,
						intCosto_SER as Costo,
						strNombre_EMP as Empleado,
						strDescripcion_CAR as Cargo
			FROM tblSERvicio inner join tblEMPleado on intCodigo_EMP = IdEMP_SER
			inner join tblCARgo on intCod_CAR = idCargo_SER
			ORDER BY strDescripcion_SER
		END
GO
--exec USP_SERvicio_BuscarGeneral;

CREATE PROCEDURE USP_SERvicio_BuscarGrid
@intCodigo int
AS
BEGIN
	begin
		SELECT intCodigo_EMP as Clave,
						strCedula_EMP as Cedula,
						strNombre_EMP as Nombre,
						strDescripcion_CAR as Cargo,
						bitEstado_EMP as Estado									
		FROM tblEMPleado inner join tblSERvicio on  idCAR_EMP = idCargo_SER
		inner join tblCARgo on intCod_CAR = idCargo_SER
		WHERE intCodigo_SER= @intCodigo
	end

END
GO

alter PROCEDURE USP_SERvicio_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCodigo_SER as Clave,							
						strDescripcion_SER as Servicio,
						intCosto_SER as Costo,
						IdEMP_SER as Empleado,
						idCargo_SER as Cargo
			FROM tblSERvicio
			WHERE intCodigo_SER = @intCodigo
			EXEC USP_SERvicio_BuscarGrid @intCodigo;
  END
GO
--exec USP_SERvicio_BuscarXCodigo 2;

CREATE PROCEDURE USP_SERvicio_Grabar
	@Descripcion varchar(200),
	@Costo int,
	@idEmpleado int,
	@idCargo int
	AS
	BEGIN
		if exists (select intCodigo_SER from tblSERvicio where strDescripcion_SER = @Descripcion)
			begin
				select -1 as Rpta
				return
			end
		else
			begin transaction tx
			insert into tblSERvicio values (@Descripcion,@Costo,@idEmpleado,@idCargo);
			if (@@ERROR > 0 )
				begin 
					rollback transaction tx
					select 0 as Rpta
					return 
					end
				commit transaction tx
			SELECT @@IDENTITY as Rpta
			return	
	END
GO
--exec USP_RAZa_Grabar 'pitbull',1,1;

CREATE PROCEDURE USP_SERvicio_Modificar
	@Codigo	int,
	@Descripcion varchar(200),
	@Costo int,
	@idEmpleado int,
	@idCargo int
AS
BEGIN
	if not exists (select intCodigo_SER from tblSERvicio where intCodigo_SER = @Codigo)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblSERvicio
			set strDescripcion_SER=@Descripcion,
				intCosto_SER =@Costo,
				IdEMP_SER=@idEmpleado,
				idCargo_SER=@idCargo
			where intCodigo_SER = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 

CREATE PROCEDURE USP_SERvicio_LlenarComboServicio

AS
BEGIN
	
	SELECT intCodigo_SER as Clave, strDescripcion_SER as Dato
	from tblSERvicio
	order by strDescripcion_SER
	
END
GO

CREATE PROCEDURE USP_SERvicio_BuscarValor
@Servicio int
AS
BEGIN
	
	SELECT intCosto_SER
	from tblSERvicio where intCodigo_SER  = @Servicio
	order by strDescripcion_SER
	
END
GO
--------------------------------------------------------------------------------------
----------------------------------------stroes TipoMascota-------------------------------
--------------------------------------------------------------------------------------

CREATE PROCEDURE USP_TIpoMAscota_BuscarGeneral
	AS
		BEGIN
			SELECT intCod_TIMA as Clave,							
						strTipo_TIMA as Tipo,
						strNombre_EMP as NombreEmpleado
			FROM tblTIpoMAscota inner join tblEMPleado on intCodigo_EMP = idEMP_TIMA
			ORDER BY strTipo_TIMA
		END
GO
--exec USP_RAZa_BuscarGeneral;

CREATE PROCEDURE USP_TIpoMAscota_BuscarGrid
@intCodigo int
AS
BEGIN
	begin
		SELECT intCod_RAZ as Clave,
						strNombre_RAZ as Nombre,
						strNombre_EMP as Empleado							
		FROM tblRAZa inner join tblTIpoMAscota on  idTIMA_RAZ = intCod_TIMA
		inner join tblEMPleado on idEMP_RAZ = intCodigo_EMP
		WHERE idTIMA_RAZ = @intCodigo
	end

END
GO

alter PROCEDURE USP_TIpoMAscota_BuscarXCodigo
@intCodigo int

AS
	BEGIN
			SELECT intCod_TIMA as Clave,							
						strTipo_TIMA as Tipo,
						idEMP_TIMA as Empleado
			FROM tblTIpoMAscota
			WHERE intCod_TIMA = @intCodigo
			EXEC USP_TIpoMAscota_BuscarGrid @intCodigo;
  END
GO
--exec USP_TIpoMAscota_BuscarXCodigo 1;

CREATE PROCEDURE USP_TIpoMAscota_Grabar
	@Tipo varchar(25),
	@idEmpleado int
	AS
	BEGIN
		if exists (select intCod_TIMA from tblTIpoMAscota where strTipo_TIMA = @Tipo)
			begin
				select -1 as Rpta
				return
			end
		else
			begin transaction tx
			insert into tblTIpoMAscota values (@Tipo,@idEmpleado);
			if (@@ERROR > 0 )
				begin 
					rollback transaction tx
					select 0 as Rpta
					return 
					end
				commit transaction tx
			SELECT @@IDENTITY as Rpta
			return	
	END
GO
--exec USP_RAZa_Grabar 'pitbull',1,1;

CREATE PROCEDURE USP_TIpoMAscota_Modificar
	@Codigo	int,
	@Tipo varchar(25),
	@idEmpleado int
AS
BEGIN
	if not exists (select intCod_TIMA from tblTIpoMAscota where intCod_TIMA = @Codigo)
	begin
			select -1 as Rpta
			return
		end
	else
		begin transaction tx
		update tblTIpoMAscota
			set strTipo_TIMA=@tipo,
				idEMP_TIMA =@idEmpleado
			where intCod_TIMA = @Codigo
			if (@@ERROR>0)
				begin 
				rollback transaction tx
				select 0 as Rpta
				return
				end
			commit transaction tx
			select @Codigo as  Rpta
			return
END
GO 
--exec USP_RAZa_Modificar 16,'Pitbull',1,1;