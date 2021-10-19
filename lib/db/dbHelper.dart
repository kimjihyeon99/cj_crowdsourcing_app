import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cj_crowdsourcing_app/model/info.dart';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(join(await getDatabasesPath(), 'Info.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
    return _db;
  }

  static void _createDb(Database db) {
    db.execute(
      "CREATE TABLE Info(id TEXT PRIMARY KEY, pw TEXT)",
    );
  }

  Future<void> insertInfo(Info info) async {
    final db = await database;

    await db.insert("Info", info.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Info>> getAllInfo() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Info');

    return List.generate(maps.length, (i) {
      return Info(
        id: maps[i]['id'],
        pw: maps[i]['pw'],
      );
    });
  }

  Future<dynamic> getInfo(String id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = (await db.query(
      'Info',
      where: 'id = ?',
      whereArgs: [id],
    ));

    return maps.isNotEmpty ? maps : null;
  }

  Future<void> updateInfo(Info info) async {
    final db = await database;

    await db.update(
      "Info",
      info.toMap(),
      where: "id = ?",
      whereArgs: [info.id],
    );
  }

  Future<void> deleteInfo(String id) async {
    final db = await database;

    await db.delete(
      "Info",
      where: "id = ?",
      whereArgs: [id],
    );
  }

}