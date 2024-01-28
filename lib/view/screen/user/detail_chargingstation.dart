import 'package:evchargingpoint/view/screen/transaksi/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStationDetailPage extends StatefulWidget {
  final ChargingStation chargingStation;

  const ChargingStationDetailPage({Key? key, required this.chargingStation})
      : super(key: key);

  @override
  _ChargingStationDetailPageState createState() =>
      _ChargingStationDetailPageState();
}

class _ChargingStationDetailPageState extends State<ChargingStationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final kTabPages = <Widget>[
      _details(context),
      _map(context),
    ];
    final kTabs = <Tab>[
      const Tab(text: 'Detail'),
      const Tab(text: 'Map'),
    ];
    return DefaultTabController(
      length: kTabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Hero(
                  tag: 'chargingStationImage${widget.chargingStation.id}',
                  child: ClipRRect(
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
                        widget.chargingStation.image,
                        fit: BoxFit.cover,
                      ),
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
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.chargingStation.nama,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.tag,
                                          size: 20,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(widget
                                            .chargingStation.chargingkode),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: Colors.brown,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                widget.chargingStation.alamat)),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.monetization_on,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${widget.chargingStation.harga}/kWh'),
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
            TabBar(
              tabs: kTabs,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: TabBarView(
                children: kTabPages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _map(BuildContext context) {
    double latitude = double.parse(widget.chargingStation.latitude);
    double longitude = double.parse(widget.chargingStation.longitude);

    final center = LatLng(latitude, longitude);

    return SizedBox(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(target: center, zoom: 14),
        markers: {
          Marker(
            markerId: const MarkerId('marker_chargingstation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            position: center,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Detail Charging Station  :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Icon(
                    Icons.flash_on,
                    size: 22,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Daya Listrik : ${widget.chargingStation.daya} VA',
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.power,
                    size: 22,
                    color: Colors.brown,
                  ),
                  const SizedBox(width: 5),
                  Text('Tipe Connector :  ${widget.chargingStation.connector}'),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.ev_station,
                    size: 22,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      'Jumlah Port Charging : ${widget.chargingStation.ammountplugs}'),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 22,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      'Jam Operasional  :  ${widget.chargingStation.jamoperasional}'),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 22,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      'Nomor Telepon  :  ${widget.chargingStation.nomortelepon} '),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
