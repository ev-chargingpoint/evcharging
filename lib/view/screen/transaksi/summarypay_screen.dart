import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/screen/user/discover_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPay extends StatefulWidget {
  final ChargingStation chargingStation;
  const SummaryPay({super.key, required this.chargingStation});

  @override
  State<SummaryPay> createState() => _SummaryPayState();
}

class _SummaryPayState extends State<SummaryPay> {
  late SharedPreferences userdata;
  final _dataservice = ApiServices();

  final _namalengkap = TextEditingController();
  final _nomorhp = TextEditingController();
  final _namakendaraan = TextEditingController();
  final _nomorpolisi = TextEditingController();

  final TextEditingController _starttime = TextEditingController();
  final TextEditingController _endtime = TextEditingController();
  final TextEditingController _paymentmethod = TextEditingController();
  final TextEditingController _totalprice = TextEditingController();
  final TextEditingController _totalkwh = TextEditingController();
  final TextEditingController _idchargecar = TextEditingController();
  final TextEditingController _inputpembayaran = TextEditingController();

  Future<void> retreiveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _idchargecar.text = prefs.getString('idchargecar') ?? '';
      _starttime.text = prefs.getString('starttime') ?? '';
      _paymentmethod.text = prefs.getString('paymentmethod') ?? '';
      _endtime.text = prefs.getString('endtime') ?? '';
      _totalprice.text = prefs.getString('totalprice') ?? '';
      _totalkwh.text = prefs.getString('totalkwh') ?? '';
      _inputpembayaran.text = prefs.getString('inputpembayaran') ?? '';
      print(
        _idchargecar.text,
      );
      print(
        _starttime.text,
      );
      print(
        _endtime.text,
      );
      print(
        _totalprice.text,
      );
      print(
        _totalkwh.text,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    retreiveData();
  }

  _fetchUserData() async {
    userdata = await SharedPreferences.getInstance();
    setState(() {
      _namalengkap.text = userdata.getString('namalengkap').toString();
      _nomorhp.text = userdata.getString('nomorhp').toString();
      _namakendaraan.text = userdata.getString('namakendaraan').toString();
      _nomorpolisi.text = userdata.getString('nomorpolisi').toString();
    });
  }

  void _putCharge() async {
    final putData = ChargeCarStatus(
      status: true,
    );

    StatusChargeResponse? res = await _dataservice.putChargeStatus(
      _idchargecar.text,
      putData,
    );

    if (res != null && res.status == 201) {
      _showSuccessAlert(res.message);
    } else {
      _showErrorAlert(res?.message ?? 'An error occurred');
    }
  }

  // Future<void> _savepayment() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('paymentmethod', _paymentmethod.text);
  //   prefs.setString('inputpembayaran', _totalprice.text);
  //   prefs.setBool('payment', true);
  //   prefs.setString('idchargecar', _idchargecar.text);
  // }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
               onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const DiscoverPage()),
                    ((route) => false));
              },
              child: Text("OK"),
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
          title: Text("Error"),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
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
                          Text(widget.chargingStation.nama)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Alamat'),
                          Text(widget.chargingStation.alamat)
                        ],
                      ),
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
                          Text(_starttime.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('End Charging'),
                          Text(_endtime.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pengisian'),
                          Text(_totalkwh.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Harga'),
                          Text(_totalprice.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payment Method'),
                          Text(_paymentmethod.text),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Bayar'),
                          Text(_inputpembayaran.text),
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
            child: const Text('Submit'),
          ),
        ),
      ),
    );
  }
}
