import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:smart_pin_doorlock/smart_pin_doorlock_widget.dart';

void main() {
  runApp(ModularApp(module: MyModule(), child: MyApp()));
}

class MyModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    // TODO: bind your implementation to the interface here
    // Bind.singleton<SmartPinDoorlock>((i) => SmartPinDoorlockImplementation()),
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
            title: const Text('Smart Pin Doorlock plugin example app'),
          ),
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartPinDoorlockWidget();
  }
}

