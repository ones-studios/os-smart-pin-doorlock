set -e

function generateCoverage {
  echo "Generating test coverage for SmartPinDoorlock"
  (cd smart_pin_doorlock; flutter test --coverage)
  (cd smart_pin_doorlock/coverage; sed -i '' "s|SF:lib/|SF:smart_pin_doorlock/lib/|g" lcov.info)

  echo "Combining all coverage into file://$(pwd)/all_coverage/combined-coverage.info"
  lcov --add-tracefile smart_pin_doorlock/coverage/lcov.info --base-directory smart_pin_doorlock/lib --no-external -d smart_pin_doorlock \
       --output-file all_coverage/combined-coverage.info
  echo "Generating html file test coverage for SmartPinDoorlock"
  genhtml all_coverage/combined-coverage.info --output-directory all_coverage/html --show-details
  echo "Open this file file://$(pwd)/all_coverage/html/index.html"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v lcov >/dev/null 2>&1; then
    generateCoverage
  else
    echo "lcov is not installed in mac"
    echo "Installing lcov using this command 'brew install lcov'"
    brew install lcov
    generateCoverage
  fi
elif [[ "$OSTYPE" == "msys" ]]; then
  if where lcov >/dev/null 2>&1; then
    generateCoverage
  else
    echo "lcov is not installed in windows"
    echo "Please refer to the following link for more information: https://github.com/linux-test-project/lcov."
  fi
else
  echo "Unknown operating system"
fi