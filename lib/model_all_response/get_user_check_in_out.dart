// To parse this JSON data, do
//
//     final getUserCheckInOutModel = getUserCheckInOutModelFromJson(jsonString);

import 'dart:convert';

GetUserCheckInOutModel getUserCheckInOutModelFromJson(String str) => GetUserCheckInOutModel.fromJson(json.decode(str));

String getUserCheckInOutModelToJson(GetUserCheckInOutModel data) => json.encode(data.toJson());

class GetUserCheckInOutModel {
  List<Data>? data;
  bool? error;
  String? message;

  GetUserCheckInOutModel({this.data, this.error, this.message});

  GetUserCheckInOutModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  Null? checkinImages;
  Null? checkoutImages;
  String? checkin;
  String? checkout;
  String? date;
  String? checkinLatitude;
  String? checkinLongitude;
  String? checkinAddress;
  String? checkoutLatitude;
  String? checkoutLongitude;
  String? checkoutAddress;
  List<String>? images;

  Data(
      {this.id,
        this.userId,
        this.checkinImages,
        this.checkoutImages,
        this.checkin,
        this.checkout,
        this.date,
        this.checkinLatitude,
        this.checkinLongitude,
        this.checkinAddress,
        this.checkoutLatitude,
        this.checkoutLongitude,
        this.checkoutAddress,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    checkinImages = json['checkin_images'];
    checkoutImages = json['checkout_images'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    date = json['date'];
    checkinLatitude = json['checkin_latitude'];
    checkinLongitude = json['checkin_longitude'];
    checkinAddress = json['checkin_address'];
    checkoutLatitude = json['checkout_latitude'];
    checkoutLongitude = json['checkout_longitude'];
    checkoutAddress = json['checkout_address'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['checkin_images'] = this.checkinImages;
    data['checkout_images'] = this.checkoutImages;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['date'] = this.date;
    data['checkin_latitude'] = this.checkinLatitude;
    data['checkin_longitude'] = this.checkinLongitude;
    data['checkin_address'] = this.checkinAddress;
    data['checkout_latitude'] = this.checkoutLatitude;
    data['checkout_longitude'] = this.checkoutLongitude;
    data['checkout_address'] = this.checkoutAddress;
    data['images'] = this.images;
    return data;
  }
}

