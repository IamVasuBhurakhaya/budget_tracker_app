import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (_) {
      Get.offNamed('/home');
    });
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
