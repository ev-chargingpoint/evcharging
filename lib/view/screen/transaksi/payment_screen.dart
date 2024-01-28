import 'package:evchargingpoint/view/screen/transaksi/summarypay_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
                  const Text(
                    'Rp. 100.000',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SummaryPay()),
                        );
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
    ));
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
