class ChargingStationTransaksi {
  final String id;
  final String nama;
  final String alamat;
  final String harga;
  final String image;

  ChargingStationTransaksi({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.harga,
    required this.image,
  });

  factory ChargingStationTransaksi.fromJson(Map<String, dynamic> json) {
    return ChargingStationTransaksi(
      id: json['_id'],
      nama: json['nama'],
      alamat: json['alamat'] ?? '',
      harga: json['harga'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class ChargeCar {
  final String id;
  final String idchargingstation;
  final ChargingStationTransaksi chargingstation;
  final String nama;
  final String alamat;
  final String harga;
  final String image;

  final String iduser;
  final String namalengkap;
  final String nomorhp;
  final String namakendaraan;
  final String nomorpolisi;
  final String email;

  final String tanggal;
  final String starttime;
  final String endtime;
  final String totalkwh;
  final String totalprice;
  final String paymentmethod;
  final String inputpembayaran;
  final bool? payment;
  final bool? status;

  ChargeCar({
    required this.id,
    required this.idchargingstation,
    required this.chargingstation,
    required this.nama,
    required this.alamat,
    required this.harga,
    required this.image,
    required this.iduser,
    required this.namalengkap,
    required this.nomorhp,
    required this.namakendaraan,
    required this.nomorpolisi,
    required this.email,
    required this.tanggal,
    required this.starttime,
    required this.endtime,
    required this.totalkwh,
    required this.totalprice,
    required this.paymentmethod,
    required this.inputpembayaran,
    required this.payment,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "idchargingstation": idchargingstation,
        "nama": nama,
        "alamat": alamat,
        "harga": harga,
        "image": image,
        "iduser": iduser,
        "namalengkap": namalengkap,
        "nomorhp": nomorhp,
        "namakendaraan": namakendaraan,
        "nomorpolisi": nomorpolisi,
        "email": email,
        "tanggal": tanggal,
        "starttime": starttime,
        "endtime": endtime,
        "totalkwh": totalkwh,
        "totalprice": totalprice,
        "paymentmethod": paymentmethod,
        "inputpembayaran": inputpembayaran,
        "payment": payment,
        "status": status,
      };

  factory ChargeCar.fromJson(Map<String, dynamic> json) {
    return ChargeCar(
      id: json['_id'] ?? '',
      idchargingstation: json['idchargingstation'] ?? '',
      chargingstation: json['chargingstation'] != null
          ? ChargingStationTransaksi.fromJson(json['chargingstation'])
          : ChargingStationTransaksi(
              id: '', nama: '', alamat: '', harga: '', image: ''),
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      harga: json['harga'] ?? '',
      image: json['image'] ?? '',
      iduser: json['iduser'] ?? '',
      namalengkap: json['namalengkap'] ?? '',
      nomorhp: json['nomorhp'] ?? '',
      namakendaraan: json['namakendaraan'] ?? '',
      nomorpolisi: json['nomorpolisi'] ?? '',
      email: json['email'] ?? '',
      tanggal: json['tanggal'] ?? '',
      starttime: json['starttime'] ?? '',
      endtime: json['endtime'] ?? '',
      totalkwh: json['totalkwh'] ?? '',
      totalprice: json['totalprice'] ?? '',
      paymentmethod: json['paymentmethod'] ?? '',
      inputpembayaran: json['inputpembayaran'] ?? '',
      payment: json['payment'] ?? false,
      status: json['status'] ?? false,
    );
  }
}

class ChargeCarResponse {
  final List<ChargeCar> data;
  final String message;
  final int status;

  ChargeCarResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  static ChargeCar fromApiResponse(Map<String, dynamic>? apiResponse) {
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

      return ChargeCar(
        id: responseData['_id'] ?? '',
        idchargingstation: responseData['idchargingstation'] ?? '',
        nama: responseData['nama'] ?? '',
        alamat: responseData['alamat'] ?? '',
        harga: responseData['harga'] ?? '',
        image: responseData['image'] ?? '',
        iduser: responseData['iduser'] ?? '',
        namalengkap: responseData['namalengkap'] ?? '',
        nomorhp: responseData['nomorhp'] ?? '',
        namakendaraan: responseData['namakendaraan'] ?? '',
        nomorpolisi: responseData['nomorpolisi'] ?? '',
        email: responseData['email'] ?? '',
        tanggal: responseData['tanggal'] ?? '',
        starttime: responseData['starttime'] ?? '',
        endtime: responseData['endtime'] ?? '',
        totalkwh: responseData['totalkwh'] ?? '',
        totalprice: responseData['totalprice'] ?? '',
        paymentmethod: responseData['paymentmethod'] ?? '',
        inputpembayaran: responseData['inputpembayaran'] ?? '',
        payment: responseData['payment'] ?? false,
        status: responseData['status'] ?? false,
        chargingstation: responseData['chargingstation'] ?? '',
      );
    } else {
      // Handle cases where 'data' key is missing in the response
      throw Exception('Invalid API response format');
    }
  }
  // factory ChargeCarResponse.fromJson(Map<String, dynamic> json) {
  //   return ChargeCarResponse(
  //     data: (json['data'] as List).map((e) => ChargeCar.fromJson(e)).toList(),
  //     message: json['message'],
  //     status: json['status'],
  //   );
  // }
}

class ChargeCarInput {
  final String starttime;
  final String endtime;
  final String totalkwh;
  final String totalprice;

  ChargeCarInput({
    required this.starttime,
    required this.endtime,
    required this.totalkwh,
    required this.totalprice,
  });

  Map<String, dynamic> toJson() => {
        "starttime": starttime,
        "endtime": endtime,
        "totalkwh": totalkwh,
        "totalprice": totalprice,
      };
}

class PostChargeResponse {
  final Map<String, dynamic>? data;
  final String message;
  final int status;

  PostChargeResponse({
    this.data,
    required this.message,
    required this.status,
  });

  factory PostChargeResponse.fromJson(Map<String, dynamic> json) {
    return PostChargeResponse(
      data: json["data"],
      message: json["message"],
      status: json["status"],
    );
  }
}

class ChargeCarPut {
  final String paymentmethod;
  final String inputpembayaran;
  final bool payment;

  ChargeCarPut({
    required this.paymentmethod,
    required this.inputpembayaran,
    required this.payment,
  });

  Map<String, dynamic> toJson() => {
        "paymentmethod": paymentmethod,
        "inputpembayaran": inputpembayaran,
        "payment": payment,
      };
}

class PutChargeResponse {
  final Map<String, dynamic>? data;
  final String message;
  final int status;

  PutChargeResponse({
    this.data,
    required this.message,
    required this.status,
  });

  factory PutChargeResponse.fromJson(Map<String, dynamic> json) {
    return PutChargeResponse(
      data: json["data"],
      message: json["message"],
      status: json["status"],
    );
  }
}

class ChargeCarStatus {
  final bool status;

  ChargeCarStatus({
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class StatusChargeResponse {
  final Map<String, dynamic>? data;
  final String message;
  final int status;

  StatusChargeResponse({
    this.data,
    required this.message,
    required this.status,
  });

  factory StatusChargeResponse.fromJson(Map<String, dynamic> json) {
    return StatusChargeResponse(
      data: json["data"],
      message: json["message"],
      status: json["status"],
    );
  }
}
