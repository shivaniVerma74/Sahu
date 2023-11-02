/// error : false
/// message : "All Feedback data !!"
/// data : [{"bank_name":"L&T CL","agreementid":"C021100401020303","customername":"KOHINUR  MONDAL","id":"106","address":"Avaliable","customer":"Not Avaliable","family_member":"Not Avaliable","vechile":"thirdparty","name":null,"mobile":null,"user_id":"498","lead_id":"10459","image":"https://alphawizzserver.com/sahu/uploads/feedback_image/1698244323_6d505d87-76c4-4f9a-a32e-7af871f7ef381004425600696824397.jpg","code":"NORM","code_type":"ONLINE","next_date":"2023-10-27","remark":"vjjhcjcchch","occupation":"","amount":"","created_at":"2023-10-25 20:02:03","updated_at":"2023-10-25 20:02:03","username":"Mithun Baulia"},{"bank_name":"L&T CL","agreementid":"C021100401020303","customername":"KOHINUR  MONDAL","id":"105","address":"Avaliable","customer":"Avaliable","family_member":"Not Avaliable","vechile":"thiredparty","name":"Testing","mobile":"Nregavs","user_id":"498","lead_id":"10459","image":"https://alphawizzserver.com/sahu/uploads/feedback_image/1698240773_27f04a41-b5a7-4640-bf72-53227f5491d87628835913135337625.jpg","code":"NORM","code_type":"CASH","next_date":"2023-10-28","remark":"New Remark","occupation":"","amount":"","created_at":"2023-10-25 19:02:53","updated_at":"2023-10-25 19:02:53","username":"Mithun Baulia"},{"bank_name":"L&T CL","agreementid":"C021100401020303","customername":"KOHINUR  MONDAL","id":"104","address":"Avaliable","customer":"Avaliable","family_member":"Not Avaliable","vechile":"thiredparty","name":"New Name","mobile":"newwww","user_id":"498","lead_id":"10459","image":"https://alphawizzserver.com/sahu/uploads/feedback_image/1698236035_b2c68727-a9d3-458b-92bb-1f5d7fa06e6d6119131356919777938.jpg","code":"BKT","code_type":null,"next_date":"2023-10-27","remark":"cycgchchchh","occupation":"","amount":"","created_at":"2023-10-25 17:43:55","updated_at":"2023-10-25 17:43:55","username":"Mithun Baulia"},{"bank_name":"L&T CL","agreementid":"C021100401020303","customername":"KOHINUR  MONDAL","id":"103","address":"Avaliable","customer":"Avaliable","family_member":"Not Avaliable","vechile":"Not Avaliable","name":null,"mobile":null,"user_id":"498","lead_id":"10459","image":"https://alphawizzserver.com/sahu/uploads/feedback_image/1698217676_e14d3091-2569-4c98-9d31-d9fb81f543e43085564278008590077.jpg","code":"RTP","code_type":null,"next_date":"2023-10-25","remark":"neeewww","occupation":"","amount":"","created_at":"2023-10-25 12:37:56","updated_at":"2023-10-25 12:37:56","username":"Mithun Baulia"}]

class GetfaadbackModel {
  GetfaadbackModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetfaadbackModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetfaadbackModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetfaadbackModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// bank_name : "L&T CL"
/// agreementid : "C021100401020303"
/// customername : "KOHINUR  MONDAL"
/// id : "106"
/// address : "Avaliable"
/// customer : "Not Avaliable"
/// family_member : "Not Avaliable"
/// vechile : "thirdparty"
/// name : null
/// mobile : null
/// user_id : "498"
/// lead_id : "10459"
/// image : "https://alphawizzserver.com/sahu/uploads/feedback_image/1698244323_6d505d87-76c4-4f9a-a32e-7af871f7ef381004425600696824397.jpg"
/// code : "NORM"
/// code_type : "ONLINE"
/// next_date : "2023-10-27"
/// remark : "vjjhcjcchch"
/// occupation : ""
/// amount : ""
/// created_at : "2023-10-25 20:02:03"
/// updated_at : "2023-10-25 20:02:03"
/// username : "Mithun Baulia"

class Data {
  Data({
      String? bankName, 
      String? agreementid, 
      String? customername, 
      String? id, 
      String? address, 
      String? customer, 
      String? familyMember, 
      String? vechile, 
      dynamic name, 
      dynamic mobile, 
      String? userId, 
      String? leadId, 
      String? image, 
      String? code, 
      String? codeType, 
      String? nextDate, 
      String? remark, 
      String? occupation, 
      String? amount, 
      String? createdAt, 
      String? updatedAt, 
      String? username,}){
    _bankName = bankName;
    _agreementid = agreementid;
    _customername = customername;
    _id = id;
    _address = address;
    _customer = customer;
    _familyMember = familyMember;
    _vechile = vechile;
    _name = name;
    _mobile = mobile;
    _userId = userId;
    _leadId = leadId;
    _image = image;
    _code = code;
    _codeType = codeType;
    _nextDate = nextDate;
    _remark = remark;
    _occupation = occupation;
    _amount = amount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _username = username;
}

  Data.fromJson(dynamic json) {
    _bankName = json['bank_name'];
    _agreementid = json['agreementid'];
    _customername = json['customername'];
    _id = json['id'];
    _address = json['address'];
    _customer = json['customer'];
    _familyMember = json['family_member'];
    _vechile = json['vechile'];
    _name = json['name'];
    _mobile = json['mobile'];
    _userId = json['user_id'];
    _leadId = json['lead_id'];
    _image = json['image'];
    _code = json['code'];
    _codeType = json['code_type'];
    _nextDate = json['next_date'];
    _remark = json['remark'];
    _occupation = json['occupation'];
    _amount = json['amount'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _username = json['username'];
  }
  String? _bankName;
  String? _agreementid;
  String? _customername;
  String? _id;
  String? _address;
  String? _customer;
  String? _familyMember;
  String? _vechile;
  dynamic _name;
  dynamic _mobile;
  String? _userId;
  String? _leadId;
  String? _image;
  String? _code;
  String? _codeType;
  String? _nextDate;
  String? _remark;
  String? _occupation;
  String? _amount;
  String? _createdAt;
  String? _updatedAt;
  String? _username;
Data copyWith({  String? bankName,
  String? agreementid,
  String? customername,
  String? id,
  String? address,
  String? customer,
  String? familyMember,
  String? vechile,
  dynamic name,
  dynamic mobile,
  String? userId,
  String? leadId,
  String? image,
  String? code,
  String? codeType,
  String? nextDate,
  String? remark,
  String? occupation,
  String? amount,
  String? createdAt,
  String? updatedAt,
  String? username,
}) => Data(  bankName: bankName ?? _bankName,
  agreementid: agreementid ?? _agreementid,
  customername: customername ?? _customername,
  id: id ?? _id,
  address: address ?? _address,
  customer: customer ?? _customer,
  familyMember: familyMember ?? _familyMember,
  vechile: vechile ?? _vechile,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  userId: userId ?? _userId,
  leadId: leadId ?? _leadId,
  image: image ?? _image,
  code: code ?? _code,
  codeType: codeType ?? _codeType,
  nextDate: nextDate ?? _nextDate,
  remark: remark ?? _remark,
  occupation: occupation ?? _occupation,
  amount: amount ?? _amount,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  username: username ?? _username,
);
  String? get bankName => _bankName;
  String? get agreementid => _agreementid;
  String? get customername => _customername;
  String? get id => _id;
  String? get address => _address;
  String? get customer => _customer;
  String? get familyMember => _familyMember;
  String? get vechile => _vechile;
  dynamic get name => _name;
  dynamic get mobile => _mobile;
  String? get userId => _userId;
  String? get leadId => _leadId;
  String? get image => _image;
  String? get code => _code;
  String? get codeType => _codeType;
  String? get nextDate => _nextDate;
  String? get remark => _remark;
  String? get occupation => _occupation;
  String? get amount => _amount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank_name'] = _bankName;
    map['agreementid'] = _agreementid;
    map['customername'] = _customername;
    map['id'] = _id;
    map['address'] = _address;
    map['customer'] = _customer;
    map['family_member'] = _familyMember;
    map['vechile'] = _vechile;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['user_id'] = _userId;
    map['lead_id'] = _leadId;
    map['image'] = _image;
    map['code'] = _code;
    map['code_type'] = _codeType;
    map['next_date'] = _nextDate;
    map['remark'] = _remark;
    map['occupation'] = _occupation;
    map['amount'] = _amount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['username'] = _username;
    return map;
  }

}