#!/bin/bash

# Navigate to the chrome_driver directory
cd /chrome_driver

# Launch chromedriver.exe
./chromedriver.exe -port=4444 &

# Navigate back to the project root directory
cd -

# Launch the integration test
flutter drive --driver=test_driver/app.dart --target=integration_test/app_test.dart -d web-server --no-headless