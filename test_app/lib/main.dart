import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_pin_doorlock/di/database_provider.dart';
import 'package:smart_pin_doorlock/di/tab_controller_provider.dart';
import 'package:smart_pin_doorlock/views/home_tab_screen.dart';
import 'package:smart_pin_doorlock/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseHelper().initDatabase();

  runApp(MyApp(database: database));
}

class MyModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    // TODO: bind your implementation to the interface here
    // Bind.singleton<SmartPinDoorlock>((i) => SmartPinDoorlockImplementation()),
  ];
}

class MyApp extends StatefulWidget {
  final Database database;

  const MyApp({Key? key, required this.database})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(database);

}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  final Database database;

  _MyAppState(this.database);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PINcode Generator',
      home: TabControllerProvider(
        tabController: tabController,
        child: DatabaseProvider(
          database: database,
          child: HomeTabScreen(),
        ),
      ),
    );
  }
}

