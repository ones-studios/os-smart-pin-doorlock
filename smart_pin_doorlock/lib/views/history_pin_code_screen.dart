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
      body: ListView.builder(
        itemCount: pinCodes.length,
        itemBuilder: (context, index) {
          final pincode = pinCodes[index]['pincode'];
          final createdAt = DateTime.parse(pinCodes[index]['createdAt']);

          return GFListTile(
            titleText: pincode,
            subTitleText: DateFormat('yyyy-MM-dd hh:mm:ss').format(createdAt),
          );
        },
      ),
    );
  }
}
