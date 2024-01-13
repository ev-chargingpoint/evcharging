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
  String selectedButton = 'More Details';

  Widget buildButton(String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedButton == title
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              width: selectedButton == title ? 4.0 : 1.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              selectedButton = title;
            });
          },
          child: Text(
            title,
            style: TextStyle(
              color: selectedButton == title
                  ? Theme.of(context).primaryColor
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double latitude = double.parse(widget.chargingStation.latitude);
    double longitude = double.parse(widget.chargingStation.longitude);

    final pChargingStation = LatLng(latitude, longitude);
    final pSetView = LatLng(latitude, longitude);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    widget.chargingStation.image,
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
          Container(
            constraints: BoxConstraints.loose(const Size.fromHeight(60.0)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  fontSize: 24.0,
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
                                  Text(widget.chargingStation.chargingkode),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: Colors.brown,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(widget.chargingStation.alamat),
                                  const Spacer(),
                                  const Icon(
                                    Icons.attach_money,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(widget.chargingStation.harga),
                                ],
                              ),
                              const SizedBox(height: 8.0),
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
          const SizedBox(height: 30.0),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('More Details'),
                    buildButton('Map'),
                  ],
                ),
              ],
            ),
          ),
          if (selectedButton == 'More Details')
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chargingStation.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.flash_on,
                            size: 22,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text('Daya Listrik: ${widget.chargingStation.daya}'),
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
                          Text(
                              'Tipe Connector:${widget.chargingStation.connector}'),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.ev_station,
                            size: 22,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              'Jumlah Port Charging:${widget.chargingStation.ammountplugs}'),
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
                              'Jam Operasional: ${widget.chargingStation.jamoperasional}'),
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
                              'Nomor Telepon: ${widget.chargingStation.nomortelepon}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (selectedButton == 'Map')
            Expanded(
              child: SizedBox(
                height: 300.0,
                child: selectedButton == 'Map'
                    ? GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: pSetView, zoom: 14),
                        markers: {
                          Marker(
                            markerId: const MarkerId('marker_chargingstation'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueAzure,
                            ),
                            position: pChargingStation,
                            infoWindow: InfoWindow(
                              title: widget.chargingStation.nama,
                              snippet: widget.chargingStation.alamat,
                            ),
                          ),
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }
}
