set -ex

(cd smart_pin_doorlock;flutter pub run build_runner build --delete-conflicting-outputs)
(cd test_app; flutter pub run build_runner build --delete-conflicting-outputs)