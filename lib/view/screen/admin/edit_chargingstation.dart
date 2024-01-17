import 'dart:io';

import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/service/api_sevices.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditChargingStation extends StatefulWidget {
  final ChargingStation chargingStation;
  const EditChargingStation({Key? key, required this.chargingStation})
      : super(key: key);

  @override
  State<EditChargingStation> createState() => _EditChargingStationState();
}

class _EditChargingStationState extends State<EditChargingStation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  late String _imageFile;
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
  final _idCtl = TextEditingController();

  late GoogleMapController _mapController;
  LatLng _selectedLatLng = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() {
    double latitude = double.parse(widget.chargingStation.latitude);
    double longitude = double.parse(widget.chargingStation.longitude);
    _imageFile = widget.chargingStation.image!;
    _idCtl.text = widget.chargingStation.id;
    _namaCtl.text = widget.chargingStation.nama;
    _kodeCtl.text = widget.chargingStation.chargingkode;
    _alamatCtl.text = widget.chargingStation.alamat;
    _nomorCtl.text = widget.chargingStation.nomortelepon;
    _jumlahCtl.text = widget.chargingStation.ammountplugs;
    _dayaCtl.text = widget.chargingStation.daya;
    _tipeCtl.text = widget.chargingStation.connector;
    _hargaCtl.text = widget.chargingStation.harga;
    _jamoperasional.text = widget.chargingStation.jamoperasional;
    _longitudeCtl.text = longitude.toString();
    _latitudeCtl.text = latitude.toString();
    _selectedLatLng = LatLng(latitude, longitude);
  }

  void _putCharging() async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        return;
      }
      ApiServices apiService = ApiServices();

      Map<String, dynamic> putData = {
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
        'image': _selectedImage != null ? _selectedImage! : _imageFile,
      };

      print('Update Charging Station: $putData');

      Map<String, dynamic> apiResponse = await apiService.putChargingStation(
        id: widget.chargingStation.id,
        nama: putData['nama'],
        chargingkode: putData['chargingkode'],
        alamat: putData['alamat'],
        nomortelepon: putData['nomortelepon'],
        ammountplugs: putData['ammountplugs'],
        daya: putData['daya'],
        connector: putData['connector'],
        harga: putData['harga'],
        latitude: putData['latitude'],
        longitude: putData['longitude'],
        jamoperasional: putData['jamoperasional'],
        image: putData['image'],
      );

      print('API Response: $apiResponse');

      if (apiResponse['status'] == 200) {
        _showSuccessAlert(
            'Successfully update Charging Station: ${apiResponse['message']}');
      } else {
        _showErrorAlert(
            'Failed to update Charging Station: ${apiResponse['message']}');
      }
    } catch (error) {
      print('Error update Charging Station: $error');
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

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      } else {
        _selectedImage = null;
      }
    });
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
                    widget.chargingStation.image != null ||
                            _selectedImage != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: _selectedImage != null
                                  ? Image.file(_selectedImage!)
                                  : Image.network(
                                      widget.chargingStation.image!),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('Please select an image'),
                          ),
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
                const SizedBox(height: 5),
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
                          BitmapDescriptor.hueBlue,
                        ),
                      ),
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: ElevatedButton(
            onPressed: _putCharging,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Save'),
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
