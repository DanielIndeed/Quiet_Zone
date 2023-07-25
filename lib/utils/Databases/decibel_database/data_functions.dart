// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> openDb() async {
  final databasesPath = await getDatabasesPath();
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

Future<void> deletedata() async {
    final db = await openDb();
    final batch = db.batch();
    batch.delete('decibel_dataset');
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

Future<String> getMean() async {
  final db = await openDb();
  final result = await db.rawQuery('SELECT AVG(number) FROM decibel_dataset');
  if (result.isNotEmpty) {
    final mean = result.first.values.first as num?;
    return mean?.toStringAsFixed(2) ?? '0.00';
  } else {
    return '0.00';
  }
}

Future<String> getRows() async {
  final db = await openDb();
  final result = await db.rawQuery('SELECT COUNT(*) FROM decibel_dataset');
  if (result.isNotEmpty) {
    final rows = result.first.values.first as num?;
    return rows?.toStringAsFixed(2) ?? '0.00';
  } else {
    return '0.00';
  }
}