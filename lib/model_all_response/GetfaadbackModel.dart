class GetfaadbackModel {
  bool? error;
  String? message;
  List<Data>? data;

  GetfaadbackModel({this.error, this.message, this.data});

  GetfaadbackModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bankName;
  String? agreementid;
  String? customername;
  String? id;
  String? address;
  String? customer;
  String? familyMember;
  String? vechile;
  String? name;
  String? mobile;
  String? userId;
  String? leadId;
  String? image;
  String? code;
  String? codeType;
  String? nextDate;
  String? remark;
  String? occupation;
  String? amount;
  String? latitude;
  String? longitude;
  String? currentAddress;
  String? createdAt;
  String? updatedAt;
  String? username;
  String? bombkt;

  Data(
      {this.bankName,
        this.agreementid,
        this.customername,
        this.id,
        this.address,
        this.customer,
        this.familyMember,
        this.vechile,
        this.name,
        this.mobile,
        this.userId,
        this.leadId,
        this.image,
        this.code,
        this.codeType,
        this.nextDate,
        this.remark,
        this.occupation,
        this.amount,
        this.latitude,
        this.longitude,
        this.currentAddress,
        this.createdAt,
        this.updatedAt,
        this.bombkt,
        this.username});

  Data.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    agreementid = json['agreementid'];
    customername = json['customername'];
    id = json['id'];
    address = json['address'];
    customer = json['customer'];
    familyMember = json['family_member'];
    vechile = json['vechile'];
    name = json['name'];
    mobile = json['mobile'];
    userId = json['user_id'];
    leadId = json['lead_id'];
    image = json['image'];
    code = json['code'];
    codeType = json['code_type'];
    nextDate = json['next_date'];
    remark = json['remark'];
    occupation = json['occupation'];
    amount = json['amount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    currentAddress = json['current_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
    bombkt = json['bom_bkt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['agreementid'] = this.agreementid;
    data['customername'] = this.customername;
    data['id'] = this.id;
    data['address'] = this.address;
    data['customer'] = this.customer;
    data['family_member'] = this.familyMember;
    data['vechile'] = this.vechile;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['user_id'] = this.userId;
    data['lead_id'] = this.leadId;
    data['image'] = this.image;
    data['code'] = this.code;
    data['code_type'] = this.codeType;
    data['next_date'] = this.nextDate;
    data['remark'] = this.remark;
    data['occupation'] = this.occupation;
    data['amount'] = this.amount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['current_address'] = this.currentAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['bom_bkt'] = this.bombkt;
    return data;
  }
}
