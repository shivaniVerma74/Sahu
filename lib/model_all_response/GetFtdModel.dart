/// error : false
/// message : "User report"
/// data : [{"user_id":"420","name":"Ajay","pos":"130,953.89","total_leads":"2"}]

class GetFtdModel {
  GetFtdModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetFtdModel.fromJson(dynamic json) {
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
GetFtdModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetFtdModel(  error: error ?? _error,
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
/// pos : "130,953.89"
/// total_leads : "2"

class Data {
  Data({
      String? userId, 
      String? name, 
      String? pos, 
      String? totalLeads,}){
    _userId = userId;
    _name = name;
    _pos = pos;
    _totalLeads = totalLeads;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _pos = json['pos'];
    _totalLeads = json['total_leads'];
  }
  String? _userId;
  String? _name;
  String? _pos;
  String? _totalLeads;
Data copyWith({  String? userId,
  String? name,
  String? pos,
  String? totalLeads,
}) => Data(  userId: userId ?? _userId,
  name: name ?? _name,
  pos: pos ?? _pos,
  totalLeads: totalLeads ?? _totalLeads,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get pos => _pos;
  String? get totalLeads => _totalLeads;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['pos'] = _pos;
    map['total_leads'] = _totalLeads;
    return map;
  }

}