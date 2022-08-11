#!/bin/sh

# build apple
flutter build ipa --obfuscate --split-debug-info=./debug-info 
open build/ios/archive/Runner.xcarchive

# build android
flutter build appbundle --obfuscate --split-debug-info=./debug-info 
open build/app/outputs/bundle/release
open -a "Google Chrome" https://play.google.com/console/u/0/developers/7220422368349006935/app/4975727544480732721/publishing

# upload debug symbols
flutter packages pub run sentry_dart_plugin