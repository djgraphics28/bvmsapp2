// lib/main.dart
import 'package:bvmsapp2/modules/home/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX Demo',
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.routes,
      home: DashboardView(),
    );
  }
}
