//DIGUNAKAN UNTUK FORM INPUT
class RegisterInput {
  final String namalengkap;
  final String nomorhp;
  final String namakendaraan;
  final String nomorpolisi;
  final String email;
  final String password;
  final String confirmpass;

  RegisterInput({
    required this.namalengkap,
    required this.nomorhp,
    required this.namakendaraan,
    required this.nomorpolisi,
    required this.email,
    required this.password,
    required this.confirmpass,
  });

  Map<String, dynamic> toJson() => {
        "namalengkap": namalengkap,
        "nomorhp": nomorhp,
        "namakendaraan": namakendaraan,
        "nomorpolisi": nomorpolisi,
        "email": email,
        "password": password,
        "confirmpass": confirmpass,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class RegisterResponse {
  final String? token;
  final String message;
  final int status;

  RegisterResponse({
    this.token,
    required this.message,
    required this.status,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        token: json["data"] != null ? json["data"]["token"] : null,
        message: json["message"],
        status: json["status"],
      );
}
