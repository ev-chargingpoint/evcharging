import 'package:dio/dio.dart';
import 'package:evchargingpoint/model/login_model.dart';
import 'package:evchargingpoint/model/profile_model.dart';
import 'package:flutter/material.dart';

class ApiServices {
  final Dio dio = Dio();
  final String _baseUrl =
      "https://asia-southeast2-keamanansistem.cloudfunctions.net";

  Future<LoginResponse?> login(LoginInput login) async {
    try {
      final response = await dio.post(
        '$_baseUrl/login-evcharging',
        data: login.toJson(), 
        );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
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

  Future<ProfileResponse?> postProfile(ProfileInput ct) async {
    try {
      final response = await dio.post(
        '$_baseUrl/contact-evcharging',
        data: ct.toJson(),
      );
      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
