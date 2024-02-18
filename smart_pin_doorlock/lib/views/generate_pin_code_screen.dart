import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math';
import 'package:smart_pin_doorlock/di/database_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class GeneratePinCodeScreen extends StatefulWidget {
  final VoidCallback onPinCodeConfirmed; // Define a callback function parameter

  const GeneratePinCodeScreen({super.key, required this.onPinCodeConfirmed});

  @override
  State<GeneratePinCodeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<GeneratePinCodeScreen> {
  String pinCode = "";
  String personName = ""; // Add a variable to store the person's name

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

  // Function to convert datetime to database format (replace with your implementation)
  String convertDatetime(DateTime datetime) {
    // Implement conversion logic here
    // Example: return datetime.toIso8601String();

    return DateFormat.yMEd().add_jms().format(datetime);
  }

  void confirmPinCode(Database database) async {
    if (pinCode.length == 6 && personName.isNotEmpty) {
      final deviceDatetime = DateTime.now();
      final databaseDatetime = convertDatetime(deviceDatetime);

      // Check for duplicate pin code before inserting
      final duplicated = await database.query(
        'pincodes',
        where: 'pincode = ?',
        whereArgs: [pinCode],
      );

      if (!duplicated.isNotEmpty) {
        await database.insert(
          'pincodes',
          {
            'pincode': pinCode,
            'personName': personName,
            'createdAt': databaseDatetime
          },
        );
        widget.onPinCodeConfirmed();
      } else {
        // Handle duplicate pin code here, e.g., display an error message
        GFToast.showToast(
          'Pin code already exists',
          context,
        );
      }
      setState(() {
        pinCode = "";
        personName = "";
      });
    } else {
      // Display an error message if the name is empty
      GFToast.showToast(
        'Please enter the person\'s name',
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final database = DatabaseProvider.of(context).database;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      GFTextField(
                        decoration: const InputDecoration(labelText: 'Person Name'),
                        controller: TextEditingController(text: personName),
                        onChanged: (value) => personName = value,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        pinCode,
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
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
        ),
      ),
    );
  }
}
