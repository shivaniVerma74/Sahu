
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/check_in_check_out_screens/check_In_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_all_response/checkinout_model.dart';
import '../dashboard/Dashboard.dart';
import 'package:http/http.dart'as http;

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  String? lat2;
  String? long2;
  String? lat1;
  String? long1;

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();



  // Future<void>CheckInNow() async {
  //   var headers = {
  //     'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkinNow'));
  //   request.fields.addAll({
  //     'user_id': '${CUR_USERID}',
  //     'checkin_latitude': '${latitude}',
  //     'checkin_longitude': '${longitude}',
  //     'address': '${currentAddress.text}'
  //   });
  //
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var Response = await response.stream.bytesToString();
  //     final finalResponse = CheckInModel.fromJson(json.decode(Response));
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  //
  //
  // }



  Future<void> getCurrentLoc() async {

    SharedPreferences preferences= await SharedPreferences.getInstance();
    setState(() {
      lat1 = preferences.getString('lattt');
      long1 = preferences.getString('longg');
      print('mmmmmmmmmmmmmmmmmm${long1}');
      print("lllllllllllllllll${lat1}");

    });
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var loc = Provider.of<LocationProvider>(context, listen: false);

    lat2 = position.latitude.toString();
    long2 = position.longitude.toString();
    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(lat2!), double.parse(long2!),
        localeIdentifier: "en");

    pinController.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController.text = placemark[0].postalCode!;
        currentAddress.text =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        lat2 = position.latitude.toString();
        long2 = position.longitude.toString();
        // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();

        getLatLong2();
        print('Current Addresssssss${currentAddress.text}');
        setState(() {
          calculateDistance(lat1, long1, lat2, long2);
        });
        CheckOut();
      });

      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          navigateToPage();
        });
      }
    }
  }

  Future<void> getLatLong2() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('lat2',lat2 ?? '0.0');
    preferences.setString('long2',long2 ?? '0.0');
    preferences.setString('address2',currentAddress.text);
    // var latt = preferences.getString('longitude');

    // print('my pickedLat-------------${latt}');
    print('my pickedLong-------------${long2}');


  }


  bool? errorMassage2;
  Future<void> CheckOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=ebec56d32bab8f418215d9b9a59c49312fa7206c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkoutNow'));

    request.fields.addAll({
      'checkout_latitude': '${lat2}',
      'checkout_longitude': '${long2}',
      'address': '${currentAddress.text}',
      'user_id': '${uids}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = CheckInOutModel.fromJson(json.decode(Result));

      setState(() {
        errorMassage2 = finalResult.data.error;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
      Fluttertoast.showToast(msg:'${finalResult.data.msg}');

    }
    else {
      print(response.reasonPhrase);
    }




  }


  Future<String> calculateDistance(lat1, long1, lat2, long2) async {
    //double lat1,lat2,lon1,lon2;
    print("-----here---->$lat1 $lat2 $long1 $long2");
    if (lat1 != null && lat2 != null && long1 != null && long2 != null &&
        lat1 != "" && lat2 != "" && long1 != "" && long2 != "") {
      lat1 =
      //22.75901;
      double.parse(lat1.toString());
      lat2 =
      //22.700546;
      double.parse(lat2.toString());
      long1 =
      //75.912935;
      double.parse(long1.toString());
      long2 =
      //75.939211;
      double.parse(long2.toString());
    } else {
      return "0.0 km";
    }
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((long2 - long1) * p)) / 2;
    double km = 12742 * asin(sqrt(a));
    print('distance=============${km.toStringAsFixed(2)}');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('distance',km.toStringAsFixed(2));
    return km.toStringAsFixed(2) + "km";
  }

  navigateToPage() async {
    Future.delayed(Duration(milliseconds:1200), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>Dashboard()),
              (route) => false);
    });
  }

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.whiteTemp,
        title: Text('Check Out',style: TextStyle(color:colors.primary),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          //Text(calculateDistance(lat1, long1, lat2, long2).toString()),
          Container(
            height:MediaQuery.of(context).size.height/4 ,
            width:MediaQuery.of(context).size.width/1,
            child: Image.asset(
              "assets/images/Check_out_image.png",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "DELIVERING TO",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          currentAddress.text == "" || currentAddress.text == null
              ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
                 child: Text(
                "Locating...",
                 style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
              : Text(
            "${currentAddress.text}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,),
          ),
          SizedBox(height: 50,),
          Container(
              height: 45,
              width:MediaQuery.of(context).size.width/1.3,
              decoration:BoxDecoration(
                  color:colors.primary,
                  borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(onPressed: (){
                getCurrentLoc();
              },style: ElevatedButton.styleFrom(backgroundColor:colors.primary), child:Text('Check Out Now ')))

        ],
      ),
    );
  }
}
