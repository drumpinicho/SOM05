@ECHO off
REM El siguiente script está pensado para poderse usar con o sin parámetros, pondré una sección de ayuda
REM Para que se vea el menú tal y como lo he concebido se cambia el código de página a UTF8 (65001)
CHCP 65001
CLS
REM Se observa si se meten parámetros en el .bat y se actúa en consecuencia
REM Se utiliza el modificador “/I” para que no distinga entre mayúsculas y minúsculas
IF /I "%1"=="editar" (
    IF NOT "%2"=="" (
	GOTO EDITAR_ARCHIVO
    ) ELSE (
        GOTO EDITAR
    )
) ELSE IF /I "%1"=="informacion" (
    GOTO INFORMACIONGR
) ELSE IF /I "%1"=="help" (
    GOTO AYUDA
) ELSE IF "%1"=="" (
	GOTO MENU
	) ELSE (
    ECHO No se reconoce esa opción.
    ECHO Pulse Enter y escoja una opción en el menú.
    PAUSE 
    GOTO MENU
)

:MENU
REM Me he acordado de cuando usaba el BASIC en un MSX que tenía y no he parado hasta que he encontrado los caracteres necesarios
CLS
ECHO.
ECHO   ┌─────────────────────────────────────────┐
ECHO   │     Menú de Opciones                    │
ECHO   ├─────────────────────────────────────────┤
ECHO   │ 1. Editar                               │
ECHO   ├─────────────────────────────────────────┤
ECHO   │ 2. Información del Sistema modo texto   │
ECHO   ├─────────────────────────────────────────┤
ECHO   │ 3. Información del Sistema modo gráfico │
ECHO   ├─────────────────────────────────────────┤
ECHO   │ 4. Ayuda                                │
ECHO   ├─────────────────────────────────────────┤
ECHO   │ 5. Salir                                │
ECHO   └─────────────────────────────────────────┘
ECHO.
SET /p OPCION="Seleccione una opción: "

IF "%OPCION%"=="1" (
    ECHO Abriendo editor...
   timeout /t 2>NUL
	GOTO EDITAR
) ELSE IF "%OPCION%"=="2" (
    GOTO INFORMACION
) ELSE IF "%OPCION%"=="3" (
    GOTO INFORMACIONGR
) ELSE IF "%OPCION%"=="4" (
	GOTO AYUDA
) ELSE IF "%OPCION%"=="5" (
    ECHO Saliendo...
   	msg %username% /w Gracias por utilizar este archivo por lotes. Recuerde poner buena nota XD
    EXIT
) ELSE (
    ECHO Opción no válida. Inténtalo de nuevo.
    PAUSE
    GOTO MENU
)

:EDITAR
ECHO Especifique el nombre o ruta del archivo que quiere editar, o deje en blanco para crear uno nuevo
SET /p ARCHIVO="Nombre o ruta del archivo: "
IF "%ARCHIVO%"=="" (
	START notepad.exe
	GOTO MENU
) ELSE (
START notepad.exe "%ARCHIVO%"
GOTO MENU
)
:EDITAR_ARCHIVO
	ECHO Se va a editar el archivo %2
    PAUSE
	START notepad.exe "%2"
	GOTO MENU
:INFORMACION
	ECHO Mostrando información del sistema y memoria en modo texto
	timeout /t 2
    systeminfo 
    PAUSE
	GOTO MENU
:INFORMACIONGR
	ECHO Mostrando información del sistema y memoria en modo gráfico
    timeout /t 2>NUL
	REM Estaba indeciso por cual usar, he descartado el de control system
	:: control system
	msinfo32
    GOTO MENU
:AYUDA
	CLS
	COLOR F0
	ECHO.
	ECHO.
	ECHO   ┌─────────────────────────────────────────────────────────────────────────┐
	ECHO   │  Este script puede utilizarse de diferentes maneras:                    │
	ECHO   └─────────────────────────────────────────────────────────────────────────┘
	ECHO   %0 editar //Abrirá el notepad con un archivo nuevo si no se especifica
	ECHO   %0 editar archivo.txt //Abrirá el notepad con el archivo indicado     
	ECHO   %0 informacion //Abrirá la información del sistema      
	ECHO   %0 help //Muestra esta información                                   
	ECHO   %0 //Sin nada más abre el menú del script con las diferentes opciones 
	ECHO.
	PAUSE
	COLOR 0F
	GOTO MENU
