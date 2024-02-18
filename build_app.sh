set -ex

sh flutter_clean.sh

sh pub_get.sh

sh build_runner.sh

sh analyze.sh

sh test_coverage.sh

(cd test_app;flutter build apk)

rm -r ~/Library/Developer/Xcode/DerivedData
(cd test_app;flutter build ios --simulator)