@ECHO OFF

SET SQLCMD="C:\Program Files\Microsoft SQL Server\100\Tools\Binn\SQLCMD.EXE"
SET PATH="C:\path\to\sql\files\"
SET SERVER="Server\Instance"
SET DB="Database"
SET LOGIN="sa"
SET PASSWORD="pass"
SET OUTPUT="C:\OutputLog.txt"

CD %PATH%

ECHO %date% %time% > %OUTPUT%

for %%f in (*.sql) do (
%SQLCMD% -S %SERVER% -d %DB% -U %LOGIN% -P %PASSWORD% -i %%~f >> %OUTPUT%
)

::OR if your scripts can be combined into one sql file and then executed 
::we can skip the FOR loop and do something like this.
Rem == ::

@ECHO OFF

SET SQLCMD="C:\Program Files\Microsoft SQL Server\100\Tools\Binn\SQLCMD.EXE"
SET PATH="C:\path\to\sql\files\"
SET SERVER="Server\Instance"
SET DB="Database"
SET LOGIN="sa"
SET PASSWORD="pass"
SET INPUT="C:\AllScripts.sql"
SET OUTPUT="C:\OutputLog.txt"

COPY %PATH%\*.SQL %INPUT%

%SQLCMD% -S %SERVER% -d %DB% -U %LOGIN% -P %PASSWORD% -i %INPUT% -o %OUTPUT%
