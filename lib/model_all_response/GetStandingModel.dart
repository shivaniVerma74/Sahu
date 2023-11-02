/// error : false
/// message : "User report"
/// data : [{"user_id":"498","name":"Mithun Baulia","bank_name":"L&T CL","pos":"3838890.239999999","total_leads":"46","bom_bkt":"1","paid":"1.72%","pptp":"5.37%","rb":"0.00%","prb":"0.00%"},{"user_id":"498","name":"Mithun Baulia","bank_name":"L&T CL","pos":"1238806.8199999998","total_leads":"14","bom_bkt":"2","paid":"2.29%","pptp":"2.29%","rb":"0.00%","prb":"0.00%"},{"user_id":"498","name":"Mithun Baulia","bank_name":"L&T CL","pos":"1057576.34","total_leads":"8","bom_bkt":"3","paid":"0.14%","pptp":"1.00%","rb":"0.00%","prb":"0.00%"},{"user_id":"498","name":"Mithun Baulia","bank_name":"L&T CL","pos":"58056.64","total_leads":"1","bom_bkt":"x","paid":"115.81%","pptp":"619.26%","rb":"0.00%","prb":"0.00%"}]

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

/// user_id : "498"
/// name : "Mithun Baulia"
/// bank_name : "L&T CL"
/// pos : "3838890.239999999"
/// total_leads : "46"
/// bom_bkt : "1"
/// paid : "1.72%"
/// pptp : "5.37%"
/// rb : "0.00%"
/// prb : "0.00%"

class Data {
  Data({
      String? userId, 
      String? name, 
      String? bankName, 
      String? pos, 
      String? totalLeads, 
      String? bomBkt, 
      String? paid, 
      String? pptp, 
      String? rb, 
      String? prb,}){
    _userId = userId;
    _name = name;
    _bankName = bankName;
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
    _bankName = json['bank_name'];
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
  String? _bankName;
  String? _pos;
  String? _totalLeads;
  String? _bomBkt;
  String? _paid;
  String? _pptp;
  String? _rb;
  String? _prb;
Data copyWith({  String? userId,
  String? name,
  String? bankName,
  String? pos,
  String? totalLeads,
  String? bomBkt,
  String? paid,
  String? pptp,
  String? rb,
  String? prb,
}) => Data(  userId: userId ?? _userId,
  name: name ?? _name,
  bankName: bankName ?? _bankName,
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
  String? get bankName => _bankName;
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
    map['bank_name'] = _bankName;
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