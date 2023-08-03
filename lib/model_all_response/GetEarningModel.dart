/// error : false
/// message : "User Monthly Earnings"
/// data : [{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"251917.65","total_amount":"26253","total_leads":"9","bom_bkt":"1","earning_percent":"2","month":"August","earning_amount":"525.06"},{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"29440.79","total_amount":"8535","total_leads":"3","bom_bkt":"2","earning_percent":"0","month":"August","earning_amount":"0.00"},{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"9823.83","total_amount":"2576","total_leads":"1","bom_bkt":"3","earning_percent":"0","month":"August","earning_amount":"0.00"},{"user_id":"420","name":"Ajay","bank_name":"X SELL","pos":"1043067.0299999999","total_amount":"48185","total_leads":"10","bom_bkt":"X","earning_percent":"5","month":"August","earning_amount":"2,409.25"}]

class GetEarningModel {
  GetEarningModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetEarningModel.fromJson(dynamic json) {
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
GetEarningModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetEarningModel(  error: error ?? _error,
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

/// user_id : "420"
/// name : "Ajay"
/// bank_name : "L&T TW WHEELER"
/// pos : "251917.65"
/// total_amount : "26253"
/// total_leads : "9"
/// bom_bkt : "1"
/// earning_percent : "2"
/// month : "August"
/// earning_amount : "525.06"

class Data {
  Data({
      String? userId, 
      String? name, 
      String? bankName, 
      String? pos, 
      String? totalAmount, 
      String? totalLeads, 
      String? bomBkt, 
      String? earningPercent, 
      String? month, 
      String? earningAmount,}){
    _userId = userId;
    _name = name;
    _bankName = bankName;
    _pos = pos;
    _totalAmount = totalAmount;
    _totalLeads = totalLeads;
    _bomBkt = bomBkt;
    _earningPercent = earningPercent;
    _month = month;
    _earningAmount = earningAmount;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _bankName = json['bank_name'];
    _pos = json['pos'];
    _totalAmount = json['total_amount'];
    _totalLeads = json['total_leads'];
    _bomBkt = json['bom_bkt'];
    _earningPercent = json['earning_percent'];
    _month = json['month'];
    _earningAmount = json['earning_amount'];
  }
  String? _userId;
  String? _name;
  String? _bankName;
  String? _pos;
  String? _totalAmount;
  String? _totalLeads;
  String? _bomBkt;
  String? _earningPercent;
  String? _month;
  String? _earningAmount;
Data copyWith({  String? userId,
  String? name,
  String? bankName,
  String? pos,
  String? totalAmount,
  String? totalLeads,
  String? bomBkt,
  String? earningPercent,
  String? month,
  String? earningAmount,
}) => Data(  userId: userId ?? _userId,
  name: name ?? _name,
  bankName: bankName ?? _bankName,
  pos: pos ?? _pos,
  totalAmount: totalAmount ?? _totalAmount,
  totalLeads: totalLeads ?? _totalLeads,
  bomBkt: bomBkt ?? _bomBkt,
  earningPercent: earningPercent ?? _earningPercent,
  month: month ?? _month,
  earningAmount: earningAmount ?? _earningAmount,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get bankName => _bankName;
  String? get pos => _pos;
  String? get totalAmount => _totalAmount;
  String? get totalLeads => _totalLeads;
  String? get bomBkt => _bomBkt;
  String? get earningPercent => _earningPercent;
  String? get month => _month;
  String? get earningAmount => _earningAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['bank_name'] = _bankName;
    map['pos'] = _pos;
    map['total_amount'] = _totalAmount;
    map['total_leads'] = _totalLeads;
    map['bom_bkt'] = _bomBkt;
    map['earning_percent'] = _earningPercent;
    map['month'] = _month;
    map['earning_amount'] = _earningAmount;
    return map;
  }

}