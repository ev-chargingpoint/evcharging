import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/screen/user/detail_chargingstation.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool showMap = false;
  final ApiServices apiService = ApiServices();
  late Future<List<ChargingStation>> chargingStations;

  @override
  void initState() {
    super.initState();
    chargingStations = apiService.getAllChargingStation();
  }

  Future<void> _refresh() async {
    setState(() {
      chargingStations = apiService.getAllChargingStation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Charging Station'),
        ),
        body: FutureBuilder<List<ChargingStation>>(
          future: chargingStations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              List<ChargingStation> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChargingStationDetailPage(
                              chargingStation: data[index]),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'chargingStationImage${data[index].id}',
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              child: Container(
                                height: 130.0,
                                width: 130.0,
                                child: Image.network(
                                  data[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data[index].nama,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Icon(
                                          Icons.location_on,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            data[index].alamat,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.flash_on,
                                          size: 20,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(data[index].daya),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: data[index].available > 0
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              const Text(
                                                'Plugs:',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '${data[index].available}/${data[index].ammountplugs}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.attach_money,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          '${data[index].harga}/kWh',
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
