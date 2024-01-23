import 'package:evchargingpoint/view/screen/admin/edit_chargingstation.dart';
import 'package:flutter/material.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:evchargingpoint/view/auth/login_screen.dart';
import 'package:evchargingpoint/view/screen/admin/add_chargingstation.dart';
import 'package:evchargingpoint/view/screen/user/detail_chargingstation.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final ApiServices apiService = ApiServices();
  late Future<List<ChargingStation>> chargingStations;

  Future<void> _refresh() async {
    setState(() {
      chargingStations = apiService.getAllChargingStation();
    });
  }

  @override
  void initState() {
    super.initState();
    chargingStations = apiService.getAllChargingStation();
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin logout?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () async {
                await AuthManager.logout();
                // ignore: use_build_context_synchronously
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Charging Station'),
          actions: [
            IconButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
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
                                constraints: const BoxConstraints(
                                  minHeight: 95.0,
                                  maxHeight: 95.0,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    data[index].image,
                                    fit: BoxFit.cover,
                                  ),
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
                                  ],
                                ),
                              ),
                            ),
                            // Edit Button
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditChargingStation(
                                          chargingStation: data[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title:
                                              const Text('Konfirmasi Delete'),
                                          content: const Text(
                                              'Anda yakin ingin menghapus data ini?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(dialogContext)
                                                    .pop();
                                              },
                                              child: const Text('Tidak'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await apiService.deleteStation(
                                                    data[index].id.toString());
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(dialogContext)
                                                    .pop();
                                                _refresh();
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddChargingStation(),
              ),
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
