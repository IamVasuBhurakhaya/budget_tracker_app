import 'package:get/get.dart';

class CategoryController extends GetxController {
  int? categoryIndex;

  void changeCategoryIndex({required int index}) {
    categoryIndex = index;
    update();
  }

  void updateCategoryIndex() {
    categoryIndex = null;
    update();
  }

  List<String> categoryImages = [
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
}
