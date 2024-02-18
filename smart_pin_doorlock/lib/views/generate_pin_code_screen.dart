import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math';
import 'package:smart_pin_doorlock/di/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class GeneratePinCodeScreen extends StatefulWidget {
  final VoidCallback onPinCodeConfirmed; // Define a callback function parameter

  const GeneratePinCodeScreen({super.key, required this.onPinCodeConfirmed});

  @override
  State<GeneratePinCodeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<GeneratePinCodeScreen> {
  String pinCode = "";

  void clearPincode() {
    setState(() {
      pinCode = "";
    });
  }

  void generateNewPinCode() {
    String newPinCode = "";
    for (int i = 0; i < 6; i++) {
      newPinCode += Random().nextInt(10).toString();
    }
    setState(() {
      pinCode = newPinCode;
    });
  }

  void addToPinCode(String digit) {
    if (pinCode.length < 6) {
      setState(() {
        pinCode += digit;
      });
    }
  }

  void confirmPinCode(Database database) async {
    if(pinCode.length == 6) {
      await database.insert('pincodes', {'pincode': pinCode});
    }
    setState(() {
      pinCode = "";
    });
    widget.onPinCodeConfirmed(); // Invoke the callback function
  }

  @override
  Widget build(BuildContext context) {

    final database = DatabaseProvider.of(context).database;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    pinCode,
                    style: const TextStyle(fontSize: 36),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFButton(
                        onPressed: generateNewPinCode,
                        text: 'Generate Pincode',
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 20),
                      GFButton(
                        onPressed: clearPincode,
                        text: 'Clear',
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Text('1', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('1'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('2', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('2'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('3', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('3'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Text('4', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('4'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('5', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('5'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('6', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('6'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Text('7', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('7'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('8', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('8'),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Text('9', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('9'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Text('0', style: const TextStyle(fontSize: 24)),
                        onPressed: () => addToPinCode('0'),
                      ),
                      SizedBox(width: 20),
                      GFButton(
                        onPressed: () => {
                          confirmPinCode(database)
                        },
                        text: 'Confirm',
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
