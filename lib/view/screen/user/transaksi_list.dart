import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/screen/user/detail_transaksi.dart';
import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final ApiServices apiService = ApiServices();
  late Future<List<ChargeCar>> chargetransaksi;

  @override
  void initState() {
    super.initState();
    chargetransaksi = apiService.getAllTransaksi();
  }

  Future<void> _refresh() async {
    setState(() {
      chargetransaksi = apiService.getAllTransaksi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('My Transaction'),
        ),
        body: FutureBuilder<List<ChargeCar>>(
          future: chargetransaksi,
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
              List<ChargeCar> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailTransaksi(chargetransaksi: data[index]),
                        ),
                      );
                    },
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
                                data[index].chargingstation.image,
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
                                    data[index].chargingstation.nama,
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
                                        Icons.timer,
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          data[index].starttime,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.timer_off,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(data[index].endtime),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color:
                                              data[index].status.toString() ==
                                                      'true'
                                                  ? Colors.green
                                                  : Colors.red[600],
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Add this line
                                        ),
                                        child: Text(
                                          data[index].status.toString() ==
                                                  'true'
                                              ? 'Selesai'
                                              : 'Belum Selesai',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0, // adjust as needed
                                          ),
                                        ),
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
