import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ChargingStation> chargingStations = [];

  @override
  void initState() {
    super.initState();
    _fetchChargingStations();
  }

  void _fetchChargingStations() async {
    try {
      List<ChargingStation> data = await ApiServices().getAllChargingStation();
      setState(() {
        chargingStations = data;
      });
    } catch (e) {
      print('Failed to fetch charging station data: $e');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  dialogContext,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.915118116430449, 107.5817586838934),
          zoom: 10,
        ),
        markers: Set<Marker>.from(chargingStations.map((station) {
          return Marker(
            markerId: MarkerId(station.id),
            position: LatLng(double.parse(station.latitude),
                double.parse(station.longitude)),
            infoWindow:
                InfoWindow(title: station.nama, snippet: station.alamat),
          );
        })),
      ),
    );
  }
}
