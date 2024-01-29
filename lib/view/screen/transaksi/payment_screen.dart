import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/widget/bottomNavigationUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  final ChargingStation chargingStation;

  const PaymentScreen({Key? key, required this.chargingStation})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _dataService = ApiServices();
  String selectedPaymentMethod = '';
  final TextEditingController _starttime = TextEditingController();
  final TextEditingController _endtime = TextEditingController();
  final TextEditingController _totalprice = TextEditingController();
  final TextEditingController _totalkwh = TextEditingController();
  final TextEditingController _idchargecar = TextEditingController();

  Future<void> retreiveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _idchargecar.text = prefs.getString('idchargecar') ?? '';
      _starttime.text = prefs.getString('starttime') ?? '';
      _endtime.text = prefs.getString('endtime') ?? '';
      _totalprice.text = prefs.getString('totalprice') ?? '';
      _totalkwh.text = prefs.getString('totalkwh') ?? '';
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

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    retreiveData();
  }

  Future<void> _putAndClearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('idchargecar');
    prefs.remove('starttime');
    prefs.remove('endtime');
    prefs.remove('totalprice');
    prefs.remove('totalkwh');
  }

  void _putCharge() async {
    final putData = ChargeCarPut(
      paymentmethod: selectedPaymentMethod,
      inputpembayaran: _totalprice.text,
      payment: true,
    );

    PutChargeResponse? res = await _dataService.putCharge(
      _idchargecar.text,
      putData,
    );

    if (res != null && res.status == 201) {
      await _putAndClearSharedPreferences();
      _showSuccessAlert(res.message);
    } else {
      _showErrorAlert(res?.message ?? 'An error occurred');
    }
=======
  void _putCharge() async {
    if (selectedPaymentMethod.isEmpty) {
      _showErrorAlert('Pilih metode pembayaran terlebih dahulu');
      return;
    }

    await _savecharge();
    await _savepayment();
    // Buat objek ChargeCarInput
    final putData = ChargeCarPut(
      paymentmethod: selectedPaymentMethod,
      inputpembayaran: _totalprice.text,
      payment: true,
    );

    PutChargeResponse? res = await _dataService.putCharge(
      _idchargecar.text,
      putData,
    );

    if (res != null && res.status == 201) {
      _showSuccessAlert(res.message);
    } else {
      _showErrorAlert(res?.message ?? 'An error occurred');
    }
  }

  Future<void> _savecharge() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('starttime', _starttime.text);
    prefs.setString('endtime', _endtime.text);
    prefs.setString('totalkwh', _totalkwh.text);
    prefs.setString('totalprice', _totalprice.text);
    prefs.setString('idchargecar', _idchargecar.text);
  }

  Future<void> _savepayment() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('paymentmethod', selectedPaymentMethod);
    prefs.setString('inputpembayaran', _totalprice.text);
    prefs.setBool('payment', true);
    prefs.setString('idchargecar', _idchargecar.text);
>>>>>>> 23ea71881fed9fc78acab13351cafbecce55427d
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
<<<<<<< HEAD
                        builder: (context) => const BottomNavbar()),
=======
                        builder: (context) => SummaryPay(
                              chargingStation: widget.chargingStation,
                            )),
>>>>>>> 23ea71881fed9fc78acab13351cafbecce55427d
                    ((route) => false));
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
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      // key: _formKey,
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
            'Pilih Metode Pembayaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            children: [
              buildPaymentOption('Kartu Kredit'),
              buildPaymentOption('Kartu Debit'),
              buildPaymentOption('Transfer Bank'),
              buildPaymentOption('E-Wallet'),
            ],
          ),
          const SizedBox(height: 220),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rp. ${_totalprice.text}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
=======
  void initState() {
    super.initState();
    retreiveData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
          body: Padding(
        // key: _formKey,
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
>>>>>>> 23ea71881fed9fc78acab13351cafbecce55427d
                      onPressed: () {
                        Navigator.pop(context);
                      },
<<<<<<< HEAD
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Bayar'),
=======
                      backgroundColor: Colors.grey,
                      elevation: 0.0,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20.0,
                        color: Colors.white,
                      ),
>>>>>>> 23ea71881fed9fc78acab13351cafbecce55427d
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
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              children: [
                buildPaymentOption('Kartu Kredit'),
                buildPaymentOption('Kartu Debit'),
                buildPaymentOption('Transfer Bank'),
                buildPaymentOption('E-Wallet'),
              ],
            ),
            const SizedBox(height: 200),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rp. ${_totalprice.text}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          selectedPaymentMethod.isEmpty ? null : () => _putCharge();
                          _putCharge();
                        },
                        child: const Text('Bayar'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget buildPaymentOption(String option) {
    return Card(
      child: RadioListTile<String>(
        secondary: const Icon(Icons.credit_card),
        groupValue: selectedPaymentMethod,
        onChanged: (String? value) {
          setState(() {
            selectedPaymentMethod = value!;
          });
        },
        title: Text(option),
        value: option,
      ),
    );
  }
}
