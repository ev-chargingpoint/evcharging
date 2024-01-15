import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({Key? key}) : super(key: key);

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  late SharedPreferences userdata;

  final _formKey = GlobalKey<FormState>();
  final _namalengkap = TextEditingController();
  final _nomorhp = TextEditingController();
  final _namakendaraan = TextEditingController();
  final _nomorpolisi = TextEditingController();

  final ApiServices _dataService = ApiServices();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    userdata = await SharedPreferences.getInstance();
    setState(() {
      _namalengkap.text = userdata.getString('namalengkap').toString();
      _nomorhp.text = userdata.getString('nomorhp').toString();
      _namakendaraan.text = userdata.getString('namakendaraan').toString();
      _nomorpolisi.text = userdata.getString('nomorpolisi').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Profile'),
        ),
        body: Center(
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://berita.99.co/wp-content/uploads/2023/01/foto-profil-wa-perempuan-aesthetic.jpg'),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                  ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _namalengkap,
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
                    controller: _nomorhp,
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
                    controller: _namakendaraan,
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
                    controller: _nomorpolisi,
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
          ),
        ));
  }
}
