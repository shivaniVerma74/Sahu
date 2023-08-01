// To parse this JSON data, do
//
//     final checkInModel = checkInModelFromJson(jsonString);

import 'dart:convert';

CheckInModel checkInModelFromJson(String str) => CheckInModel.fromJson(json.decode(str));

String checkInModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  checkInData data;

  CheckInModel({
    required this.data,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
    data: checkInData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class checkInData {
  String msg;
  bool error;

  checkInData({
    required this.msg,
    required this.error,
  });

  factory checkInData.fromJson(Map<String, dynamic> json) => checkInData(
    msg: json["msg"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "error": error,
  };
}
