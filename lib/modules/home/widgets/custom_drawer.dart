import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bvmsapp2/modules/home/views/incident_report_view.dart'; // Correctly import your IncidentReportView

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.car_rental,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Barangay VMS App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Dashboard ListTile
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Get.offNamed('/home'); // Navigate to Home (Dashboard)
            },
          ),
          // Incident Report ListTile
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Incident Report'),
            onTap: () {
              Get.to(() => IncidentReportView()); // Correctly use Get.to()
            },
          ),
          // Settings ListTile
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Get.toNamed('/settings'); // Example of navigating to settings
            },
          ),
          // Logout ListTile
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout logic
              Get.offNamed('/login'); // Example for logout navigation
            },
          ),
        ],
      ),
    );
  }
}
