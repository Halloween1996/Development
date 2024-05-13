for /f "delims=" %%i in (%cd%\Batch_Environment.ini) do set "%%i"
If not "%1"=="" set "beu=credentials=%Environment%\NoteWiki\myusers.csv "readers=(anon)" writers=Ween"
start "" "http://10.0.0.139:8080"
node.exe %Environment%\TiddlyWiki5-5.1.23\tiddlywiki.js %Environment%\NoteWiki --listen host=10.0.0.139 port=8080 %beu%
pause