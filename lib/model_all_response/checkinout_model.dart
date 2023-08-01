// To parse this JSON data, do
//
//     final getUserCheckInOutModel = getUserCheckInOutModelFromJson(jsonString);

import 'dart:convert';

CheckInOutModel getUserCheckInOutModelFromJson(String str) => CheckInOutModel.fromJson(json.decode(str));

String getUserCheckInOutModelToJson(CheckInOutModel data) => json.encode(data.toJson());

class CheckInOutModel {
  CheckOutData data;

  CheckInOutModel({
    required this.data,
  });

  factory CheckInOutModel.fromJson(Map<String, dynamic> json) => CheckInOutModel(
    data: CheckOutData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class CheckOutData {
  String msg;
  bool error;

  CheckOutData({
    required this.msg,
    required this.error,
  });

  factory CheckOutData.fromJson(Map<String, dynamic> json) => CheckOutData(
    msg: json["msg"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "error": error,
  };
}
