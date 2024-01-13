import 'dart:io';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evchargingpoint/service/api_sevices.dart';

class AddChargingStation extends StatefulWidget {
  const AddChargingStation({super.key});

  @override
  State<AddChargingStation> createState() => _AddChargingStationState();
}

class _AddChargingStationState extends State<AddChargingStation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final _namaCtl = TextEditingController();
  final _kodeCtl = TextEditingController();
  final _alamatCtl = TextEditingController();
  final _nomorCtl = TextEditingController();
  final _jumlahCtl = TextEditingController();
  final _dayaCtl = TextEditingController();
  final _tipeCtl = TextEditingController();
  final _hargaCtl = TextEditingController();
  final _jamoperasional = TextEditingController();
  final _latitudeCtl = TextEditingController();
  final _longitudeCtl = TextEditingController();

  late GoogleMapController _mapController;
  LatLng _selectedLatLng = const LatLng(-6.902269122629447, 107.61873398154628);

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  void _postChargingStation() async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        return;
      }

      ApiServices apiService = ApiServices();

      Map<String, dynamic> postData = {
        'nama': _namaCtl.text,
        'chargingkode': _kodeCtl.text,
        'alamat': _alamatCtl.text,
        'nomortelepon': _nomorCtl.text,
        'ammountplugs': _jumlahCtl.text,
        'daya': _dayaCtl.text,
        'connector': _tipeCtl.text,
        'harga': _hargaCtl.text,
        'jamoperasional': _jamoperasional.text,
        'latitude': _latitudeCtl.text,
        'longitude': _longitudeCtl.text,
        'image': _selectedImage,
      };

      if (_selectedImage == null || !await _selectedImage!.exists()) {
        throw Exception('Image file does not exist');
      }

      print('Posting Charging Station: $postData');

      Map<String, dynamic> apiResponse = await apiService.postChargingStation(
        nama: postData['nama'],
        chargingkode: postData['chargingkode'],
        alamat: postData['alamat'],
        nomortelepon: postData['nomortelepon'],
        ammountplugs: postData['ammountplugs'],
        daya: postData['daya'],
        connector: postData['connector'],
        harga: postData['harga'],
        latitude: postData['latitude'],
        longitude: postData['longitude'],
        jamoperasional: postData['jamoperasional'],
        image: postData['image'],
      );

      print('API Response: $apiResponse');

      if (apiResponse['status'] == 201) {
        _showSuccessAlert(
            'Successfully posted Charging Station: ${apiResponse['message']}');
      } else {
        _showErrorAlert(
            'Failed to post Charging Station: ${apiResponse['message']}');
      }
    } catch (error) {
      print('Error posting Fishing Spot: $error');
      _showErrorAlert('FAIL: $error');
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

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      _selectedLatLng = latLng;
      _latitudeCtl.text = latLng.latitude.toString();
      _longitudeCtl.text = latLng.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 5.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data Charging Station',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _namaCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.ev_station),
                      labelText: 'Nama Charging Station',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _kodeCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.tag),
                      labelText: 'Charging Station Kode',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _alamatCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Alamat',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nomorCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Nomor Telepon',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Spesifikasi',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _jamoperasional,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.access_time),
                      labelText: 'Jam Operasional',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _jumlahCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.settings_input_composite),
                      labelText: 'Jumlah Port Charging',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _dayaCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.flash_on),
                      labelText: 'Daya Listrik (VA)',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _tipeCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.power),
                      labelText: 'Tipe Konektor',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _hargaCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.monetization_on),
                      labelText: 'Harga per kWh (Rp)',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gambar Charging Station',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Choose Image'),
                        ),
                      ),
                    ),
                    _selectedImage != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(_selectedImage!),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                  ],
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lokasi Geografis',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _longitudeCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Longitude (°)',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _latitudeCtl,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      prefixIcon: Icon(Icons.location_on),
                      labelText: 'Latitude (°)',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    onTap: _onMapTap,
                    initialCameraPosition: CameraPosition(
                      target: _selectedLatLng,
                      zoom: 13,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: _selectedLatLng,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: ElevatedButton(
            onPressed: _postChargingStation,
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
}
