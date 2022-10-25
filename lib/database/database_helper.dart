import 'package:resto_app/model/restaurants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblFav = 'fav';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/resto.db', version: 1, onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblFav (
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT NOT NULL,
        pictureId TEXT NOT NULL,
        description TEXT NOT NULL,
        city TEXT NOT NULL,
        rating FLOAT NOT NULL)''');
    });
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<List<Restaurants>> getFavs() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFav);
    return results.map((result) => Restaurants.fromJson(result)).toList();
  }

  Future<void> addFav(Restaurants resto) async {
    final db = await database;
    await db!.insert(_tblFav, resto.toJson());
  }

  Future<Map> getFavById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result = 
        await db!.query(_tblFav, where: 'id = ?', whereArgs: [id]);

    if(result.isNotEmpty) return result.first;
    return {};
  }

  Future<void> destroyFav(String id) async {
    final db = await database;
    await db!.delete(_tblFav, where: 'id = ?', whereArgs: [id]);
  }
}