import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:evchargingpoint/model/chargingstation_model.dart';
import 'package:evchargingpoint/model/login_model.dart';
import 'package:evchargingpoint/model/register_model.dart';
import 'package:evchargingpoint/service/auth_manager.dart';
import 'package:flutter/material.dart';

class ApiServices {
  final Dio dio = Dio();

  final String _baseUrl =
      'https://asia-southeast2-keamanansistem.cloudfunctions.net';

  Future<List<ChargingStation>> getAllChargingStation() async {
    try {
      Response response = await dio.get('$_baseUrl/chargingstation');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
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

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/login-evcharging',
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
        '$_baseUrl/register-evcharging',
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
    required String ammountplugs,
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

  Future<Map<String, dynamic>> GetProfile(String email) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      Response response = await dio.get(
        '$_baseUrl/profile/email',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': token,
          },
        ),
      );
      return json.decode(response.toString());
    } catch (error) {
      print('Error in GetProfile: $error');
      throw error;
    }
  }

  Future<Map<String, dynamic>> updateProfile(
    String id,
    String namalengkap,
    String nomorhp,
    String namakendaraan,
    String nomorpolisi,
  ) async {
    try {
      String? token = await AuthManager.getToken();

      if (token == null) {
        throw Exception('User not authenticated');
      }

      Response response = await dio.put(
        '$_baseUrl/profile/$id',
        data: {
          'namalengkap': namalengkap,
          'nomorhp': nomorhp,
          'namakendaraan': namakendaraan,
          'nomorpolisi': nomorpolisi,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        ),
      );
      return json.decode(response.toString());
    } catch (error) {
      print('Error in updateProfile: $error');
      throw error;
    }
  }
}
