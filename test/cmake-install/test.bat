@echo off
setlocal enabledelayedexpansion

set EXTRA_ARGS=%*
set SRC_DIR=%~dp0
set BUILD_DIR=%SRC_DIR%build-dir
set INSTALL_DIR=%SRC_DIR%install-dir
set NLOHMANN_JSON_DIR=%nlohmann_json_DIR%
set TEST_SRC_DIR=%SRC_DIR%project

cmake --version

REM Clear out build directory
if exist %BUILD_DIR% rd /s /q %BUILD_DIR%
mkdir %BUILD_DIR%
cd %BUILD_DIR%

REM configure json-schema-validator
echo -----------------------------------------------------------
echo Configuring, building, and installing json-schema-validator
echo -----------------------------------------------------------
cmake -DCMAKE_INSTALL_PREFIX:PATH=%INSTALL_DIR% -Dnlohmann_json_DIR:PATH=%NLOHMANN_JSON_DIR% %EXTRA_ARGS% %SRC_DIR%

REM Build and install json-schema-validator
cmake --build . -- /m
cmake --build . --target install -- /m

REM Make sure build directory is empty
if exist %BUILD_DIR% rd /s /q %BUILD_DIR%
mkdir %BUILD_DIR%
cd %BUILD_DIR%

REM configure test project
echo -----------------------------------------------------------
echo Configuring, building, and running test project
echo -----------------------------------------------------------
cmake -Dnlohmann_json_DIR:PATH=%NLOHMANN_JSON_DIR% -Dnlohmann_json_schema_validator_DIR:PATH=%INSTALL_DIR%/lib/cmake/nlohmann_json_schema_validator -DVALIDATOR_INSTALL_DIR:PATH=%INSTALL_DIR% %EXTRA_ARGS% %TEST_SRC_DIR%

REM Build test project and test
cmake --build .
ctest --output-on-failure