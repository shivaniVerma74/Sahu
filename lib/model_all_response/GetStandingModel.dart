/// error : false
/// message : "User report"
/// data : [{"user_id":"420","name":"Ajay","pos":"251917.65","total_leads":"9","bom_bkt":"1","paid":"3.99%","pptp":"3.99%","rb":"0.00%","prb":"0.00%"},{"user_id":"420","name":"Ajay","pos":"29440.79","total_leads":"3","bom_bkt":"2","paid":"0.00%","pptp":"0.00%","rb":"0.00%","prb":"0.00%"},{"user_id":"420","name":"Ajay","pos":"9823.83","total_leads":"1","bom_bkt":"3","paid":"0.00%","pptp":"0.00%","rb":"0.00%","prb":"0.00%"},{"user_id":"420","name":"Ajay","pos":"1043067.0299999999","total_leads":"10","bom_bkt":"X","paid":"15.83%","pptp":"15.83%","rb":"4.24%","prb":"0.00%"}]

class GetStandingModel {
  GetStandingModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetStandingModel.fromJson(dynamic json) {
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
GetStandingModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetStandingModel(  error: error ?? _error,
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
/// pos : "251917.65"
/// total_leads : "9"
/// bom_bkt : "1"
/// paid : "3.99%"
/// pptp : "3.99%"
/// rb : "0.00%"
/// prb : "0.00%"

class Data {
  Data({
      String? userId, 
      String? name, 
      String? pos, 
      String? totalLeads, 
      String? bomBkt, 
      String? paid, 
      String? pptp, 
      String? rb, 
      String? prb,}){
    _userId = userId;
    _name = name;
    _pos = pos;
    _totalLeads = totalLeads;
    _bomBkt = bomBkt;
    _paid = paid;
    _pptp = pptp;
    _rb = rb;
    _prb = prb;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _pos = json['pos'];
    _totalLeads = json['total_leads'];
    _bomBkt = json['bom_bkt'];
    _paid = json['paid'];
    _pptp = json['pptp'];
    _rb = json['rb'];
    _prb = json['prb'];
  }
  String? _userId;
  String? _name;
  String? _pos;
  String? _totalLeads;
  String? _bomBkt;
  String? _paid;
  String? _pptp;
  String? _rb;
  String? _prb;
Data copyWith({  String? userId,
  String? name,
  String? pos,
  String? totalLeads,
  String? bomBkt,
  String? paid,
  String? pptp,
  String? rb,
  String? prb,
}) => Data(  userId: userId ?? _userId,
  name: name ?? _name,
  pos: pos ?? _pos,
  totalLeads: totalLeads ?? _totalLeads,
  bomBkt: bomBkt ?? _bomBkt,
  paid: paid ?? _paid,
  pptp: pptp ?? _pptp,
  rb: rb ?? _rb,
  prb: prb ?? _prb,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get pos => _pos;
  String? get totalLeads => _totalLeads;
  String? get bomBkt => _bomBkt;
  String? get paid => _paid;
  String? get pptp => _pptp;
  String? get rb => _rb;
  String? get prb => _prb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['pos'] = _pos;
    map['total_leads'] = _totalLeads;
    map['bom_bkt'] = _bomBkt;
    map['paid'] = _paid;
    map['pptp'] = _pptp;
    map['rb'] = _rb;
    map['prb'] = _prb;
    return map;
  }

}