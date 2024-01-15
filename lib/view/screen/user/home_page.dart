import 'package:evchargingpoint/service/api_sevices.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home Page'),
      ),
      body: FutureBuilder<List<ChargingStation>>(
        future: ApiServices().getAllChargingStation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // atau widget loading lainnya
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            chargingStations = snapshot.data!;
            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-6.915118116430449, 107.5817586838934),
                zoom: 10,
              ),
              markers: Set<Marker>.from(chargingStations.map((station) {
                return Marker(
                  markerId: MarkerId(station.id.toString()),
                  position: LatLng(double.parse(station.latitude),
                      double.parse(station.longitude)),
                  infoWindow:
                      InfoWindow(title: station.nama, snippet: station.alamat),
                );
              })),
            );
          }
        },
      ),
    );
  }
}
