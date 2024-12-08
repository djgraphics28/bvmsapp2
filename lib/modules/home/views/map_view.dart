import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreen extends StatelessWidget {
  final Map<String, String> vehicle;
  final double latitude;
  final double longitude;

  MapViewScreen({
    required this.vehicle,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Location'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(vehicle["id"] ?? "vehicle_marker"),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: vehicle["name"] ?? "Vehicle",
              snippet: "Latitude: $latitude, Longitude: $longitude",
            ),
          ),
        },
      ),
    );
  }
}
