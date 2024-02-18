set -ex

(cd {{ cookiecutter.project_name|lower|replace(' ', '_') }}; flutter clean)
(cd test_app; flutter clean)