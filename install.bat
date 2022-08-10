echo Instalador de la base de datos Universidad
echo Autor: Jesus Ninantay
echo Fecha: 08/08/22
sqlcmd -S. -E -i BDUniverdidad.sql
sqlcmd -S. -E -i UniversidadPA.sql
echo Se ejecuto correctamente la Base de datos
pause