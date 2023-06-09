import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb() async {
    final databasesPath = await getDatabasesPath();
    print(databasesPath);
    final path = join(databasesPath, 'my_database.db');

    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE decibel_dataset (id INTEGER PRIMARY KEY, number INTEGER)');
    }, version: 1);
  }

Future<void> insertNumber(number) async {
    final db = await openDb();
    final batch = db.batch();
    batch.insert('decibel_dataset', {'number': number});
    await batch.commit();
  }

int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void dummy_data() async {
    var randomNumber = 0;
    for (int i = 1; i <= 50; i++) {
      randomNumber = random(110, 120);
      await insertNumber(randomNumber);
    }
  }