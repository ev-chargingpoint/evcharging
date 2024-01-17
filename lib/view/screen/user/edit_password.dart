import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPass extends StatefulWidget {
  const EditPass({Key? key}) : super(key: key);

  @override
  State<EditPass> createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  late SharedPreferences userdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Password'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: _,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password Lama',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: _nomorhp,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock_reset),
                        labelText: 'Password Baru',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: _namakendaraan,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock_reset),
                        labelText: 'Konfirmasi Password Baru',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Simpan'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
