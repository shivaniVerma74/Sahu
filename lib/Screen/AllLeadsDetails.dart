import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/Screen/dashboard/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/Color.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../model_all_response/check_in_model.dart';
import '../../model_all_response/checkinout_model.dart';
import '../../model_all_response/get_leads_model.dart';
import '../../model_all_response/get_leads_status_model.dart';
import '../../model_all_response/get_user_check_in_out.dart';
import 'check_in_check_out_screens/check_In_screen.dart';
import 'check_in_check_out_screens/check_out_screen.dart';


class AllLeadsDetails extends StatefulWidget {
  LeadsData? model;
  AllLeadsDetails({Key? key, this.model}) : super(key: key);

  @override
  State<AllLeadsDetails> createState() => _AllLeadsDetailsState();
}

String? latitude, longitude, state, country;

class _AllLeadsDetailsState extends State<AllLeadsDetails> {

  String? lat2;
  String? long2;
  String? lat1;
  String? long1;
  String? address1;
  String? address2;
  String? address3;
  String? address4;

  Future<void> getAddress()async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    address3 = preferences.getString('address2');
    address4 = preferences.getString('address1');
    print('addressssss33333 ${address3}');
  }

  Future<void> getDistance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    distance = preferences.getString('distance');
    print('distanceeeeee${distance}');
  }

  String? distance;
  @override
  void initState() {
    super.initState();
    getAddress();
    // GetLeadsData();
    getDistance();
    getStatus();
    getTodaysData();
    print("id leaddf ${widget.model?.id}");
  }

  // GetLeadsModel? getLeadData;
  // Future<void> GetLeadsData() async {
  //   var headers = {
  //     'Cookie': 'ci_session=f7f450979da7c100cfbf415c279cc332bfca8211'
  //   };
  //   var request = http.MultipartRequest('GET', Uri.parse('${baseUrl}get_leads'));
  //   request.fields.addAll({
  //     'user_id': '${CUR_USERID}'
  //   });
  //   print("useir id in get leads ${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var Result = await response.stream.bytesToString();
  //     final finalResult = GetLeadsModel.fromJson(json.decode(Result));
  //     setState(() {
  //       getLeadData = finalResult;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  GetLeadsStatusModel?getLeadStatus;
  Future<void> getStatus() async {
    var headers = {
      'Cookie': 'ci_session=85dc808070002f22be4d6aceec73de5a280d52d6'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${baseUrl}get_lead_status?user_id=${CUR_USERID}'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });
    print("leadddssdsdsd ${request}");
    print("my request---------------- ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = GetLeadsStatusModel.fromJson(json.decode(Response));
      print("Aaaaaaaaaaaaaaaaaaaa ${Response}");
      setState(() {
        getLeadStatus = finalResponse;
        print("leadddssdsdsd ${getLeadStatus?.data?.total}");

      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  GetUserCheckInOutModel? getUserCheckInOutModel;
  Future<void> getTodaysData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    print('kkkkkkkk ${uids}');
    var headers = {
      'Cookie': 'ci_session=67b5132e21cb7d4694508715c31844e52b6adf48'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_user_checkinout'));
    request.fields.addAll({
      'user_id': '${uids}'
    });
    print('user iddddddddddd${CUR_USERID}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = GetUserCheckInOutModel.fromJson(json.decode(Result));
      setState(() {
        getUserCheckInOutModel=finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  bool? errorMassage;
  Future<void> getUserCheckIn() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    setState(() {
      lat1 = preferences.getString('lattt');
      long1 = preferences.getString('longg');
      address1 = preferences.getString('address1');
      print('mmmmmmmmmmmmmmmmmm${long1}');
      print("lllllllllllllllll${lat1}");
      print("aaaaaaaaaaaa${address1}");
    });

    var headers = {
      'Cookie': 'ci_session=45a1d8071ef0fa0ad71c47efe8f4c8ef16788c68'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${baseUrl}checkinNow"));
    request.fields.addAll({
      'checkin_latitude': '${latitude}',
      'checkin_longitude': '${longitude}',
      'address': '${currentAddress.text}',
      'user_id': '${CUR_USERID}'
    });
    print("user checkin ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = CheckInModel.fromJson(json.decode(Result));
      errorMassage =finalResult.data.error;
      print('-------------errorr${errorMassage}');
      if(errorMassage==false){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckInScreen(leadId: widget.model!.id)));
      }else{
        Fluttertoast.showToast(msg:'${finalResult.data.msg}');
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  var currentlocation_Global;
  var longitude_Global;
  var lattitudee_Global;
  var pinController = TextEditingController();
  var currentAddress = TextEditingController();


  var currentlocation_Global1;
  var longitude_Global1;
  var lattitudee_Global1;
  var pinController1 = TextEditingController();
  var currentAddress1 = TextEditingController();

  Future<void> getCurrentLocCheckout() async {
    print("workingggg===========");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global1=latitude;
      lattitudee_Global1=longitude;
    });

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");
    pinController1.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController1.text = placemark[0].postalCode!;
        currentAddress1.text =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();
        setState(() {
          currentlocation_Global1=currentAddress1.text.toString();
        });
        CheckOut();
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');
        print('Current Addresssssss${currentAddress1.text}');
      });
      if (currentAddress1.text == "" || currentAddress1.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
  }

  Future<void> getCurrentLoc() async {
    print("workingggg===========");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    setState(() {
      longitude_Global=latitude;
      lattitudee_Global=longitude;
    });

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");
    pinController.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController.text = placemark[0].postalCode!;
        currentAddress.text =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();
        setState(() {
          currentlocation_Global=currentAddress.text.toString();
        });
        getUserCheckIn();
        print('Latitude=============${latitude}');
        print('Longitude*************${longitude}');
        print('Current Addresssssss${currentAddress.text}');
      });
      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          // navigateToPage();
        });
      }
    }
  }


  bool? errorMassage2;
  Future<void> CheckOut()async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    setState(() {
      lat2 = preferences.getString('lat2');
      long2 = preferences.getString('long2');
      address2 = preferences.getString('address2');
      print('mmmmmmmmmmmmmmmmmm${long2}');
      print("lllllllllllllllll${address2}");
    });
    var headers = {
      'Cookie': 'ci_session=ebec56d32bab8f418215d9b9a59c49310fa7206c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkoutNow'));

    request.fields.addAll({
      'checkout_latitude': '${latitude}',
      'checkout_longitude': '${longitude}',
      'address': '${currentAddress1.text}',
      'user_id': '${CUR_USERID}'
    });
    print("user checkin ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = CheckInOutModel.fromJson(json.decode(Result));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
      // errorMassage2 = finalResult.data.error;
      // if(errorMassage2 == false) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
      // }else{
        Fluttertoast.showToast(msg:'${finalResult.data.msg}');
      // }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  _callNumber(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber1(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }


  _callNumber2(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }


  _callNumber3(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber4(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber5(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber6(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber7(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber8(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }

  _callNumber9(String? mobileNumber) async {
    var number = "${mobileNumber}";
    print("numberrrrr ${number}");
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print("mobileee ${res}");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        centerTitle: true,
        elevation: 0,
        title: Text("Leads Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10,),
            // getLeadData?.message!=null ? Padding(
            //   padding: const EdgeInsets.only(left:10.0),
            //   child: Text('${getLeadData?.message}',style: TextStyle(color: colors.primary,fontWeight: FontWeight.w700,fontSize:20),),
            // ):Center(child: CircularProgressIndicator()),
            SizedBox(height: 10),
             Container(
              child: Card(
                elevation:5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bank Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Customer Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Bucket :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Caller :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Agreement Id", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Total Charges", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Emi Amt.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  child: Text("BKt Group", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                              SizedBox(height: 10,),
                              Text("Phone1", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Phone2", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Phone3", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10,),
                              Text("Phone4", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("FOS", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10,),
                              Text("Reference1 Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  child: Text("Reference2 Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp))),
                              SizedBox(height: 10),
                              Text("Reference1 Contact", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Container(
                                  height: 20,
                                  child: Text("Reference2 Contact", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp))),
                              SizedBox(height: 10),
                              Text("Nominee Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("Nominee No.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("Im Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 15),
                              Text("Im Remarks", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("SDLM", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("SBLM Mode", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("SLM Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("TLM Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("FLM Code", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("Allocation", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Agency", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Segamnet", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("EMI Start Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("EMI End Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Product", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Cust Cat", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Employer", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Father Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10),
                              Text("Loan AMt.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height: 10,
                                  child: Text("Primary Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                              SizedBox(height: 10,),
                              Text("Primary Address Lm", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Primary Address Pin.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Office Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  child: Text("Office Address Lm", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                              SizedBox(height: 10,),
                              Text("Office Address Pin.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  child: Text("Address3.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                              SizedBox(height: 10,),
                              Text("Address3. IM", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  child: Text("Address3. Pin", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                              SizedBox(height: 10,),
                              Text("Address4", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Address4 IM", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              Container(
                                  height: 20,
                                  child: SizedBox(height: 10,)),
                              Text("Address4 Pin.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Ro Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("So Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Model", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Text("Registration No", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                              SizedBox(height: 10,),
                              Container(
                                  height:130,
                                  child: Text("Dealer", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("${widget.model?.bankName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 15),
                              Text("${widget.model?.customername}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height: 5),
                              Text("${widget.model?.bomBkt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height:10),
                              Text("${widget.model?.caller}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height:10),
                              Text("${widget.model?.agreementid}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.totalCharges}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.emiAmt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 15),
                              Container(
                                  width: 100,
                                  child: Text("${widget.model?.bktGrp}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), maxLines: 2,)),
                              SizedBox(height: 15),
                              InkWell(
                                  onTap: () {
                                    _callNumber(widget.model?.phone1.toString());
                                  },
                                  child: Text("${widget.model?.phone1}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),)),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  _callNumber1(widget.model?.phone2.toString());
                                },
                                child: Container(
                                    width: 170,
                                    child: Text("${widget.model?.phone2}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  _callNumber2(widget.model?.phone3.toString());
                                },
                                child: Container(
                                    width: 170,
                                    child: Text("${widget.model?.phone3}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  _callNumber3(widget.model?.phone4.toString());
                                },
                                  child: Text("${widget.model?.phone4}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp))),
                              SizedBox(height: 5),
                              Text("${widget.model?.fos}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height:15),
                              Text("${widget.model?.reference1Name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.reference2Name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  _callNumber4(widget.model?.ref1Contact.toString());
                                },
                                  child: Text("${widget.model?.ref1Contact}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp))),
                              SizedBox(height: 10),
                              InkWell(
                                  onTap: () {
                                    _callNumber5(widget.model?.ref2Contact.toString());
                                  },
                                  child: Text("${widget.model?.ref2Contact}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp))),
                              SizedBox(height: 10),
                              Text("${widget.model?.nomineeName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              InkWell(
                                  onTap: () {
                                    _callNumber6(widget.model?.nomineeNo.toString());
                                  },
                                  child: Text("${widget.model?.nomineeNo}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp))),
                              SizedBox(height: 10),

                              Text("${widget.model?.lmCode}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.lmRemarks}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.sdlm}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 5),
                              Text("${widget.model?.sdlmMode}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.slmCode}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.tlmCode}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.flmCode}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.allocation}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.allocationDate}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.lmAgency}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.segment}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.emiStartDate}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.emiEndDate}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.product}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.custCatg}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.employer}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.fathername}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Text("${widget.model?.loanAmt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.primaryAddress}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), maxLines: 1,
                                    overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.primaryAddressLm}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,
                                    overflow: TextOverflow.ellipsis,))),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.primaryAddressPin}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),)),
                              SizedBox(height: 15),
                              Text("${widget.model?.officeAddress}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height: 10),
                              Container(
                                  width: 120,
                                  child: Text("${widget.model?.officeAddressLm}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),)),
                              SizedBox(height: 10),
                              Text("${widget.model?.officeAddressPin}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.address3}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.address3Lm}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.address3Pin}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              SizedBox(height: 10),
                              Text("${widget.model?.address4}",maxLines: 1, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),),
                              SizedBox(height: 15),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.address4Lm}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp,overflow: TextOverflow.ellipsis),)),
                              SizedBox(height: 10,),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.address4Pin}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),)),
                              SizedBox(height: 10),
                              Text("${widget.model?.roName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height: 15),
                              Text("${widget.model?.soName}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.model}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.registrationNo}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 10),
                              Container(
                                  width: 170,
                                  child: Text("${widget.model?.dealer}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                              SizedBox(height:120),
                              // address3!=null ?Text("${getLeadData?.data?[index].primaryAddress}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),):Text('Address not found'),
                              // SizedBox(height: 10,),
                              // address4!=null?Text("${address4}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),):Text('Address not found'),
                              // SizedBox(height: 10,),
                              // distance ==null||distance==""?Text('0.00km'):Text("${distance} km", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width:MediaQuery.of(context).size.width/1.2,
                      child: Divider(
                        color: colors.primary,
                        height:15,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            getCurrentLoc();
                            // getUserCheckIn();
                          },
                          child: Container(
                            height:40,
                            width:170,
                            decoration: BoxDecoration(
                              color:colors.primary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Text('Check In',style: TextStyle(color: colors.whiteTemp),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            getCurrentLocCheckout();
                          },
                          child: Container(
                            height:40,
                            width:170,
                            decoration: BoxDecoration(
                              color:colors.secondary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Text('Check Out',style: TextStyle(color: colors.whiteTemp),textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            )
                 // :Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
