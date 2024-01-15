import 'package:evchargingpoint/model/profile_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({Key? key}) : super(key: key);

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _vehicleNameController;
  late TextEditingController _licensePlateController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with profile data
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _vehicleNameController = TextEditingController();
    _licensePlateController = TextEditingController();

    _fetchProfileData();
  }

  void _fetchProfileData() async {
    try {
      // Mendapatkan email dari manajer otentikasi
      String? email = await AuthManager.getToken();

      if (email != null) {
        // Mengambil data profil berdasarkan email
        Profile profile = (await ApiServices().GetProfile(email)) as Profile;

        // Isi nilai controllers dengan data profil yang diterima
        _fullNameController.text = profile.namalengkap;
        _phoneNumberController.text = profile.nomorhp;
        _vehicleNameController.text = profile.namakendaraan;
        _licensePlateController.text = profile.nomorpolisi;
      }
    } catch (error) {
      // Tangani error, misalnya tampilkan pesan kesalahan
      print('Error fetching profile data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nama Lengkap',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Nomo HP',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _vehicleNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.car_repair),
                    labelText: 'Nama Kendaraan',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _licensePlateController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.car_rental),
                    labelText: 'Nomor Polisi',
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
        ));
  }
}
