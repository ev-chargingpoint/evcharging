import 'package:evchargingpoint/model/register_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputProfileScreen extends StatefulWidget {
  const InputProfileScreen({super.key});

  @override
  State<InputProfileScreen> createState() => _InputProfileScreenState();
}

class _InputProfileScreenState extends State<InputProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namalengkap = TextEditingController();
  final _nomorhp = TextEditingController();
  final _namakendaraan = TextEditingController();
  final _nomorpolisi = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpass = TextEditingController();

  final ApiServices _dataService = ApiServices();
  late SharedPreferences accountdata;

  @override
  void dispose() {
    _namalengkap.dispose();
    _nomorhp.dispose();
    _namakendaraan.dispose();
    _nomorpolisi.dispose();
    _email.dispose();
    _password.dispose();
    _confirmpass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _retrieveSharedPreferencesValues();
  }

  Future<void> _retrieveSharedPreferencesValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString('email') ?? '';
      _password.text = prefs.getString('password') ?? '';
      _confirmpass.text = prefs.getString('confirmpass') ?? '';
      print(
        _email.text,
      );
      print(
        _password.text,
      );
      print(
        _confirmpass.text,
      );
    });
  }

  Future<void> _postDataAndClearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('confirmpass');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
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
                  validator: _validateName,
                  controller: _namalengkap,
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
                  validator: _validatePhoneNumber,
                  controller: _nomorhp,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                    hintText: '08********'
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _validateCarName,
                  controller: _namakendaraan,
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
                  validator: _validatePoliceNumber,
                  controller: _nomorpolisi,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValidForm = _formKey.currentState!.validate();
                      if (isValidForm) {
                        final registerModel = RegisterInput(
                            namalengkap: _namalengkap.text,
                            nomorhp: _nomorhp.text,
                            namakendaraan: _namakendaraan.text,
                            nomorpolisi: _nomorpolisi.text,
                            email: _email.text,
                            password: _password.text,
                            confirmpass: _confirmpass.text);
                        RegisterResponse? res =
                            await _dataService.register(registerModel);
                        if (res!.status == 200) {
                          await _postDataAndClearSharedPreferences();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(res.message),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        tooltip: 'Back',
        backgroundColor: Colors.grey,
        mini: true,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }

    // Check if the name has at least two words
    List<String> nameParts = value.split(' ');
    if (nameParts.length < 2) {
      return 'Please enter at least two words for the name';
    }

    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    // Check if the phone number starts with '08' and has 9 to 12 digits
    if (!RegExp(r'^08[0-9]{9,12}$').hasMatch(value)) {
      return 'Invalid phone number';
    }

    return null;
  }

  String? _validateCarName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Car name cannot be empty';
    }

    // Check if the car name has at least 3 characters
    if (value.length < 3) {
      return 'Please enter at least 3 characters for the car name';
    }

    return null;
  }

  String? _validatePoliceNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Police number cannot be empty';
    }

    // // Check if the police number has at least 2 letters followed by numbers and letters
    // if (!RegExp(r'^[a-zA-Z]{2}[0-9]+[a-zA-Z]+$').hasMatch(value)) {
    //   return 'Invalid police number format';
    // }

    return null;
  }
}
