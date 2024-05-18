import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:evchargingpoint/model/chargecar_model.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/model/login_model.dart';
import 'package:evchargingpoint/model/profile_model.dart';
import 'package:evchargingpoint/model/register_model.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final Dio dio = Dio();

  final String _baseUrl = 'https://api-evcharging.vercel.app';

  Future<List<ChargingStation>> getAllChargingStation() async {
    try {
      Response response = await dio.get('$_baseUrl/chargingstation');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
        print('Data: $data');
        final chargingStations =
            data.map((item) => ChargingStation.fromJson(item)).toList();
        return chargingStations;
      }
      return [];
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Failed to get charging station data');
        return [];
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChargeCar>> getAllTransaksi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? $token = prefs.getString('token');

      if ($token == null) {
        throw Exception('User not authenticated');
      }

      Response response = await dio.get(
        '$_baseUrl/chargecar',
        options: Options(
          headers: {
            'Authorization': $token,
          },
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        var decodedData = jsonDecode(response.data);
        if (decodedData != null && decodedData.containsKey('data')) {
          List<dynamic> responseData = decodedData['data'];

          if (responseData != null && responseData.isNotEmpty) {
            final chargeCars =
                responseData.map((item) => ChargeCar.fromJson(item)).toList();
            return chargeCars;
          }
        }
      }
      return []; // Kembalikan list kosong jika tidak ada data
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Failed to get transaction data');
        return [];
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/login',
        data: login.toJson(),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.data));
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return LoginResponse.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterResponse?> register(RegisterInput register) async {
    try {
      final response = await dio.post(
        '$_baseUrl/register',
        data: register.toJson(),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return RegisterResponse.fromJson(jsonDecode(response.data));
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return RegisterResponse.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postChargingStation({
    required String chargingkode,
    required String nama,
    required String alamat,
    required int ammountplugs,
    required String daya,
    required String connector,
    required String harga,
    required String nomortelepon,
    required String jamoperasional,
    required String longitude,
    required String latitude,
    required File image,
  }) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      FormData formData = FormData.fromMap({
        'chargingkode': chargingkode,
        'nama': nama,
        'alamat': alamat,
        'ammountplugs': ammountplugs,
        'daya': daya,
        'connector': connector,
        'harga': harga,
        'nomortelepon': nomortelepon,
        'jamoperasional': jamoperasional,
        'longitude': longitude,
        'latitude': latitude,
        'file': await MultipartFile.fromFile(image.path),
      });

      Response response = await dio.post(
        '$_baseUrl/chargingstation',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': token,
          },
        ),
      );
      return json.decode(response.toString());
    } catch (error) {
      print('Error in postChargingStaion: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> putChargingStation({
    required String id,
    required String chargingkode,
    required String nama,
    required String alamat,
    required int ammountplugs,
    required String daya,
    required String connector,
    required String harga,
    required String nomortelepon,
    required String jamoperasional,
    required String longitude,
    required String latitude,
    required dynamic image,
  }) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      MultipartFile? imageFile;
      if (image is File) {
        imageFile = await MultipartFile.fromFile(image.path);
      } else if (image is String) {
        imageFile = MultipartFile.fromString(image);
      }

      FormData formData = FormData.fromMap({
        'chargingkode': chargingkode,
        'nama': nama,
        'alamat': alamat,
        'ammountplugs': ammountplugs,
        'daya': daya,
        'connector': connector,
        'harga': harga,
        'nomortelepon': nomortelepon,
        'jamoperasional': jamoperasional,
        'longitude': longitude,
        'latitude': latitude,
        'file': imageFile,
      });

      Response response = await dio.put(
        '$_baseUrl/chargingstation?id=$id',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': token,
          },
        ),
      );
      return json.decode(response.toString());
    } catch (error) {
      print('Error in putChargingStation: $error');
      throw error;
    }
  }

  Future deleteStation(String id) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      Response response = await dio.delete(
        '$_baseUrl/chargingstation?id=$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      return json.decode(response.toString());
    } catch (error) {
      print('Error in deleteStation: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> putProfile({
    String id = '',
    required String namalengkap,
    required String nomorhp,
    required String namakendaraan,
    required String nomorpolisi,
    required File image,
  }) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      FormData formData = FormData.fromMap({
        'namalengkap': namalengkap,
        'nomorhp': nomorhp,
        'namakendaraan': namakendaraan,
        'nomorpolisi': nomorpolisi,
        'file': await MultipartFile.fromFile(image.path),
      });

      Response response = await dio.put(
        '$_baseUrl/profile-evcharging?id=$id',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': token,
          },
        ),
      );

      return json.decode(response.toString());
    } catch (error) {
      print('Error in putProfile: $error');
      throw error;
    }
  }

  Future<Profile> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? $token = prefs.getString('token');

      if ($token == null) {
        throw Exception('User not authenticated');
      }

      final response = await dio.get(
        '$_baseUrl/profile',
        options: Options(
          headers: {
            'Authorization': $token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final profile = Profile.fromJson(jsonDecode(response.data)['data']);
        print(response.data);
        print($token);
        return profile;
      } else {
        throw Exception('Failed to load profile');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return Profile.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile> putPassword(
    String text, {
    required String password,
    required String confirmpassword,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? $token = prefs.getString('token');
      // String? token = await AuthManager.getToken();

      if ($token == null) {
        throw Exception('User not authenticated');
      }

      final response = await dio.put(
        '$_baseUrl/profile',
        data: {
          'password': password,
          'confirmpassword': confirmpassword,
        },
        options: Options(
          headers: {
            'Authorization': $token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final profile = Profile.fromJson(jsonDecode(response.data)['data']);
        print(response.data);
        print($token);
        return profile;
      } else {
        throw Exception('Failed to load profile');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 200) {
        debugPrint('Client error - the request cannot be fulfilled');
        return Profile.fromJson(e.response!.data);
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<PostChargeResponse?> postCharge(
      String id, ChargeCarInput charge) async {
    try {
      String? token = await AuthManager.getToken();
      final response = await dio.post(
        '$_baseUrl/chargecar?id=$id',
        data: charge.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      print(response.data);

      if (response.statusCode == 200) {
        return PostChargeResponse.fromJson(jsonDecode(response.data));
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<PutChargeResponse> putCharge(
      String idchargecar, ChargeCarPut charge) async {
    try {
      String? token = await AuthManager.getToken();
      final response = await dio.put(
        '$_baseUrl/chargecar?id=$idchargecar',
        data: charge.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      print(charge.toJson());

      if (response.statusCode == 200) {
        return PutChargeResponse.fromJson(jsonDecode(response.data));
      }

      return PutChargeResponse.fromJson(jsonDecode(response.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<StatusChargeResponse> putChargeStatus(
      String idchargecar, ChargeCarStatus charge) async {
    try {
      String? token = await AuthManager.getToken();
      final response = await dio.put(
        '$_baseUrl/chargecar?id=$idchargecar',
        data: charge.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      print(charge.toJson());

      if (response.statusCode == 200) {
        return StatusChargeResponse.fromJson(jsonDecode(response.data));
      }

      return StatusChargeResponse.fromJson(jsonDecode(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
