class ChargingStation {
  final String id;
  final String chargingkode;
  final String nama;
  final String alamat;
  final String ammountplugs;
  final String daya;
  final String connector;
  final String harga;
  final String image;
  final String nomortelepon;
  final String jamoperasional;
  final String longitude;
  final String latitude;

  ChargingStation({
    required this.id,
    required this.chargingkode,
    required this.nama,
    required this.alamat,
    required this.ammountplugs,
    required this.daya,
    required this.connector,
    required this.harga,
    required this.image,
    required this.nomortelepon,
    required this.jamoperasional,
    required this.longitude,
    required this.latitude,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      id: json['id'] ?? '',
      chargingkode: json['chargingkode'] ?? '',
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      ammountplugs: json['ammountplugs'] ?? '',
      daya: json['daya'] ?? '',
      connector: json['connector'] ?? '',
      harga: json['harga'] ?? '',
      image: json['image'] ?? '',
      nomortelepon: json['nomortelepon'] ?? '',
      jamoperasional: json['jamoperasional'] ?? '',
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
    );
  }
}

class ChargingStationResponse {
  final List<ChargingStation> data;
  final String message;
  final int status;

  ChargingStationResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  static ChargingStation fromApiResponse(Map<String, dynamic>? apiResponse) {
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

      return ChargingStation(
        id: responseData['id'] ?? '',
        chargingkode: responseData['chargingkode'] ?? '',
        nama: responseData['nama'] ?? '',
        alamat: responseData['alamat'] ?? '',
        ammountplugs: responseData['ammountplugs'] ?? '',
        daya: responseData['daya'] ?? '',
        connector: responseData['connector'] ?? '',
        harga: responseData['harga'] ?? '',
        image: responseData['image'] ?? '',
        nomortelepon: responseData['nomortelepon'] ?? '',
        jamoperasional: responseData['jamoperasional'] ?? '',
        longitude: responseData['longitude'] ?? '',
        latitude: responseData['latitude'] ?? '',
      );
    } else {
      // Handle cases where 'data' key is missing in the response
      throw Exception('Invalid API response format');
    }
  }
}
