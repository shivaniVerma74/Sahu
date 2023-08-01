// To parse this JSON data, do
//
//     final bankDetailsModel = bankDetailsModelFromJson(jsonString);

import 'dart:convert';

BankDetailsModel bankDetailsModelFromJson(String str) => BankDetailsModel.fromJson(json.decode(str));

String bankDetailsModelToJson(BankDetailsModel data) => json.encode(data.toJson());

class BankDetailsModel {
  bool error;
  String message;
  List<BankData> data;

  BankDetailsModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) => BankDetailsModel(
    error: json["error"],
    message: json["message"],
    data: List<BankData>.from(json["data"].map((x) => BankData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BankData {
  String bankName;
  String total;

  BankData({
    required this.bankName,
    required this.total,
  });

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    bankName: json["bank_name"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "total": total,
  };
}
