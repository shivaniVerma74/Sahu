/// error : false
/// message : "User report"
/// data : [{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"241,861.61","total_leads":"8","bom_bkt":"Bucket 1","count_day_wise":8,"pos_day_wise":"241,861.00"},{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"29,440.79","total_leads":"3","bom_bkt":"Bucket 2","count_day_wise":3,"pos_day_wise":"29,440.00"},{"user_id":"420","name":"Ajay","bank_name":"L&T TW WHEELER","pos":"9,823.83","total_leads":"1","bom_bkt":"Bucket 3","count_day_wise":1,"pos_day_wise":"9,823.00"},{"user_id":"420","name":"Ajay","bank_name":"X SELL","pos":"877,985.80","total_leads":"8","bom_bkt":"Bucket X","count_day_wise":8,"pos_day_wise":"877,985.00"}]

class GetReportModel {
  GetReportModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetReportModel.fromJson(dynamic json) {
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
GetReportModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetReportModel(  error: error ?? _error,
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
/// pos : "241,861.61"
/// total_leads : "8"
/// bom_bkt : "Bucket 1"
/// count_day_wise : 8
/// pos_day_wise : "241,861.00"

class Data {
  Data({
      String? userId, 
      String? name, 
      String? bankName, 
      String? pos, 
      String? totalLeads, 
      String? bomBkt, 
      num? countDayWise, 
      String? posDayWise,}){
    _userId = userId;
    _name = name;
    _bankName = bankName;
    _pos = pos;
    _totalLeads = totalLeads;
    _bomBkt = bomBkt;
    _countDayWise = countDayWise;
    _posDayWise = posDayWise;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _bankName = json['bank_name'];
    _pos = json['pos'];
    _totalLeads = json['total_leads'];
    _bomBkt = json['bom_bkt'];
    _countDayWise = json['count_day_wise'];
    _posDayWise = json['pos_day_wise'];
  }
  String? _userId;
  String? _name;
  String? _bankName;
  String? _pos;
  String? _totalLeads;
  String? _bomBkt;
  num? _countDayWise;
  String? _posDayWise;
Data copyWith({  String? userId,
  String? name,
  String? bankName,
  String? pos,
  String? totalLeads,
  String? bomBkt,
  num? countDayWise,
  String? posDayWise,
}) => Data(  userId: userId ?? _userId,
  name: name ?? _name,
  bankName: bankName ?? _bankName,
  pos: pos ?? _pos,
  totalLeads: totalLeads ?? _totalLeads,
  bomBkt: bomBkt ?? _bomBkt,
  countDayWise: countDayWise ?? _countDayWise,
  posDayWise: posDayWise ?? _posDayWise,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get bankName => _bankName;
  String? get pos => _pos;
  String? get totalLeads => _totalLeads;
  String? get bomBkt => _bomBkt;
  num? get countDayWise => _countDayWise;
  String? get posDayWise => _posDayWise;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['bank_name'] = _bankName;
    map['pos'] = _pos;
    map['total_leads'] = _totalLeads;
    map['bom_bkt'] = _bomBkt;
    map['count_day_wise'] = _countDayWise;
    map['pos_day_wise'] = _posDayWise;
    return map;
  }

}