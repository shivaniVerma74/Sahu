/// error : false
/// message : "User Monthly Earnings"
/// data : [{"pos":"350049.17000000004","total_amount":"46587","month":"July","earning_percent":"2","earning_amount":"931.74"}]

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

/// pos : "350049.17000000004"
/// total_amount : "46587"
/// month : "July"
/// earning_percent : "2"
/// earning_amount : "931.74"

class Data {
  Data({
      String? pos, 
      String? totalAmount, 
      String? month, 
      String? earningPercent, 
      String? earningAmount,}){
    _pos = pos;
    _totalAmount = totalAmount;
    _month = month;
    _earningPercent = earningPercent;
    _earningAmount = earningAmount;
}

  Data.fromJson(dynamic json) {
    _pos = json['pos'];
    _totalAmount = json['total_amount'];
    _month = json['month'];
    _earningPercent = json['earning_percent'];
    _earningAmount = json['earning_amount'];
  }
  String? _pos;
  String? _totalAmount;
  String? _month;
  String? _earningPercent;
  String? _earningAmount;
Data copyWith({  String? pos,
  String? totalAmount,
  String? month,
  String? earningPercent,
  String? earningAmount,
}) => Data(  pos: pos ?? _pos,
  totalAmount: totalAmount ?? _totalAmount,
  month: month ?? _month,
  earningPercent: earningPercent ?? _earningPercent,
  earningAmount: earningAmount ?? _earningAmount,
);
  String? get pos => _pos;
  String? get totalAmount => _totalAmount;
  String? get month => _month;
  String? get earningPercent => _earningPercent;
  String? get earningAmount => _earningAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pos'] = _pos;
    map['total_amount'] = _totalAmount;
    map['month'] = _month;
    map['earning_percent'] = _earningPercent;
    map['earning_amount'] = _earningAmount;
    return map;
  }

}