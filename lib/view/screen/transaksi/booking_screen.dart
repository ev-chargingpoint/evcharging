import 'dart:math';
import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/screen/transaksi/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingScreen extends StatefulWidget {
  final ChargingStation chargingStation;

  const BookingScreen({Key? key, required this.chargingStation})
      : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiServices _dataService = ApiServices();
  int _kwh = 0;
  final TextEditingController _kwhController = TextEditingController();
  final TextEditingController _totalChargeController = TextEditingController();
  final TextEditingController _startChargeController = TextEditingController();
  final TextEditingController _endChargeController = TextEditingController();

  void _calculateTotalCharge() {
    String kwhString = _kwhController.text.replaceAll(' Kwh', '');
    int convertKwh = int.parse(kwhString);
    int converHarga = int.parse(widget.chargingStation.harga);
    setState(() {
      _totalChargeController.text = "${convertKwh * converHarga}";
    });
  }

  void _calculateStartTime() {
    DateTime startTime = DateTime.now();
    _startChargeController.text = DateFormat('kk:mm').format(startTime);
  }

  void _calculateEndTime() {
    String kwhString = _kwhController.text;
    int convertKwh = int.parse(kwhString);
    int timeInMinutes = (convertKwh * 15) ~/ 10;

    DateTime endTime = DateTime.now().add(Duration(minutes: timeInMinutes));
    _endChargeController.text = DateFormat('kk:mm').format(endTime);
  }

  @override
  void initState() {
    super.initState();
    _kwhController.text = "$_kwh";
    _calculateTotalCharge();
    _calculateStartTime();
    _calculateEndTime();

    _kwhController.addListener(() {
      _calculateTotalCharge();
      _calculateEndTime();
    });
  }

  void _postCharge() async {
    final isValidForm = _formKey.currentState!.validate();
    await _savepayment();
    if (!isValidForm) {
      return;
    }

    // Validasi KWh tidak boleh 0
    if (_kwh == 0) {
      _showErrorAlert('KWh tidak boleh 0');
      return;
    }

    // Buat objek ChargeCarInput
    final postData = ChargeCarInput(
      starttime: _startChargeController.text,
      endtime: _endChargeController.text,
      totalkwh: _kwhController.text,
      totalprice: _totalChargeController.text,
    );

    PostChargeResponse? res = await _dataService.postCharge(
      widget.chargingStation.id,
      postData,
    );

    try {
  if (res != null && res.status == 201) {
    if (res.data != null && res.data!['_id'] != null) {
      await _saveChargeCarId(res.data!['_id']);
    }
    _showSuccessAlert(res.message);
    } else {
    _showErrorAlert(res?.message ?? 'An error occurred');
  }
} catch (e) {
  print('An error occurred: $e');
}
  }

  Future<void> _saveChargeCarId(String chargeCarId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('idchargecar', chargeCarId);
  }

  Future<void> _savepayment() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('starttime', _startChargeController.text);
    prefs.setString('endtime', _endChargeController.text);
    prefs.setString('totalkwh', _kwhController.text);
    prefs.setString('totalprice', _totalChargeController.text);
  }

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
                    MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              chargingStation: widget.chargingStation,
                            )),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                        minHeight: 300.0,
                        maxHeight: 300.0,
                      ),
                      // child: Image.network(
                      //   'https://i.pinimg.com/736x/18/2d/5d/182d5d290f16d4b043651cb83c810b85.jpg',
                      //   fit: BoxFit.cover,
                      // ),
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
              const SizedBox(height: 16.0),
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints.loose(Size.fromHeight(60.0)),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: -90.0,
                            left: -8.0,
                            right: -8.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Form(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Charge Form",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21.0,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _kwh = max(0, _kwh - 10);
                                                    _kwhController.text =
                                                        "$_kwh";
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.withOpacity(
                                                        0.5), // Ganti warna latar belakang sesuai keinginan
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: _kwhController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(60),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _kwh += 10;
                                                    _kwhController.text =
                                                        "$_kwh";
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.withOpacity(
                                                        0.5), // Ganti warna latar belakang sesuai keinginan
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        const Center(
                                          child: Text(
                                            "Total Charge",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _totalChargeController,
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              hintText: "Rp. 0",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Center(
                                          child: Text(
                                            "Start Charge",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _startChargeController,
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              hintText: "12:00",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        const Center(
                                          child: Text(
                                            "End Charge",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _endChargeController,
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              hintText: "13:00",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
              const SizedBox(height: 340.0),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _postCharge();
                    },
                    child: const Text("Bayar"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
