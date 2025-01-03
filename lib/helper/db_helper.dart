import 'package:budget_tracker_app/model/category_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Database? db;

  String categoryName = "category_name";
  String categoryImage = "category_image";

  String categoryTable = "category";

  Future<void> initDB() async {
    String databasePath = await getDatabasesPath();

    String path = "${databasePath}budget.db";
    db = await openDatabase(path, version: 2, onCreate: (db, _) async {
      String query = '''CREATE TABLE $categoryTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $categoryName TEXT NOT NULL,
          $categoryImage BLOB NOT NULL
        );''';

      await db.execute(query).then(
        (value) {
          print("Category table is created successfully...");
        },
      ).onError(
        (error, _) {
          print(
            "Category table is not created...",
          );
        },
      );
    });
  }

  Future<int?> insertCategory({
    required String name,
    required Uint8List image,
  }) async {
    if (db == null) await initDB();
    String query =
        "INSERT INTO $categoryTable($categoryName, $categoryImage) VALUES(?, ?);";
    List list = [name, image];
    try {
      return await db?.rawInsert(query, list);
    } catch (e) {
      print("Insertion failed: $e");
      return null;
    }
  }

  Future<List<CategoryModel>> getAllData() async {
    await initDB();
    String query = "SELECT * FROM $categoryTable";
    List<Map<String, dynamic>> result = await db?.rawQuery(query) ?? [];
    return result
        .map((Map<String, dynamic> e) => CategoryModel.mapToModel(map: e))
        .toList();
  }

  //Search Category
  Future<List<CategoryModel>> searchCategory({required String search}) async {
    await initDB();
    String query =
        "SELECT * FROM $categoryTable WHERE $categoryName LIKE '%$search%'";
    List<Map<String, dynamic>> result = await db?.rawQuery(query) ?? [];
    return result
        .map((Map<String, dynamic> e) => CategoryModel.mapToModel(map: e))
        .toList();
  }
}
