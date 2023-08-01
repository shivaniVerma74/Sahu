/// error : false
/// message : "All Leads"

class GetLeadsModel {
  GetLeadsModel({
      bool? error, 
      String? message, 
      List<LeadsData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetLeadsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LeadsData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<LeadsData>? _data;
GetLeadsModel copyWith({  bool? error,
  String? message,
  List<LeadsData>? data,
}) => GetLeadsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<LeadsData>? get data => _data;

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

/// id : "1"
/// bank_name : "L&T TW WHEELER"
/// agreementid : "T17677180822125617"
/// customername : "PRADIP  GIRI"
/// total_charges : "3150"
/// emi_amt : "6754"
/// principal_outstanding : "147123.05"
/// bom_bkt : "0"
/// bkt_grp : "#N/A"
/// phone_1 : "7003575468"
/// phone_2 : "7003575468"
/// phone_3 : "#N/A"
/// phone_4 : "#N/A"
/// fos : "CHANDAN SHARMA"
/// caller : "RAMESH"
/// reference1_name : "#N/A"
/// ref1_contact : "#N/A"
/// reference2_name : "#N/A"
/// ref2_contact : "#N/A"
/// nominee_name : "SUPRIYA GIRI"
/// nominee_no : "8910486798"
/// lm_code : "0"
/// lm_remarks : "FUNDING"
/// sdlm : "30-Jun"
/// sdlm_mode : "#N/A"
/// slm_code : "#N/A"
/// tlm_code : "#N/A"
/// flm_code : "#N/A"
/// allocation : "#N/A"
/// allocation_date : "#N/A"
/// lm_agency : "#N/A"
/// segment : "#N/A"
/// emi_end_date : "3-Oct-22"
/// emi_start_date : "3-Sep-25"
/// product : "TW"
/// cust_catg : "#N/A"
/// employer : "#N/A"
/// fathername : "DULAL GIRI"
/// loan_amt : "#N/A"
/// primary_address : "RAJAR GHAT NATUNPARA KOLKATA MC KOLKATA"
/// primary_address_lm : "#N/A"
/// primary_address_pin : "700105"
/// office_address_ : "#N/A"
/// office_address_lm : "#N/A"
/// office_address_pin : "#N/A"
/// address_3 : "#N/A"
/// address_3_lm : "#N/A"
/// address_3_pin : "#N/A"
/// address_4 : "#N/A"
/// address_4_lm : "#N/A"
/// address_4_pin : "#N/A"
/// ro_name : "#N/A"
/// so_name : "0"
/// model_ : "Yamaha YZF"
/// registration_no : "WB01AU9337"
/// dealer : "PAUL AUTOMOBILES"
/// user_id : "402"
/// assignee_id : "0"
/// user_assignee : "0"
/// status : "0"
/// lat : null
/// lng : null
/// address : "0"
/// created_at : "2023-07-26 18:51:01"
/// updated_at : "2023-07-26 18:51:01"

class LeadsData {
  LeadsData({
      String? id, 
      String? bankName, 
      String? agreementid, 
      String? customername, 
      String? totalCharges, 
      String? emiAmt, 
      String? principalOutstanding, 
      String? bomBkt, 
      String? bktGrp, 
      String? phone1, 
      String? phone2, 
      String? phone3, 
      String? phone4, 
      String? fos, 
      String? caller, 
      String? reference1Name, 
      String? ref1Contact, 
      String? reference2Name, 
      String? ref2Contact, 
      String? nomineeName, 
      String? nomineeNo, 
      String? lmCode, 
      String? lmRemarks, 
      String? sdlm, 
      String? sdlmMode, 
      String? slmCode, 
      String? tlmCode, 
      String? flmCode, 
      String? allocation, 
      String? allocationDate, 
      String? lmAgency, 
      String? segment, 
      String? emiEndDate, 
      String? emiStartDate, 
      String? product, 
      String? custCatg, 
      String? employer, 
      String? fathername, 
      String? loanAmt, 
      String? primaryAddress, 
      String? primaryAddressLm, 
      String? primaryAddressPin, 
      String? officeAddress, 
      String? officeAddressLm, 
      String? officeAddressPin, 
      String? address3, 
      String? address3Lm, 
      String? address3Pin, 
      String? address4, 
      String? address4Lm, 
      String? address4Pin, 
      String? roName, 
      String? soName, 
      String? model, 
      String? registrationNo, 
      String? dealer, 
      String? userId, 
      String? assigneeId, 
      String? userAssignee, 
      String? status, 
      dynamic lat, 
      dynamic lng, 
      String? address, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _bankName = bankName;
    _agreementid = agreementid;
    _customername = customername;
    _totalCharges = totalCharges;
    _emiAmt = emiAmt;
    _principalOutstanding = principalOutstanding;
    _bomBkt = bomBkt;
    _bktGrp = bktGrp;
    _phone1 = phone1;
    _phone2 = phone2;
    _phone3 = phone3;
    _phone4 = phone4;
    _fos = fos;
    _caller = caller;
    _reference1Name = reference1Name;
    _ref1Contact = ref1Contact;
    _reference2Name = reference2Name;
    _ref2Contact = ref2Contact;
    _nomineeName = nomineeName;
    _nomineeNo = nomineeNo;
    _lmCode = lmCode;
    _lmRemarks = lmRemarks;
    _sdlm = sdlm;
    _sdlmMode = sdlmMode;
    _slmCode = slmCode;
    _tlmCode = tlmCode;
    _flmCode = flmCode;
    _allocation = allocation;
    _allocationDate = allocationDate;
    _lmAgency = lmAgency;
    _segment = segment;
    _emiEndDate = emiEndDate;
    _emiStartDate = emiStartDate;
    _product = product;
    _custCatg = custCatg;
    _employer = employer;
    _fathername = fathername;
    _loanAmt = loanAmt;
    _primaryAddress = primaryAddress;
    _primaryAddressLm = primaryAddressLm;
    _primaryAddressPin = primaryAddressPin;
    _officeAddress = officeAddress;
    _officeAddressLm = officeAddressLm;
    _officeAddressPin = officeAddressPin;
    _address3 = address3;
    _address3Lm = address3Lm;
    _address3Pin = address3Pin;
    _address4 = address4;
    _address4Lm = address4Lm;
    _address4Pin = address4Pin;
    _roName = roName;
    _soName = soName;
    _model = model;
    _registrationNo = registrationNo;
    _dealer = dealer;
    _userId = userId;
    _assigneeId = assigneeId;
    _userAssignee = userAssignee;
    _status = status;
    _lat = lat;
    _lng = lng;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LeadsData.fromJson(dynamic json) {
    _id = json['id'];
    _bankName = json['bank_name'];
    _agreementid = json['agreementid'];
    _customername = json['customername'];
    _totalCharges = json['total_charges'];
    _emiAmt = json['emi_amt'];
    _principalOutstanding = json['principal_outstanding'];
    _bomBkt = json['bom_bkt'];
    _bktGrp = json['bkt_grp'];
    _phone1 = json['phone_1'];
    _phone2 = json['phone_2'];
    _phone3 = json['phone_3'];
    _phone4 = json['phone_4'];
    _fos = json['fos'];
    _caller = json['caller'];
    _reference1Name = json['reference1_name'];
    _ref1Contact = json['ref1_contact'];
    _reference2Name = json['reference2_name'];
    _ref2Contact = json['ref2_contact'];
    _nomineeName = json['nominee_name'];
    _nomineeNo = json['nominee_no'];
    _lmCode = json['lm_code'];
    _lmRemarks = json['lm_remarks'];
    _sdlm = json['sdlm'];
    _sdlmMode = json['sdlm_mode'];
    _slmCode = json['slm_code'];
    _tlmCode = json['tlm_code'];
    _flmCode = json['flm_code'];
    _allocation = json['allocation'];
    _allocationDate = json['allocation_date'];
    _lmAgency = json['lm_agency'];
    _segment = json['segment'];
    _emiEndDate = json['emi_end_date'];
    _emiStartDate = json['emi_start_date'];
    _product = json['product'];
    _custCatg = json['cust_catg'];
    _employer = json['employer'];
    _fathername = json['fathername'];
    _loanAmt = json['loan_amt'];
    _primaryAddress = json['primary_address'];
    _primaryAddressLm = json['primary_address_lm'];
    _primaryAddressPin = json['primary_address_pin'];
    _officeAddress = json['office_address_'];
    _officeAddressLm = json['office_address_lm'];
    _officeAddressPin = json['office_address_pin'];
    _address3 = json['address_3'];
    _address3Lm = json['address_3_lm'];
    _address3Pin = json['address_3_pin'];
    _address4 = json['address_4'];
    _address4Lm = json['address_4_lm'];
    _address4Pin = json['address_4_pin'];
    _roName = json['ro_name'];
    _soName = json['so_name'];
    _model = json['model_'];
    _registrationNo = json['registration_no'];
    _dealer = json['dealer'];
    _userId = json['user_id'];
    _assigneeId = json['assignee_id'];
    _userAssignee = json['user_assignee'];
    _status = json['status'];
    _lat = json['lat'];
    _lng = json['lng'];
    _address = json['address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _bankName;
  String? _agreementid;
  String? _customername;
  String? _totalCharges;
  String? _emiAmt;
  String? _principalOutstanding;
  String? _bomBkt;
  String? _bktGrp;
  String? _phone1;
  String? _phone2;
  String? _phone3;
  String? _phone4;
  String? _fos;
  String? _caller;
  String? _reference1Name;
  String? _ref1Contact;
  String? _reference2Name;
  String? _ref2Contact;
  String? _nomineeName;
  String? _nomineeNo;
  String? _lmCode;
  String? _lmRemarks;
  String? _sdlm;
  String? _sdlmMode;
  String? _slmCode;
  String? _tlmCode;
  String? _flmCode;
  String? _allocation;
  String? _allocationDate;
  String? _lmAgency;
  String? _segment;
  String? _emiEndDate;
  String? _emiStartDate;
  String? _product;
  String? _custCatg;
  String? _employer;
  String? _fathername;
  String? _loanAmt;
  String? _primaryAddress;
  String? _primaryAddressLm;
  String? _primaryAddressPin;
  String? _officeAddress;
  String? _officeAddressLm;
  String? _officeAddressPin;
  String? _address3;
  String? _address3Lm;
  String? _address3Pin;
  String? _address4;
  String? _address4Lm;
  String? _address4Pin;
  String? _roName;
  String? _soName;
  String? _model;
  String? _registrationNo;
  String? _dealer;
  String? _userId;
  String? _assigneeId;
  String? _userAssignee;
  String? _status;
  dynamic _lat;
  dynamic _lng;
  String? _address;
  String? _createdAt;
  String? _updatedAt;
  LeadsData copyWith({  String? id,
  String? bankName,
  String? agreementid,
  String? customername,
  String? totalCharges,
  String? emiAmt,
  String? principalOutstanding,
  String? bomBkt,
  String? bktGrp,
  String? phone1,
  String? phone2,
  String? phone3,
  String? phone4,
  String? fos,
  String? caller,
  String? reference1Name,
  String? ref1Contact,
  String? reference2Name,
  String? ref2Contact,
  String? nomineeName,
  String? nomineeNo,
  String? lmCode,
  String? lmRemarks,
  String? sdlm,
  String? sdlmMode,
  String? slmCode,
  String? tlmCode,
  String? flmCode,
  String? allocation,
  String? allocationDate,
  String? lmAgency,
  String? segment,
  String? emiEndDate,
  String? emiStartDate,
  String? product,
  String? custCatg,
  String? employer,
  String? fathername,
  String? loanAmt,
  String? primaryAddress,
  String? primaryAddressLm,
  String? primaryAddressPin,
  String? officeAddress,
  String? officeAddressLm,
  String? officeAddressPin,
  String? address3,
  String? address3Lm,
  String? address3Pin,
  String? address4,
  String? address4Lm,
  String? address4Pin,
  String? roName,
  String? soName,
  String? model,
  String? registrationNo,
  String? dealer,
  String? userId,
  String? assigneeId,
  String? userAssignee,
  String? status,
  dynamic lat,
  dynamic lng,
  String? address,
  String? createdAt,
  String? updatedAt,
}) => LeadsData(  id: id ?? _id,
  bankName: bankName ?? _bankName,
  agreementid: agreementid ?? _agreementid,
  customername: customername ?? _customername,
  totalCharges: totalCharges ?? _totalCharges,
  emiAmt: emiAmt ?? _emiAmt,
  principalOutstanding: principalOutstanding ?? _principalOutstanding,
  bomBkt: bomBkt ?? _bomBkt,
  bktGrp: bktGrp ?? _bktGrp,
  phone1: phone1 ?? _phone1,
  phone2: phone2 ?? _phone2,
  phone3: phone3 ?? _phone3,
  phone4: phone4 ?? _phone4,
  fos: fos ?? _fos,
  caller: caller ?? _caller,
  reference1Name: reference1Name ?? _reference1Name,
  ref1Contact: ref1Contact ?? _ref1Contact,
  reference2Name: reference2Name ?? _reference2Name,
  ref2Contact: ref2Contact ?? _ref2Contact,
  nomineeName: nomineeName ?? _nomineeName,
  nomineeNo: nomineeNo ?? _nomineeNo,
  lmCode: lmCode ?? _lmCode,
  lmRemarks: lmRemarks ?? _lmRemarks,
  sdlm: sdlm ?? _sdlm,
  sdlmMode: sdlmMode ?? _sdlmMode,
  slmCode: slmCode ?? _slmCode,
  tlmCode: tlmCode ?? _tlmCode,
  flmCode: flmCode ?? _flmCode,
  allocation: allocation ?? _allocation,
  allocationDate: allocationDate ?? _allocationDate,
  lmAgency: lmAgency ?? _lmAgency,
  segment: segment ?? _segment,
  emiEndDate: emiEndDate ?? _emiEndDate,
  emiStartDate: emiStartDate ?? _emiStartDate,
  product: product ?? _product,
  custCatg: custCatg ?? _custCatg,
  employer: employer ?? _employer,
  fathername: fathername ?? _fathername,
  loanAmt: loanAmt ?? _loanAmt,
  primaryAddress: primaryAddress ?? _primaryAddress,
  primaryAddressLm: primaryAddressLm ?? _primaryAddressLm,
  primaryAddressPin: primaryAddressPin ?? _primaryAddressPin,
  officeAddress: officeAddress ?? _officeAddress,
  officeAddressLm: officeAddressLm ?? _officeAddressLm,
  officeAddressPin: officeAddressPin ?? _officeAddressPin,
  address3: address3 ?? _address3,
  address3Lm: address3Lm ?? _address3Lm,
  address3Pin: address3Pin ?? _address3Pin,
  address4: address4 ?? _address4,
  address4Lm: address4Lm ?? _address4Lm,
  address4Pin: address4Pin ?? _address4Pin,
  roName: roName ?? _roName,
  soName: soName ?? _soName,
  model: model ?? _model,
  registrationNo: registrationNo ?? _registrationNo,
  dealer: dealer ?? _dealer,
  userId: userId ?? _userId,
  assigneeId: assigneeId ?? _assigneeId,
  userAssignee: userAssignee ?? _userAssignee,
  status: status ?? _status,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  address: address ?? _address,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get bankName => _bankName;
  String? get agreementid => _agreementid;
  String? get customername => _customername;
  String? get totalCharges => _totalCharges;
  String? get emiAmt => _emiAmt;
  String? get principalOutstanding => _principalOutstanding;
  String? get bomBkt => _bomBkt;
  String? get bktGrp => _bktGrp;
  String? get phone1 => _phone1;
  String? get phone2 => _phone2;
  String? get phone3 => _phone3;
  String? get phone4 => _phone4;
  String? get fos => _fos;
  String? get caller => _caller;
  String? get reference1Name => _reference1Name;
  String? get ref1Contact => _ref1Contact;
  String? get reference2Name => _reference2Name;
  String? get ref2Contact => _ref2Contact;
  String? get nomineeName => _nomineeName;
  String? get nomineeNo => _nomineeNo;
  String? get lmCode => _lmCode;
  String? get lmRemarks => _lmRemarks;
  String? get sdlm => _sdlm;
  String? get sdlmMode => _sdlmMode;
  String? get slmCode => _slmCode;
  String? get tlmCode => _tlmCode;
  String? get flmCode => _flmCode;
  String? get allocation => _allocation;
  String? get allocationDate => _allocationDate;
  String? get lmAgency => _lmAgency;
  String? get segment => _segment;
  String? get emiEndDate => _emiEndDate;
  String? get emiStartDate => _emiStartDate;
  String? get product => _product;
  String? get custCatg => _custCatg;
  String? get employer => _employer;
  String? get fathername => _fathername;
  String? get loanAmt => _loanAmt;
  String? get primaryAddress => _primaryAddress;
  String? get primaryAddressLm => _primaryAddressLm;
  String? get primaryAddressPin => _primaryAddressPin;
  String? get officeAddress => _officeAddress;
  String? get officeAddressLm => _officeAddressLm;
  String? get officeAddressPin => _officeAddressPin;
  String? get address3 => _address3;
  String? get address3Lm => _address3Lm;
  String? get address3Pin => _address3Pin;
  String? get address4 => _address4;
  String? get address4Lm => _address4Lm;
  String? get address4Pin => _address4Pin;
  String? get roName => _roName;
  String? get soName => _soName;
  String? get model => _model;
  String? get registrationNo => _registrationNo;
  String? get dealer => _dealer;
  String? get userId => _userId;
  String? get assigneeId => _assigneeId;
  String? get userAssignee => _userAssignee;
  String? get status => _status;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  String? get address => _address;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bank_name'] = _bankName;
    map['agreementid'] = _agreementid;
    map['customername'] = _customername;
    map['total_charges'] = _totalCharges;
    map['emi_amt'] = _emiAmt;
    map['principal_outstanding'] = _principalOutstanding;
    map['bom_bkt'] = _bomBkt;
    map['bkt_grp'] = _bktGrp;
    map['phone_1'] = _phone1;
    map['phone_2'] = _phone2;
    map['phone_3'] = _phone3;
    map['phone_4'] = _phone4;
    map['fos'] = _fos;
    map['caller'] = _caller;
    map['reference1_name'] = _reference1Name;
    map['ref1_contact'] = _ref1Contact;
    map['reference2_name'] = _reference2Name;
    map['ref2_contact'] = _ref2Contact;
    map['nominee_name'] = _nomineeName;
    map['nominee_no'] = _nomineeNo;
    map['lm_code'] = _lmCode;
    map['lm_remarks'] = _lmRemarks;
    map['sdlm'] = _sdlm;
    map['sdlm_mode'] = _sdlmMode;
    map['slm_code'] = _slmCode;
    map['tlm_code'] = _tlmCode;
    map['flm_code'] = _flmCode;
    map['allocation'] = _allocation;
    map['allocation_date'] = _allocationDate;
    map['lm_agency'] = _lmAgency;
    map['segment'] = _segment;
    map['emi_end_date'] = _emiEndDate;
    map['emi_start_date'] = _emiStartDate;
    map['product'] = _product;
    map['cust_catg'] = _custCatg;
    map['employer'] = _employer;
    map['fathername'] = _fathername;
    map['loan_amt'] = _loanAmt;
    map['primary_address'] = _primaryAddress;
    map['primary_address_lm'] = _primaryAddressLm;
    map['primary_address_pin'] = _primaryAddressPin;
    map['office_address_'] = _officeAddress;
    map['office_address_lm'] = _officeAddressLm;
    map['office_address_pin'] = _officeAddressPin;
    map['address_3'] = _address3;
    map['address_3_lm'] = _address3Lm;
    map['address_3_pin'] = _address3Pin;
    map['address_4'] = _address4;
    map['address_4_lm'] = _address4Lm;
    map['address_4_pin'] = _address4Pin;
    map['ro_name'] = _roName;
    map['so_name'] = _soName;
    map['model_'] = _model;
    map['registration_no'] = _registrationNo;
    map['dealer'] = _dealer;
    map['user_id'] = _userId;
    map['assignee_id'] = _assigneeId;
    map['user_assignee'] = _userAssignee;
    map['status'] = _status;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['address'] = _address;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}