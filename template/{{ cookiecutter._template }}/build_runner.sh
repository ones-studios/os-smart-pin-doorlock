set -ex

(cd {{ cookiecutter.project_name|lower|replace(' ', '_') }};flutter pub run build_runner build --delete-conflicting-outputs)
(cd test_app; flutter pub run build_runner build --delete-conflicting-outputs)