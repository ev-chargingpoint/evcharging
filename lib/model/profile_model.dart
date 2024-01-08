//DIGUNAKAN UNTUK FORM INPUT
class ProfileInput {
  final String namalengkap;
  final String nomorhp;
  final String namakendaraan;
  final String nomorpolisi;

  ProfileInput({
    required this.namalengkap,
    required this.nomorhp,
    required this.namakendaraan,
    required this.nomorpolisi,
  });

  Map<String, dynamic> toJson() => {
        "NamaLengkap": namalengkap,
        "NomorHp": nomorhp,
        "NamaKendaraan": namakendaraan,
        "NomorPolisi": nomorpolisi,
      };
}

//DIGUNAKAN UNTUK RESPONSE
class ProfileResponse {
  final String? insertedId;
  final String message;
  final int status;

  ProfileResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        insertedId: json["inserted_id"],
        message: json["message"],
        status: json["status"],
      );
}