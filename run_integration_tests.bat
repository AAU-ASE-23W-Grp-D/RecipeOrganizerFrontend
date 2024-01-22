@echo off

REM Navigate to the chrome_driver directory
cd chrome_driver

REM Launch chromedriver.exe
start chromedriver.exe -port=4444

REM Navigate back to the project root directory
cd -

REM Launch the integration test
flutter drive --driver=test_driver/app.dart --target=integration_test/app_test.dart -d web-server --no-headless