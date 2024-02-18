import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:{{ cookiecutter.project_name|lower|replace(' ', '_') }}/{{ cookiecutter.project_name|lower|replace(' ', '_') }}_widget.dart';

void main() {
  runApp(ModularApp(module: MyModule(), child: MyApp()));
}

class MyModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    // TODO: bind your implementation to the interface here
    // Bind.singleton<{{ cookiecutter.project_name|replace(' ', '') }}>((i) => {{ cookiecutter.project_name|replace(' ', '') }}Implementation()),
  ];
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('{{ cookiecutter.project_name }} plugin example app'),
          ),
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return {{ cookiecutter.project_name|replace(' ', '') }}Widget();
  }
}

