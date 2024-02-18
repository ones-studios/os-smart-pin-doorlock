library {{ cookiecutter.project_name|lower|replace(' ', '_') }};

import 'package:flutter/material.dart';

class {{ cookiecutter.project_name|replace(' ', '') }}Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
