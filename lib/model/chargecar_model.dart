// Get
class ChargeCar {
  final String id;
  final String idchargingstation;
  final String iduser;
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
    required this.iduser,
    required this.tanggal,
    required this.starttime,
    required this.endtime,
    required this.totalkwh,
    required this.totalprice,
    required this.paymentmethod,
    required this.inputpembayaran,
    this.payment,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "idchargingstation": idchargingstation,
        "iduser": iduser,
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
      iduser: json['iduser'] ?? '',
      tanggal: json['tanggal'] ?? '',
      starttime: json['starttime'] ?? '',
      endtime: json['endtime'] ?? '',
      totalkwh: json['totalkwh'] ?? '',
      totalprice: json['totalprice'] ?? '',
      paymentmethod: json['paymentmethod'] ?? '',
      inputpembayaran: json['inputpembayaran'] ?? '',
      payment: json['payment'] ?? '',
      status: json['status'] ?? '',
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

  factory ChargeCarResponse.fromJson(Map<String, dynamic> json) {
    return ChargeCarResponse(
      data: json['data'].map((e) => ChargeCar.fromJson(e)).toList(),
      message: json['message'],
      status: json['status'],
    );
  }
}

// POST CHARGE CAR
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

//Status
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


