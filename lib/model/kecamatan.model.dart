class KecamatanModel {
  bool? status;
  String? message;
  int? code;
  int? total;
  List<Datum>? data;

  KecamatanModel({
    this.status,
    this.message,
    this.code,
    this.total,
    this.data,
  });

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "total": total,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? kabupatenId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Kelurahan>? kelurahan;

  Datum({
    this.id,
    this.kabupatenId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.kelurahan,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        kabupatenId: json["kabupaten_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        kelurahan: List<Kelurahan>.from(
            json["kelurahan"].map((x) => Kelurahan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kabupaten_id": kabupatenId,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "kelurahan": List<dynamic>.from(kelurahan!.map((x) => x.toJson())),
      };
}

class Kelurahan {
  int? id;
  int? kecamatanId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Kelurahan({
    this.id,
    this.kecamatanId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) => Kelurahan(
        id: json["id"],
        kecamatanId: json["kecamatan_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kecamatan_id": kecamatanId,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
