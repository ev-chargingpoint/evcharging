import 'package:flutter/material.dart';

class InputProfileScreen extends StatefulWidget {
  const InputProfileScreen({super.key});

  @override
  State<InputProfileScreen> createState() => _InputProfileScreenState();
}

class _InputProfileScreenState extends State<InputProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'EV Charging Station',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Set your profile',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.person),
              labelText: 'Name',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.phone),
              labelText: 'Phone Number',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.car_repair),
              labelText: 'Car Name',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefixIcon: Icon(Icons.car_rental),
              labelText: 'Police Number',
            ),
          ),
        ),
        const SizedBox(height: 10),      
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text('Let Start', style: TextStyle(fontSize: 18),),
        ),
      ],
    )));
  }
}
