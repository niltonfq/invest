#!/bin/bash

cd invest_app
flutter clean && flutter pub get
cd ..
cd commons_deps
flutter clean && flutter pub get
cd ..
cd commons_design_system
flutter clean && flutter pub get
cd ..
cd login
flutter clean && flutter pub get
cd ..
cd micro_core
flutter clean && flutter pub get
cd ..
cd invest
flutter clean && flutter pub get