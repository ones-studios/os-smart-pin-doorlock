set -ex

(cd smart_pin_doorlock; flutter pub get)
(cd test_app; flutter pub get)

(cd test_app; flutter precache --ios)
(cd test_app/ios; bundle install; bundle exec pod install)