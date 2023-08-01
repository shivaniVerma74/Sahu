/// error : false
/// message : "All Leads"
/// data : {"total":"10","pending":"10","completed":"0"}

class GetLeadsStatusModel {
  GetLeadsStatusModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetLeadsStatusModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetLeadsStatusModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetLeadsStatusModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// total : "10"
/// pending : "10"
/// completed : "0"

class Data {
  Data({
      String? total, 
      String? pending, 
      String? completed,}){
    _total = total;
    _pending = pending;
    _completed = completed;
}

  Data.fromJson(dynamic json) {
    _total = json['total'];
    _pending = json['pending'];
    _completed = json['completed'];
  }
  String? _total;
  String? _pending;
  String? _completed;
Data copyWith({  String? total,
  String? pending,
  String? completed,
}) => Data(  total: total ?? _total,
  pending: pending ?? _pending,
  completed: completed ?? _completed,
);
  String? get total => _total;
  String? get pending => _pending;
  String? get completed => _completed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['pending'] = _pending;
    map['completed'] = _completed;
    return map;
  }

}