import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({super.key});

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  GoogleMapController? mapController;

  final LatLng startPoint = LatLng(36.8065, 10.1815); // Exemple Tunis

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // ✅ Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: startPoint,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: {
              Marker(
                markerId: MarkerId("bump"),
                position: LatLng(36.8075, 10.1825),
                infoWindow: InfoWindow(title: "Bump"),
              ),
              Marker(
                markerId: MarkerId("pothole"),
                position: LatLng(36.8080, 10.1830),
                infoWindow: InfoWindow(title: "Pothole"),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                color: Colors.blue,
                width: 6,
                points: [
                  LatLng(36.8065, 10.1815),
                  LatLng(36.8070, 10.1820),
                  LatLng(36.8078, 10.1827),
                ],
              ),
            },
          ),

          // ✅ Barre des indicateurs (HAUT)
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoBox("CO₂ Saved", "-10%", Colors.green),
                _infoBox("Hazards", "7", Colors.orange),
                _infoBox("Road Quality", "Poor", Colors.blue),
              ],
            ),
          ),

          // ✅ Barre du bas (infos + bouton GO)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BOUTON GO
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: Text("GO",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),

                  // INFOS
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Speed: 45 km/h",
                          style: TextStyle(color: Colors.white)),
                      Text("CO₂: 275 g/km",
                          style: TextStyle(color: Colors.white)),
                      Text("Distance: 3.2 km",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
