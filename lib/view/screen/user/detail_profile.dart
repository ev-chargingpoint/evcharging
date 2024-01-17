import 'dart:io';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _selectedImage;
  String? _image;

  final ApiServices _dataService = ApiServices();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  _fetchUserData() async {
    userdata = await SharedPreferences.getInstance();
    setState(() {
      _image = userdata.getString('image').toString();
      _namalengkap.text = userdata.getString('namalengkap').toString();
      _nomorhp.text = userdata.getString('nomorhp').toString();
      _namakendaraan.text = userdata.getString('namakendaraan').toString();
      _nomorpolisi.text = userdata.getString('nomorpolisi').toString();
    });
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        _image = null;
      }
    });
  }

  void _putProfile() async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        return;
      }

      // final idUser = SharedPreferences.getInstance() {
      //   _idUser = iduser.getString('id');
      // };

      Map<String, dynamic> putData = {
        // 'id': idUser,
        'namalengkap': _namalengkap.text,
        'nomorhp': _nomorhp.text,
        'namakendaraan': _namakendaraan.text,
        'nomorpolisi': _nomorpolisi.text,
        'image': _selectedImage,
      };

      if (_selectedImage == null || !await _selectedImage!.exists()) {
        throw Exception('Image file does not exist');
      }

      print('Updating user profile: $putData');

      Map<String, dynamic> apiResponse = await _dataService.putProfile(
        namalengkap: putData['namalengkap'],
        nomorhp: putData['nomorhp'],
        namakendaraan: putData['namakendaraan'],
        nomorpolisi: putData['nomorpolisi'],
        image: _selectedImage!,
      );

      print('API Response: $apiResponse');

      if (apiResponse['status'] == 200) {
        _showSuccessAlert(
            'Profile updated successfully: ${apiResponse['message']}');
      } else {
        _showErrorAlert('Failed to update profile: ${apiResponse['message']}');
      }
    } catch (error) {
      print('Error updating profile: $error');
      _showErrorAlert('Failed to update profile: $error');
    }
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
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

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
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
        appBar: AppBar(
          title: const Text('Detail Profile'),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://berita.99.co/wp-content/uploads/2023/01/foto-profil-wa-perempuan-aesthetic.jpg',
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
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
                        ),
                      )),
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
                        onPressed: _putProfile,
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
