// lib/modules/home/views/home_view.dart
import 'package:bvmsapp2/modules/home/views/incident_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_drawer.dart';
import 'dashboard_view.dart';
import 'settings_view.dart';
import 'profile_view.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BVMS App'),
      ),
      drawer: const CustomDrawer(), // Attach Custom Drawer here
      body: Obx(() {
        // Show different screens based on Bottom Navigation index
        switch (controller.currentIndex.value) {
          case 0:
            return DashboardView();
          case 1:
            return IncidentReportView();
          case 2:
            return SettingsView();
          case 3:
            return ProfileView();
          default:
            return DashboardView();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTabIndex,
          backgroundColor: Colors.blueAccent, // Set background color explicitly
          selectedItemColor: Colors.green, // Set color of selected icon/text
          unselectedItemColor: Colors.grey, // Set color of unselected icon/text
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Incident Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
