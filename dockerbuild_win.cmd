REM Migrate this to cake

for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do set %%x
set VAR_DATE=%Year%-%Month%-%Day%-%Hour%-%Minute%-%Second% 
@set VAR_VER=0.0.0
for /f %%a in ('git rev-parse --short HEAD') do @set VAR_REF=%%a

dotnet clean
dotnet restore
dotnet publish containertest.csproj -c Release -r win10-x64
docker build -f Dockerfile_win -t richardcase/containertest-api_win --build-arg BUILD_DATE=%VAR_DATE% --build-arg VCS_REF=%VAR_REF% --build-arg VERSION=%VAR_VER%  .

ECHO Done