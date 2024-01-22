import 'package:evchargingpoint/view/screen/user/detail_chargingstation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ChargingStation> chargingStations = [];
  ChargingStation? selectedStation;

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

  void _navigateToDetailPage(ChargingStation station) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChargingStationDetailPage(chargingStation: station),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home Page'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-6.915118116430449, 107.5817586838934),
              zoom: 10,
            ),
            markers: Set<Marker>.from(chargingStations.map((station) {
              return Marker(
                markerId: MarkerId(station.id.toString()),
                position: LatLng(
                  double.parse(station.latitude),
                  double.parse(station.longitude),
                ),
                onTap: () {
                  setState(() {
                    selectedStation = station;
                  });
                },
              );
            })),
          ),
          if (selectedStation != null)
            Positioned(
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
              child: GestureDetector(
                onTap: () {
                  _navigateToDetailPage(
                      selectedStation!); // Added navigation on card tap
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10.0)),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(
                              selectedStation!.image,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedStation = null;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            selectedStation!.nama,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Expanded(
                                    child: Text(
                                      selectedStation!.alamat,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.power,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  Text(selectedStation!.connector),
                                  const Spacer(),
                                  const Icon(
                                    Icons.attach_money,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    selectedStation!.harga,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
