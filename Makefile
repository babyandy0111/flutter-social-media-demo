build_splash:
	flutter pub run flutter_native_splash:create

build_freezed:
	flutter pub run build_runner build

build-icon:
	flutter pub run flutter_launcher_icons:main

open-xcode:
	cd ios && open Runner.xcworkspace && cd ..

## https://firebase.google.com/docs/flutter/setup?platform=ios&hl=zh-tw
configure-firebaase:
	flutterfire configure
