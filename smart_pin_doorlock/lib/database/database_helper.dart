import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String TABLE_NAME = 'pincodes';

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/pincodes.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pincode TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }
}
