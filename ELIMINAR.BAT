@ECHO OFF
REM Script para verificar y eliminar archivos
REM En principio podría borrar hasta 9 archivos
REM
REM Primero miramos si se han introducido los nombres de 
REM los archivos a borrar,si no se indica como hacerlo
IF "%1"=="" (
    GOTO HELP
) ELSE (
REM para cada archivo que se va a eliminar se confirma si existe
REM y en caso negativo se solicita un nombre nuevo
	FOR %%A IN (%*) DO (
		IF EXIST %%A (
			ECHO Eliminando %%A
			DEL %%A
		) ELSE (
			SET /p NUEVO="El archivo %%A no existe. Indique uno nuevo: "
			IF NOT "%NUEVO%"=="" (
				ECHO Eliminando %NUEVO%
				DEL %NUEVO%
			) ELSE (
				ECHO No hay archivo que eliminar, saliendo.
			)
		)
	)
)
EXIT /B

:HELP
ECHO La forma de usar %0 es la siguiente:
ECHO.
ECHO %0 "Archivo_eliminar_1" "Archivo_eliminar_2"
ECHO.
