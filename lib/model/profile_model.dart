class Profile{
  final String id;
  final String namalengkap;
  final String nomorhp;
  final String namakendaraan;
  final String nomorpolisi;
  final String email;
  final String password;
  final String confirmpassword;

  Profile({
    required this.id,
    required this.namalengkap,
    required this.nomorhp,
    required this.namakendaraan,
    required this.nomorpolisi,
    required this.email,
    required this.password,
    required this.confirmpassword,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '',
      namalengkap: json['nama_lengkap'] ?? '',
      nomorhp: json['nomorhp'] ?? '',
      namakendaraan: json['namakendaraan'] ?? '',
      nomorpolisi: json['nomorpolisi'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      confirmpassword: json['confirmpassword'] ?? '',
    );
  }
}

class ProfileResponse {
  final List<ProfileResponse> data;
  final String message;
  final int status;

  ProfileResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  static Profile fromApiResponse(Map<String, dynamic>? apiResponse) {
    if (apiResponse == null) {
      // Handle null response gracefully, throw an exception or return a default instance
      throw Exception('Null API response');
    }

    if (apiResponse.containsKey('status') &&
        apiResponse.containsKey('message')) {
      // Extract error details from the response
      int status = apiResponse['status'];
      String message = apiResponse['message'];

      // Handle specific error scenarios
      if (status == 400 &&
          message.contains('invalid number of message parts in token')) {
        throw Exception('Invalid number of message parts in token');
      } else {
        // Handle other error scenarios
        throw Exception('API error: Status $status, Message: $message');
      }
    } else if (apiResponse.containsKey('data')) {
      // Extract data from the response
      var responseData = apiResponse['data'];

      return Profile(
        id: responseData['id'] ?? '',
        namalengkap: responseData['nama_lengkap'] ?? '',
        nomorhp: responseData['nomorhp'] ?? '',
        namakendaraan: responseData['namakendaraan'] ?? '',
        nomorpolisi: responseData['nomorpolisi'] ?? '',
        email: responseData['email'] ?? '',
        password: responseData['password'] ?? '',
        confirmpassword: responseData['confirmpassword'] ?? '',
      );
    } else {
      // Handle cases where 'data' key is missing in the response
      throw Exception('Invalid API response format');
    }
  }
}
