import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/widget/bottomNavigationUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailTransaksi extends StatefulWidget {
  final ChargeCar chargetransaksi;
  const DetailTransaksi({super.key, required this.chargetransaksi});

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  late SharedPreferences userdata;
  final _dataservice = ApiServices();

  final _namalengkap = TextEditingController();
  final _nomorhp = TextEditingController();
  final _namakendaraan = TextEditingController();
  final _nomorpolisi = TextEditingController();

  _fetchUserData() async {
    userdata = await SharedPreferences.getInstance();
    setState(() {
      _namalengkap.text = userdata.getString('namalengkap').toString();
      _nomorhp.text = userdata.getString('nomorhp').toString();
      _namakendaraan.text = userdata.getString('namakendaraan').toString();
      _nomorpolisi.text = userdata.getString('nomorpolisi').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _putCharge() async {
    final putData = ChargeCarStatus(
      status: true,
    );

    StatusChargeResponse? res = await _dataservice.putChargeStatus(
      widget.chargetransaksi.id,
      putData,
    );

    if (res != null && res.status == 201) {
      _showSuccessAlert(res.message);
    } else {
      _showErrorAlert(res?.message ?? 'An error occurred');
    }
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavbar(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
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
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: Text(
                        'Pembayaran',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Summary Pembayaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nama'),
                          Text(_namalengkap.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nomor Telepon'),
                          Text(_nomorhp.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Nama Kendaraan'),
                          Text(_namakendaraan.text)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Plat Nomor'),
                          Text(_nomorpolisi.text)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Chargigng Station'),
                          Text(widget.chargetransaksi.chargingstation.nama)
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text('Alamat'),
                      //     Text(widget.chargetransaksi.chargingstation.harga)
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Detail Pembayaran',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Start Charging'),
                          Text(widget.chargetransaksi.starttime),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('End Charging'),
                          Text(widget.chargetransaksi.endtime),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pengisian'),
                          Text(widget.chargetransaksi.totalkwh),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Harga'),
                          Text(widget.chargetransaksi.totalprice),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payment Method'),
                          Text(widget.chargetransaksi.paymentmethod),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Bayar'),
                          Text(widget.chargetransaksi.inputpembayaran),
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 13.0),
          child: ElevatedButton(
            onPressed: _putCharge,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Selesai Charge'),
          ),
        ),
      ),
    );
  }
}
