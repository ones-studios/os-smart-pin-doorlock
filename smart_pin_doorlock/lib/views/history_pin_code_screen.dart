import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:smart_pin_doorlock/di/database_provider.dart';

class HistoryPinCodeScreen extends StatefulWidget {

  const HistoryPinCodeScreen({super.key});

  @override
  State<HistoryPinCodeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HistoryPinCodeScreen> {
  List<Map<String, dynamic>> pinCodes = [];

  Future<void> fetchPinCodes() async {
    final database = DatabaseProvider.of(context).database;
    final results = await database.query('pincodes', orderBy: 'createdAt DESC');
    setState(() {
      pinCodes = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchPinCodes();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          GFButton(
            onPressed: _clearAllPinCodes,
            text: 'Delete All',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pinCodes.length,
        itemBuilder: (context, index) {
          final pinCode = pinCodes[index]['pincode'];
          final createdAt = pinCodes[index]['createdAt'];

          return Dismissible(
            key: UniqueKey(), // Ensure unique keys for dismissible items
            onDismissed: (direction) {
              _deletePinCode(pinCodes[index]['id']);
            },
            child: GFListTile(
              titleText: pinCode,
              subTitleText: createdAt.toString(),
            ),
          );
        },
      ),
    );
  }

  Future<void> _clearAllPinCodes() async {
    final database = DatabaseProvider.of(context).database;
    await database.delete('pincodes');
    setState(() {
      pinCodes = [];
    });
  }

  Future<void> _deletePinCode(int id) async {
    final database = DatabaseProvider.of(context).database;
    await database.delete('pincodes', where: 'id = ?', whereArgs: [id]);
    fetchPinCodes(); // Refresh the list after deletion
  }
}
