rem set pm2HomeDir=C:\\nodeapps\\_pm2
echo off
IF "%pm2HomeDir%" == "" (set pm2HomeDir=C:\\nodeapps\\_pm2)
echo pm2HomeDir = %pm2HomeDir%
IF NOT EXIST %pm2HomeDir%\.pm2 mkdir %pm2HomeDir%\.pm2
cd %pm2HomeDir%
echo 1. npm install -g pm2
call npm i -g pm2 > install_log_npm_glob_pm2.txt
echo 2. set PM2_HOME
setx /M PM2_HOME %pm2HomeDir%\.pm2
echo 3. npm install pm2
call npm i pm2 > install_log_npm_local_pm2.txt
echo var pm2 = require('pm2'); > start.js
echo var path = require('path'); >> start.js
echo var appsConfPath = path.join('C:\\nodeapps\\_pm2','apps-config.json'); >> start.js
echo var apps = require(appsConfPath); >> start.js
echo pm2.connect(function(err) { >> start.js
echo   pm2.start(apps, { name: 'autostart' }, function(err, proc) { >> start.js
echo     if (err) throw new Error('err'); >> start.js
echo     pm2.list(function(err, process_list) { >> start.js
echo       console.log(process_list); >> start.js
echo       pm2.disconnect(function() { process.exit(0) }); >> start.js
echo     }); >> start.js
echo   }); >> start.js
echo }) >> start.js
echo 4. script.js created
echo cd %pm2HomeDir% > run.bat
echo node start.js >> run.bat
echo 5. run.bat created
echo done.
echo pause >> run.bat
pause
