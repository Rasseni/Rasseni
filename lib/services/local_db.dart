import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static final SqlDb instance = SqlDb._internal(); // Singleton instance
  static Database? _db;

  SqlDb._internal(); // Private constructor

  Future<Database> get db async {
    if (_db == null) {
      _db = await initialDb();
    }
    return _db!;
  }

  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'Rasseni.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
    return mydb;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    // Create `users` table
    batch.execute('''
    CREATE TABLE "users" (
      "id" INTEGER NOT NULL PRIMARY KEY,
      "email" TEXT NOT NULL,
      "firstName" TEXT,
      "lastName" TEXT,
      "profilePic" TEXT
    )
  ''');

    // Create `courses` table
    batch.execute('''
    CREATE TABLE "courses" (
      "id" TEXT PRIMARY KEY,
      "name" TEXT,
      "label" TEXT,
      "image" TEXT
      )
    ''');

    // Create `course_content` table
    batch.execute('''
    CREATE TABLE "course_content" (
      "id" TEXT PRIMARY KEY,
      "course_id" TEXT,
      "title" TEXT,
      "url" TEXT,
      "length" TEXT,
      FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE
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

  //________________________________________________________________________________________

  // Insert Course Data
  Future insertCourse(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }
    return response;
  }

  // Update Course Data
  Future updateCourse(
      String table, Map<String, Object?> values, String courseId) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      table,
      values,
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }
    return response;
  }

  // Delete Course Data
  Future<int> deleteCourse(String courseId) async {
    Database? mydb = await db;
    int response = await mydb!.delete(
      'user_courses',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
    if (response > 0) {
      print("====================== Done =========================");
    } else {
      print("====================== Error =========================");
    }
    return response;
  }
}
