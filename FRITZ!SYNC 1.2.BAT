@ ECHO OFF
TITLE FRITZ!SYNC

REM --------------------------------------------------
REM CUSTOM VARIABLES
REM --------------------------------------------------

SET SOURCE=192.168.100.1

SET DESTINATION_01=I:
SET DESTINATION_02=
SET DESTINATION_03=
SET DESTINATION_04=
SET DESTINATION_05=
SET DESTINATION_06=
SET DESTINATION_07=
SET DESTINATION_08=
SET DESTINATION_09=
SET DESTINATION_10=

SET TITLE=FRITZ!SYNC
SET DRIVE=FRITZ!NAS
SET LOG=LOG

REM --------------------------------------------------

IF NOT "%1"=="" SET SOURCE=%1
IF NOT "%2"=="" SET DESTINATION_01=%2

IF "%TITLE%"=="" SET TITLE=FRITZ!SYNC
IF "%DRIVE%"=="" SET DRIVE=FRITZ!NAS
IF "%LOG%"=="" SET LOG=LOG

SET DAY=%DATE:~0,2%
SET MONTH=%DATE:~3,2%
SET YEAR=%DATE:~6,4%
SET HOURS=%TIME:~0,2%
SET MINUTES=%TIME:~3,2%
SET SECONDS=%TIME:~6,2%
IF "%HOURS:~0,1%"==" " SET HOURS=0%HOURS:~1,1%
SET CODE=%YEAR%%MONTH%%DAY%%HOURS%%MINUTES%%SECONDS%

REM \\fritz.nas\FRITZ.NAS\FRITZ!NAS
REM \\fritz.box\FRITZ.NAS\FRITZ!NAS
REM \\192.168.100.1\fritz.nas\FRITZ!NAS

IF NOT "%SOURCE%"=="" SET SOURCE=\\%SOURCE%\FRITZ.NAS\%DRIVE%

SET DESTINATION=EMPTY

IF NOT "%DESTINATION_01%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_02%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_03%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_04%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_05%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_06%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_07%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_08%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_09%"=="" SET DESTINATION=VALUE
IF NOT "%DESTINATION_10%"=="" SET DESTINATION=VALUE

IF NOT "%DESTINATION_01%"=="" SET DESTINATION_01=%DESTINATION_01%
IF NOT "%DESTINATION_02%"=="" SET DESTINATION_02=%DESTINATION_02%
IF NOT "%DESTINATION_03%"=="" SET DESTINATION_03=%DESTINATION_03%
IF NOT "%DESTINATION_04%"=="" SET DESTINATION_04=%DESTINATION_04%
IF NOT "%DESTINATION_05%"=="" SET DESTINATION_05=%DESTINATION_05%
IF NOT "%DESTINATION_06%"=="" SET DESTINATION_06=%DESTINATION_06%
IF NOT "%DESTINATION_07%"=="" SET DESTINATION_07=%DESTINATION_07%
IF NOT "%DESTINATION_08%"=="" SET DESTINATION_08=%DESTINATION_08%
IF NOT "%DESTINATION_09%"=="" SET DESTINATION_09=%DESTINATION_09%
IF NOT "%DESTINATION_10%"=="" SET DESTINATION_10=%DESTINATION_10%

IF NOT "%DESTINATION_01%"=="" SET LOG_01=%DESTINATION_01:~0,2%\LOG
IF NOT "%DESTINATION_02%"=="" SET LOG_02=%DESTINATION_02:~0,2%\LOG
IF NOT "%DESTINATION_03%"=="" SET LOG_03=%DESTINATION_03:~0,2%\LOG
IF NOT "%DESTINATION_04%"=="" SET LOG_04=%DESTINATION_04:~0,2%\LOG
IF NOT "%DESTINATION_05%"=="" SET LOG_05=%DESTINATION_05:~0,2%\LOG
IF NOT "%DESTINATION_06%"=="" SET LOG_06=%DESTINATION_06:~0,2%\LOG
IF NOT "%DESTINATION_07%"=="" SET LOG_07=%DESTINATION_07:~0,2%\LOG
IF NOT "%DESTINATION_08%"=="" SET LOG_08=%DESTINATION_08:~0,2%\LOG
IF NOT "%DESTINATION_09%"=="" SET LOG_09=%DESTINATION_09:~0,2%\LOG
IF NOT "%DESTINATION_10%"=="" SET LOG_10=%DESTINATION_10:~0,2%\LOG

IF "%1"=="/?" (

ECHO.
ECHO FRITZ!SYNC 1.2
ECHO.
ECHO FRITZ!SYNC [SOURCE] [DESTINATION:] [/PARAMETER]
ECHO.
ECHO PARAMETERS:
ECHO.
ECHO 	/SIM		THE SIMULATION RESULTS ARE AVAILABLE IN THE LOG
ECHO 	/SHUTDOWN	THE COMPUTER WILL SHUT DOWN 5 MINUTES AFTER THE SYNCHRONIZATION IS COMPLETE
ECHO.
ECHO USAGE EXAMPLES:
ECHO.
ECHO 	FRITZ!SYNC
ECHO 	FRITZ!SYNC /SHUTDOWN
ECHO 	FRITZ!SYNC 192.168.100.1 I:
ECHO 	FRITZ!SYNC 192.168.100.1 I: /SHUTDOWN
ECHO 	FRITZ!SYNC 192.168.100.1 I: /SIM

GOTO NONE

)

COLOR 02

CLS

ECHO TITLE		FRITZ!SYNC
ECHO VERSION		1.2
ECHO AUTHOR		LEONARDO PUMO
ECHO LICENSE		CC BY-NC-SA 4.0
ECHO WEB		https://ilfavolosomondodileo.wordpress.com/
ECHO ------------------------------------------------------------------------------------------------------------------------

IF NOT "%SOURCE%"=="" (

	ECHO SOURCE		%SOURCE%

) ELSE (

	ECHO SOURCE		NOT SPECIFIED

)

IF NOT "%DESTINATION%"=="EMPTY" (

	IF NOT "%DESTINATION_01%"=="" (

		ECHO DESTINATION	%DESTINATION_01%
		IF NOT "%DESTINATION_02%"=="" ( ECHO 		%DESTINATION_02% )
		IF NOT "%DESTINATION_03%"=="" ( ECHO 		%DESTINATION_03% )
		IF NOT "%DESTINATION_04%"=="" ( ECHO 		%DESTINATION_04% )
		IF NOT "%DESTINATION_05%"=="" ( ECHO 		%DESTINATION_05% )
		IF NOT "%DESTINATION_06%"=="" ( ECHO 		%DESTINATION_06% )
		IF NOT "%DESTINATION_07%"=="" ( ECHO 		%DESTINATION_07% )
		IF NOT "%DESTINATION_08%"=="" ( ECHO 		%DESTINATION_08% )
		IF NOT "%DESTINATION_09%"=="" ( ECHO 		%DESTINATION_09% )
		IF NOT "%DESTINATION_10%"=="" ( ECHO 		%DESTINATION_10% )

	) ELSE (

		ECHO DESTINATION_01	%DESTINATION_01%
		ECHO DESTINATION_02	%DESTINATION_02%
		ECHO DESTINATION_03	%DESTINATION_03%
		ECHO DESTINATION_04	%DESTINATION_04%
		ECHO DESTINATION_05	%DESTINATION_05%
		ECHO DESTINATION_06	%DESTINATION_06%
		ECHO DESTINATION_07	%DESTINATION_07%
		ECHO DESTINATION_08	%DESTINATION_08%
		ECHO DESTINATION_09	%DESTINATION_09%
		ECHO DESTINATION_10	%DESTINATION_10%

	)

) ELSE (

ECHO DESTINATION	NOT SPECIFIED

)

ECHO ------------------------------------------------------------------------------------------------------------------------

IF "%SOURCE%"=="" GOTO ERROR
IF "%DESTINATION%"=="EMPTY" GOTO ERROR

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_01
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_01%"=="" (

	IF EXIST "%DESTINATION_01:~0,2%" (

		IF NOT EXIST "%LOG_01%" MKDIR "%LOG_01%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_01%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_01%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_01%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_01%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_01:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_02
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_02%"=="" (

	IF EXIST "%DESTINATION_02:~0,2%" (

		IF NOT EXIST "%LOG_02%" MKDIR "%LOG_02%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_02%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_02%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_02%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_02%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_02:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_03
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_03%"=="" (

	IF EXIST "%DESTINATION_03:~0,2%" (

		IF NOT EXIST "%LOG_03%" MKDIR "%LOG_03%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_03%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_03%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_03%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_03%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_03:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_04
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_04%"=="" (

	IF EXIST "%DESTINATION_04:~0,2%" (

		IF NOT EXIST "%LOG_04%" MKDIR "%LOG_04%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_04%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_04%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_04%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_04%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_04:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_05
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_05%"=="" (

	IF EXIST "%DESTINATION_05:~0,2%" (

		IF NOT EXIST "%LOG_05%" MKDIR "%LOG_05%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_05%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_05%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_05%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_05%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_05:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_06
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_06%"=="" (

	IF EXIST "%DESTINATION_06:~0,2%" (

		IF NOT EXIST "%LOG_06%" MKDIR "%LOG_06%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_06%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_06%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_06%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_06%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_06:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_07
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_07%"=="" (

	IF EXIST "%DESTINATION_07:~0,2%" (

		IF NOT EXIST "%LOG_07%" MKDIR "%LOG_07%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_07%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_07%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_07%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_07%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_07:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_08
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_08%"=="" (

	IF EXIST "%DESTINATION_08:~0,2%" (

		IF NOT EXIST "%LOG_08%" MKDIR "%LOG_08%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_08%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_08%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_08%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_08%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_08:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_09
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_09%"=="" (

	IF EXIST "%DESTINATION_09:~0,2%" (

		IF NOT EXIST "%LOG_09%" MKDIR "%LOG_09%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_09%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_09%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_09%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_09%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_09:~0,2% WAS NOT DETECTED

	)

)

REM ----------------------------------------------------------------------------------------------------
REM DESTINATION_10
REM ----------------------------------------------------------------------------------------------------

IF NOT "%DESTINATION_10%"=="" (

	IF EXIST "%DESTINATION_10:~0,2%" (

		IF NOT EXIST "%LOG_10%" MKDIR "%LOG_10%"
		IF "%3"=="/SIM" (
			ROBOCOPY "%SOURCE%" "%DESTINATION_10%" /MIR /R:3 /W:30 /L /NP /ETA /UNILOG:"%LOG_10%\%CODE%.LOG" /TEE
		) ELSE (
			ROBOCOPY "%SOURCE%" "%DESTINATION_10%" /MIR /R:3 /W:30 /NP /ETA /UNILOG:"%LOG_10%\%CODE%.LOG" /TEE
		)

	) ELSE (

		ECHO 		DRIVE %DESTINATION_10:~0,2% WAS NOT DETECTED

	)

)

GOTO EXIT

: ERROR

ECHO ERROR		INVALID CONFIGURATION

: EXIT

ECHO.
ECHO THIS WINDOW WILL CLOSE IN 10 SECONDS
TIMEOUT /T 10 /NOBREAK > NUL

IF "%1"=="/SHUTDOWN" shutdown /s /t 300 /d p:4:1 /c "THE COMPUTER WILL SHUTDOWN IN 5 MINUTES"
IF "%3"=="/SHUTDOWN" shutdown /s /t 300 /d p:4:1 /c "THE COMPUTER WILL SHUTDOWN IN 5 MINUTES"

EXIT

: NONE
