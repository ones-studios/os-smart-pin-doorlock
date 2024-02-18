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
          final personName = pinCodes[index]['personName'];

          return Dismissible(
            key: UniqueKey(), // Ensure unique keys for dismissible items
            onDismissed: (direction) {
              _deletePinCode(pinCodes[index]['id']);
            },
            child: GFListTile(
              color: Colors.white60,
              radius: 5,
              titleText: pinCode,
              description: Text(createdAt.toString()),
              subTitleText: personName,
            ),
          );
        },
      ),
    );
  }

  Future<void> _clearAllPinCodes() async {
    final database = DatabaseProvider.of(context).database;

    showDialog(
      context: context,
      builder: (context) => GFFloatingWidget(
        showBlurness: true,
        child: GFAlert(
          title: 'Confirm Deletion',
          content: Text('Are you sure you want to delete all pin codes?'),
          bottomBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GFButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                shape: GFButtonShape.pills,
                child: Text('Cancel'),
              ),
              SizedBox(
                  width:5
              ),
              GFButton(
                onPressed: () async {
                  await database.delete('pincodes');
                  setState(() {
                    pinCodes = [];
                  });
                  fetchPinCodes(); // Refresh the list after deletion
                  Navigator.pop(context);
                },
                shape: GFButtonShape.pills,
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _deletePinCode(int id) async {
  //   final database = DatabaseProvider.of(context).database;
  //   await database.delete('pincodes', where: 'id = ?', whereArgs: [id]);
  //   fetchPinCodes(); // Refresh the list after deletion
  // }

  Future<void> _deletePinCode(int id) async {
    final database = DatabaseProvider.of(context).database;

    // Prompt for confirmation before deletion
    showDialog(
      context: context,
      builder: (context) => GFFloatingWidget(
        showBlurness: true,
        child: GFAlert(
          title: 'Confirm Deletion',
          content: Text('Are you sure you want to delete this pin code?'),
          bottomBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GFButton(
                onPressed: () async {
                  fetchPinCodes();
                  Navigator.pop(context);
                },
                shape: GFButtonShape.pills,
                child: Text('Cancel'),
              ),
              SizedBox(
                  width:5
              ),
              GFButton(
                onPressed: () async {
                  await database.delete('pincodes', where: 'id = ?', whereArgs: [id]);
                  fetchPinCodes(); // Refresh the list after deletion
                  Navigator.pop(context);
                },
                shape: GFButtonShape.pills,
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
