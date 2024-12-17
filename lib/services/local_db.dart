import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Rasseni.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      // onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE "users" (
      "id" INTEGER NOT NULL PRIMARY KEY,
      "email" TEXT NOT NULL,
      "firstName" TEXT,
      "lastName" TEXT,
      "profilePic" TEXT
    )
  ''');
    await batch.commit();
    print("Create DATABASE AND TABLE ==========================");
  }

  //________________________________________________________________________________________

  //ٌ Read User Data
  Future read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  // Insert User Data
  Future insertUser(Map<String, Object?> values) async {
    Database? mydb = await db;
    values['id'] = 1;
    int response = await mydb!.insert('users', values);
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }
    return response;
  }

  // Update User Data
  Future updateUser(Map<String, Object?> values) async {
    Database? mydb = await db;

    // Check the values before proceeding
    print("Updating user with values: $values");
    int response = await mydb!.update(
      'users',
      values,
      where: 'id = ?',
      whereArgs: [1],
    );

    // Check if the update was successful
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }

    return response;
  }

  // DELETE USER DATA
  Future<int> deleteUser() async {
    Database? mydb = await db;
    int response = await mydb!.delete(
      'users',
      where: 'id = ?',
      whereArgs: [1],
    );
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }
    return response;
  }

  //Delete All Database
  Future<void> deleteMyDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'Rasseni.db');
    await deleteDatabase(path);
    print("delete datebase =============");
  }
}
