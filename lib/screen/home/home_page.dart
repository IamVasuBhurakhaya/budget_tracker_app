import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/category_component.dart';
import '../../components/home_component.dart';
import '../../components/spend_component.dart';
import '../../controller/navigation_controller.dart';

class HomePage extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());
  final PageController pageController = PageController();

  HomePage({super.key});

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
          HomeComponent(),
          CategoryComponent(),
          SpendComponent(),
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
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar_alt_fill),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Spend',
            ),
          ],
        );
      }),
    );
  }
}