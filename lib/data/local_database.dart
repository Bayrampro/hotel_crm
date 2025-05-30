import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotel_crm/core/consts/constans.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = await _getDatabasePath();
    final exists = await File(path).exists();

    if (!exists) {
      await _copyDatabaseFromAssets(path);
    }

    return await _openDatabase(path);
  }

  Future<String> _getDatabasePath() async {
    final dir = await getApplicationSupportDirectory();
    return join(dir.path, Constans.dbName);
  }

  Future<void> _copyDatabaseFromAssets(String path) async {
    final data = await rootBundle.load(Assets.dbPath);
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<Database> _openDatabase(String path) async {
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      return await databaseFactoryFfi.openDatabase(path);
    } else {
      return await openDatabase(path);
    }
  }
}
