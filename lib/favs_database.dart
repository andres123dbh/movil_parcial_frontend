import 'package:movil_parcial_frontend/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// singleton pattern for db creation in sqlite
class FavoritesDatabase {
  static final FavoritesDatabase instance = FavoritesDatabase.init();

  static Database? _database;

  FavoritesDatabase.init();

  // if there is no db, create it
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await createsDatabase();

    return _database!;
  }

  Future<Database> createsDatabase() async {
    Future<Database> getdatabase = openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      // When database is created for the first time
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE favorites(
            id TEXT PRIMARY KEY, 
            title TEXT,
            seller TEXT, 
            rating DOUBLE,
            img TEXT
            )''',
        );
      },
      // version executes the onCreate and establish route for updated in db
      version: 1,
    );
    return getdatabase;
  }

  Future<void> addFavorites(Product product) async {
    try {
      final db = await instance.database;
      // todo unique index
      await db.insert('favorites', product.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return;
    } catch (e) {
      throw Error();
    }
  }

  //todo index
  Future<void> deleteFavorites(String idItem) async {
    try {
      final db = await instance.database;
      await db.delete('favorites', where: "id = ?", whereArgs: [idItem]);
      return;
    } catch (e) {
      throw Error();
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await instance.database;
      await db.execute('DELETE FROM favorites');
      return;
    } catch (e) {
      throw Error();
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> result = await db.query('favorites');
      return result;
    } catch (e) {
      throw Error();
    }
  }
}
