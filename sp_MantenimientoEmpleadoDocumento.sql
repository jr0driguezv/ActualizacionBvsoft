USE [Bvsoft]
GO
/****** Object:  StoredProcedure [dbo].[sp_MantenimientoEmpleadoDocumento]    Script Date: 23/6/2021 9:17:17 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  Stored Procedure EMPLEADO DOCUMENTO
     Creado Por J. Rodríguez.-
              *****  Este recibe como parametro todos los campos de la tabla de lista negra
              ADD--> Crea un registro
              UPD--> Modifica un registro
              DEL-->  Borra un registro  
                 
               El cual devuelve
               0-  el proceso se realiza sin error
               1-  Trata de crear un registro que ya existe, es decir no se pueden duplicar el codigo de un regristro
               2.- Trata de modificar un registro que no existe
               3.- Trata de borrar un registro que no existe
  
*/
ALTER PROCEDURE [dbo].[sp_MantenimientoEmpleadoDocumento] (
@Modo   		   char(3),
@codigo_empleado   numeric(18,0),
@codigo_documento  varchar(50),
@descripcion		varchar(100),
@tipo_documento  numeric(18, 0)
 )
--Reemplazar   WITH ENCRYPTION
 AS

--if @Modo = 'ADD' /* si voy a añadir un registro nuevo */
--begin
--	if exists(select codigo_documento from EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento)
--		return(1)
--	else
--		insert into EMPLEADO_DOCUMENTO (codigo_empleado, codigo_documento, descripcion, tipo_documento)
--	    values (@codigo_empleado,@codigo_documento,@descripcion,@tipo_documento)
--end


--if @Modo = 'DEL'    /* Borrar el registro */
--	if exists(select codigo_documento from EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento)
--		delete EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento
--	else
--		 return(2)    /* El registro que se quiere borrar no existe */

if @Modo = 'ADD' /* si voy a añadir un registro nuevo */
begin
	if exists(select codigo_documento from EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento)
		return(1)
	else
	begin
		insert into EMPLEADO_DOCUMENTO (codigo_empleado, codigo_documento, descripcion, tipo_documento)
	    values (@codigo_empleado,@codigo_documento,@descripcion,@tipo_documento)
	end
end

if @Modo = 'UPD' /* Modificar un registro que ya existe */
begin
	if exists(select codigo_documento from EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento)
	begin
		update EMPLEADO_DOCUMENTO set
		descripcion = @descripcion
		where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento
	end
	else	
		return(2) /* el registro que se quiere modificar no existe   */
end

if @Modo = 'DEL' /* Borrar el registro */
begin
	if exists(select codigo_documento from EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento)
	begin
		delete EMPLEADO_DOCUMENTO where codigo_empleado = @codigo_empleado and codigo_documento = @codigo_documento
	end
	else
		 return (3)  /* El registro que se quiere borrar no existe */
end