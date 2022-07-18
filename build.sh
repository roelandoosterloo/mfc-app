#!/bin/sh
flutter build ipa --obfuscate --split-debug-info=./debug-info 
open build/ios/archive/Runner.xcarchive
flutter build appbundle --obfuscate --split-debug-info=./debug-info 