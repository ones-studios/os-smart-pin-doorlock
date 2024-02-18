set -ex

(cd {{ cookiecutter.project_name|lower|replace(' ', '_') }};flutter analyze --no-fatal-warnings)