import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TabsExample extends StatelessWidget {
  const TabsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      _details(context),
      _map(context),
    ];
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.cloud), text: 'Tab1'),
      const Tab(icon: Icon(Icons.alarm), text: 'Tab2'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 400.0,
                      maxHeight: 400.0,
                    ),
                    child: Image.network(
                      'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/10/04/Foto-9-4183994205.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 36.0,
                    height: 70.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.grey,
                      elevation: 0.0,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  constraints:
                      BoxConstraints.loose(const Size.fromHeight(60.0)),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: -60.0,
                          left: -8.0,
                          right: -8.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 5.0,
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "widget.chargingStation.nama",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.tag,
                                          size: 20,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                            "widg.chargingStation.chargingkode"),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: Colors.brown,
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                "widget.chargingStation.alamat")),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.monetization_on,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 5),
                                        Text('/kWh'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70.0),
            Container(
              child: TabBar(
                tabs: _kTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _kTabPages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _map(BuildContext context) {
    final LatLng _center = const LatLng(45.521563, -122.677433);

    return SizedBox(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 14),
        markers: {
          Marker(
            markerId: const MarkerId('marker_chargingstation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            position: _center,
            infoWindow: const InfoWindow(
              title: 'Charging Station',
              snippet: 'This is a charging station',
            ),
          ),
        },
      ),
    );
  }

  Widget _details(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Charging Station  :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    size: 22,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Daya Listrik :VA',
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.power,
                    size: 22,
                    color: Colors.brown,
                  ),
                  SizedBox(width: 5),
                  Text('Tipe Connector : '),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.ev_station,
                    size: 22,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 5),
                  Text('Jumlah Port Charging : '),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 22,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text('Jam Operasional  '),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 22,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text('Nomor Telepon  : '),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
