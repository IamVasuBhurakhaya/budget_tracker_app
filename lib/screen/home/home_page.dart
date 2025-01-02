import 'package:budget_tracker_app/components/all_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/category_component.dart';
import '../../components/all_spending.dart';
import '../../components/spend_component.dart';
import '../../controller/navigation_controller.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());
  final PageController pageController = PageController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Budget Tracker',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          controller.changeIndex(index);
        },
        children: const [
          AllSpending(),
          SpendComponent(),
          AllCategory(),
          CategoryComponent(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
            pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.money,
                color: Colors.black54,
              ),
              label: 'All Spending',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
                color: Colors.black54,
              ),
              label: 'Spend',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.black54,
              ),
              label: 'All category',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chart_bar,
                color: Colors.black54,
              ),
              label: 'Category',
            ),
          ],
        );
      }),
    );
  }
}
