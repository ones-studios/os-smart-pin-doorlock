import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:smart_pin_doorlock/views/generate_pin_code_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'history_pin_code_screen.dart';
import 'package:smart_pin_doorlock/di/tab_controller_provider.dart';

class HomeTabScreen extends StatefulWidget {

  HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with TickerProviderStateMixin {
  // late TabController tabController = TabController(initialIndex: 0, length: 2, vsync: this);

  late TabController tabController;

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  // ... other functions for PINcode generation and handling ...

  @override
  Widget build(BuildContext context) {
    tabController = TabControllerProvider.of(context).tabController;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Code Genie"),
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(text: 'Generate'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            _buildGenerateScreen(),
            _buildHistoryScreen()
          ],
        )
      ),
    );
  }

  Widget _buildGenerateScreen() {
    return GeneratePinCodeScreen(
      onPinCodeConfirmed: () {
        tabController.animateTo(1);
      },
    );
  }

  Widget _buildHistoryScreen() {
    return const HistoryPinCodeScreen();
  }
}
