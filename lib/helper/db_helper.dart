import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Database? db;

  // Category Table Attributes
  String categoryTable = "category";
  String categoryName = "category_name";
  String categoryImage = "category_image";

  // Spending Table Attributes
  String spendingTable = "spending";
  String spendingDesc = "spending_desc";
  String spendingAmount = "spending_amount";
  String spendingMode = "spending_mode";
  String spendingDate = "spending_date";
  String spendingTime = "spending_time";
  String spendingCategoryId = "spending_category_id";

  // TODO: Create Database
  Future<void> initDB() async {
    String databasePath = await getDatabasesPath();

    String path = "${databasePath}budget.db";
    // TODO: Create Tables
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
}
