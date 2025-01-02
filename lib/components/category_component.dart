import 'package:budget_tracker_app/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../helper/db_helper.dart';

List<String> categoryImage = [
  "assets/images/category/bill.png",
  "assets/images/category/cash.png",
  "assets/images/category/communication.png",
  "assets/images/category/deposit.png",
  "assets/images/category/food.png",
  "assets/images/category/gift.png",
  "assets/images/category/health.png",
  "assets/images/category/movie.png",
  "assets/images/category/rupee.png",
  "assets/images/category/salary.png",
  "assets/images/category/shopping.png",
  "assets/images/category/transport.png",
  "assets/images/category/wallet.png",
  "assets/images/category/withdraw.png",
  "assets/images/category/other.png",
];

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController categoryController = TextEditingController();

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: categoryController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                labelText: 'Enter Category',
                hintText: 'Enter category',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.redAccent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categoryImage.length,
                itemBuilder: (context, index) {
                  return GetBuilder<CategoryController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          controller.changeCategoryIndex(index: index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(categoryImage[index]),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: controller.categoryIndex == index
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        controller.categoryIndex != null) {
                      String name = categoryController.text;
                      String imagePath =
                          categoryImage[controller.categoryIndex!];
                      ByteData data = await rootBundle.load(imagePath);
                      Uint8List image = data.buffer.asUint8List();

                      int? response = await DBHelper.dbHelper
                          .insertCategory(name: name, image: image);

                      if (response != null) {
                        Get.snackbar(
                          'Category Added',
                          '${categoryController.text} added',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Insertion fail',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please select a category',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                      );
                    }

                    categoryController.clear();
                    controller.updateCategoryIndex();
                  },
                  label: const Text(
                    'Add',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
