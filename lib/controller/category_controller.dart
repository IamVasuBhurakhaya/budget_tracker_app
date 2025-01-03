import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;
  Future<List<CategoryModel>>? categoryList;

  void changeCategoryIndex({required int index}) {
    categoryIndex = index;
    update();
  }

  void updateCategoryIndex() {
    categoryIndex = null;
    update();
  }

  Future<void> saveCategory(
      {required String name, required Uint8List image}) async {
    int? res = await DBHelper.dbHelper.insertCategory(name: name, image: image);
    if (res != null) {
      Get.snackbar('Category Added', ' $name added successfully',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Insertion failed',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  void getCategoryData() async {
    categoryList = DBHelper.dbHelper.getAllData();
    update();
  }

  void searchCategory({required String search}) async {
    categoryList = DBHelper.dbHelper.searchCategory(search: search);
    print("==================$categoryList");
    update();
  }
}
