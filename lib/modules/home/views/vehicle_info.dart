import 'package:flutter/material.dart';

class VehicleInfoScreen extends StatelessWidget {
  final Map<String, String> vehicle;

  // Constructor to accept vehicle data
  VehicleInfoScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(vehicle["vehicle"] ?? 'Vehicle Info'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Driver History'),
              Tab(text: 'Incident Reports'),
              Tab(text: 'Service History'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Information
              Text(
                "Vehicle: ${vehicle['vehicle']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Driver: ${vehicle['driver']}"),
              Text("Status: ${vehicle['status']}"),
              Text("Location: ${vehicle['location']}"),
              SizedBox(height: 20),

              // Buttons to change driver and status
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _assignDriver(context),
                    child: Text("Assign Driver"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _changeStatus(context),
                    child: Text("Change Status"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Vehicle Tabs
              Expanded(
                child: TabBarView(
                  children: [
                    _buildDriverHistoryTab(),
                    _buildIncidentReportsTab(),
                    _buildServiceHistoryTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Driver History Tab Content
  Widget _buildDriverHistoryTab() {
    return ListView(
      children: [
        ListTile(
          title: Text("Driver 1 - History details"),
          subtitle: Text("Details of driver history..."),
        ),
        ListTile(
          title: Text("Driver 2 - History details"),
          subtitle: Text("Details of driver history..."),
        ),
        // Add more driver history items here
      ],
    );
  }

  // Incident Reports Tab Content
  Widget _buildIncidentReportsTab() {
    return ListView(
      children: [
        ListTile(
          title: Text("Incident 1 - Details"),
          subtitle: Text("Details of the incident..."),
        ),
        ListTile(
          title: Text("Incident 2 - Details"),
          subtitle: Text("Details of the incident..."),
        ),
        // Add more incident reports here
      ],
    );
  }

  // Vehicle Service History Tab Content
  Widget _buildServiceHistoryTab() {
    return ListView(
      children: [
        ListTile(
          title: Text("Service 1 - Details"),
          subtitle: Text("Details of the service..."),
        ),
        ListTile(
          title: Text("Service 2 - Details"),
          subtitle: Text("Details of the service..."),
        ),
        // Add more service history items here
      ],
    );
  }

  // Open a dialog to assign a new driver
  void _assignDriver(BuildContext context) {
    // Sample list of drivers (replace with actual data)
    List<String> drivers = ['Driver 1', 'Driver 2', 'Driver 3'];

    String? selectedDriver = vehicle['Driver 1'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Assign New Driver"),
          content: DropdownButton<String>(
            value: selectedDriver,
            onChanged: (newValue) {
              selectedDriver = newValue!;
            },
            items: drivers.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close dialog without any action
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Update the driver info in the vehicle map
                if (selectedDriver != null) {
                  vehicle["driver"] = selectedDriver!;
                  // Close dialog
                  Navigator.of(context).pop();
                  // Optionally show a confirmation or updated info
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Driver assigned successfully')),
                  );
                }
              },
              child: Text("Assign"),
            ),
          ],
        );
      },
    );
  }

  // Open a dialog to change the vehicle's status
  void _changeStatus(BuildContext context) {
    // Sample list of status options (replace with actual status options)
    List<String> statuses = ['Active', 'In Repair', 'Out of Service', 'Maintenance'];

    String? selectedStatus = vehicle["status"];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Vehicle Status"),
          content: DropdownButton<String>(
            value: selectedStatus,
            onChanged: (newValue) {
              selectedStatus = newValue!;
            },
            items: statuses.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close dialog without any action
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Update the vehicle status
                if (selectedStatus != null) {
                  vehicle["status"] = selectedStatus!;
                  // Close dialog
                  Navigator.of(context).pop();
                  // Optionally show a confirmation or updated info
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Vehicle status updated successfully')),
                  );
                }
              },
              child: Text("Update Status"),
            ),
          ],
        );
      },
    );
  }
}
