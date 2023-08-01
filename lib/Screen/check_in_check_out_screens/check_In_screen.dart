import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/Screen/home_view/HomePage.dart';
import 'package:omega_employee_management/model_all_response/check_in_model.dart';
import 'package:omega_employee_management/Screen/Auth_view/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Session.dart';
import '../../model_all_response/get_leads_model.dart';
import '../dashboard/Dashboard.dart';
import 'package:http/http.dart'as http;

class CheckInScreen extends StatefulWidget {
  LeadsData? model;
  CheckInScreen({Key? key, this.model}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  var latitude;
  var longitude;
  bool isLoading = false;
  var pinController = TextEditingController();
  var currentAddress = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController dateCtr = TextEditingController();
  TextEditingController remarkCtr = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool Check= true;

 bool? errormsg;
 String? lead_id;



  myLeadId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    lead_id = preferences.getString('lead_id');
    print("leaddata is here-------- ${lead_id}");

  }


  Future<void>CheckInNow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkinNow'));
    request.fields.addAll({
      'checkin_latitude': '${latitude}',
      'checkin_longitude': '${longitude}',
      'address': '${currentAddress}',
      'user_id': '${uids}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = CheckInModel.fromJson(json.decode(Response));
      errormsg = finalResponse.data.error;
      Fluttertoast.showToast(msg:'${finalResponse.data.msg}');
      print('kkkkkkkkkkkkkkkkkk${finalResponse.data.msg}');
      setState(() {
        Check=false;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }



  Future<void> getCurrentLoc() async {
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

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
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


        print('=============${latitude}');
        print('Longitude*************${longitude}');
        print('Current Addresssssss${currentAddress.text}');
        getLatLong();
        CheckInNow();

      });

      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
       Fluttertoast.showToast(msg:"Check In Successfully");
      }
    }
  }


  Future<void> getLatLong() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('lattt',latitude ?? '0.0');
    preferences.setString('longg',longitude ?? '0.0');
    preferences.setString('address1',currentAddress.text);
   // var latt = preferences.getString('longitude');
     // print('my pickedLat-------------${latt}');
      print('my pickedLong-------------${longitude}');
  }

  // navigateToPage() async {
  //   Future.delayed(Duration(milliseconds:1200), () {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) =>Dashboard()),
  //         (route) => false);
  //   });
  // }



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLeadId();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.whiteTemp,
        title: Text('Check In ',style: TextStyle(color:colors.primary),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height:MediaQuery.of(context).size.height/4.5,
              width:MediaQuery.of(context).size.width/1,
              child: Image.asset(
                "assets/images/check_in_image2.jpg.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "DELIVERING TO",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
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

            SizedBox(height: 20,),
            SizedBox(height: 30,),
            Container(
                height: 45,
                width:MediaQuery.of(context).size.width/1.3,
                decoration:BoxDecoration(
                    color:colors.primary,
                    borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(onPressed: (){
                  getCurrentLoc();
                },style: ElevatedButton.styleFrom(backgroundColor:colors.primary), child:Text('Check In Now '))
            ),
            SizedBox(height: 30,),
            Check==false?Container(
               // height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Card(
                elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: feedback(),
                  ),
              ),
            ):SizedBox.shrink(),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }


  addFeedbacks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? leadId = prefs.getString('lead_id');
    String? uids = prefs.getString('new_user_id');
    print("111111111111111111111${leadId}");
    var headers = {
      'Cookie': 'ci_session=ccfe390f27e667ad5443dcf152e62cb857c138d4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/add_lead_feedback'));
    request.fields.addAll({
      'address': '${addressValue}',
      'customer': '${customerValue}',
      'family_member': '${familymemberValue}',
      'vechile': '${vehicleValue}',
      'name': '${nameCtr.text}',
      'mobile': '${mobileCtr.text}',
      'user_id': '${uids}',
      'lead_id': lead_id.toString(),
      'code': '${codeValue}',
      'code_type': "${escValue}",
      'next_date': '${dateController.text}',
      'remark': '${remarkCtr.text}'
    });
    print('--------Fieldssssss------${request.fields}');
    for (var i = 0; i < imagePathList.length; i++) {
      print('Imageeeeeeeeeeeeeeeeee${imagePathList}');
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'image', imagePathList[i].toString()));
    }
    print('--------image------${request.fields}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult = jsonDecode(result);
       Fluttertoast.showToast(msg: "${finalResult['message']}");
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final List<String> items = [
    'Avaliable',
    'Not Avaliable',
  ];

  final List<String> items2 = [
    'Avaliable',
    'Not Avaliable',
  ];

  final List<String> items3 = [
    'Avaliable',
    'Not Avaliable',
  ];

  final List<String> items4 = [
    'Avaliable',
    'Not Avaliable',
    'thiredparty'
  ];

  final List<String> items5 = [
  'Re-vinit',
    'PTP',
    'BPTP',
    'RTP',
    'STAB',
    'RB',
    'NORM',
    'SHIFTED',
    'PTPRB',
    'STABRB',
  ];

  final List<String> items6 = [
    'ECS',
    'ONLINE',
    'CASH'
  ];

  bool isVisible = false;

  String? addressValue;
  String? customerValue;
  String? familymemberValue;
  String? vehicleValue;
  String? codeValue;
  String? escValue;

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextFormField(
              // maxLength: 6,
              onTap: () {
                setState(() {
                  // GetLeadsData();
                });
              },
              controller: nameCtr,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Enter Name',
                  contentPadding: EdgeInsets.only(top: 5,left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              maxLength: 10,
              onTap: () {
                setState(() {
                  // GetLeadsData();
                });
              },
              controller: mobileCtr,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Mobile No.',
                  contentPadding: EdgeInsets.only(top: 5,left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            },style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                child:Text('Submit Feedbacks',style: TextStyle(color: colors.whiteTemp),))
          ],
        );
      },
    );
  }


 Widget stabDroupDown(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'ESC',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items6
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
              value: escValue,
              onChanged: (String? value) {
                setState(() {
                  escValue = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
 }

  Widget feedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height/0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Check==false?Text('Feedbacks',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),):SizedBox.shrink(),
              SizedBox(height: 10,),
             Row(
               children: [
                 Card(
                   elevation: 4,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   child:
                   DropdownButtonHideUnderline(
                     child: DropdownButton2<String>(
                       isExpanded: true,
                       hint: Text(
                         'Address',
                         style: TextStyle(
                           fontSize: 14,
                           color: Theme.of(context).hintColor,
                         ),
                       ),
                       items: items
                           .map((String item) => DropdownMenuItem<String>(
                         value: item,
                         child: Text(
                           item,
                           style: const TextStyle(
                             fontSize: 14,
                           ),
                         ),
                       ))
                           .toList(),
                       value: addressValue,
                       onChanged: (String? value) {
                         setState(() {
                           addressValue = value;
                         });
                       },
                       buttonStyleData: const ButtonStyleData(
                         padding: EdgeInsets.symmetric(horizontal: 16),
                         height: 50,
                         width: 140,
                       ),
                       menuItemStyleData: const MenuItemStyleData(
                         height: 40,
                       ),
                     ),
                   ),
                 ),
                 Card(
                   elevation: 4,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton2<String>(
                       isExpanded: true,
                       hint: Text(
                         'Customer',
                         style: TextStyle(
                           fontSize: 14,
                           color: Theme.of(context).hintColor,
                         ),
                       ),
                       items: items2
                           .map((String item) => DropdownMenuItem<String>(
                         value: item,
                         child: Text(
                           item,
                           style: const TextStyle(
                             fontSize: 14,
                           ),
                         ),
                       )).toList(),
                       value: customerValue,
                       onChanged: (String? value) {
                         setState(() {
                           customerValue = value;
                           print('customer valuee ${customerValue}');
                         });
                       },
                       buttonStyleData: const ButtonStyleData(
                         padding: EdgeInsets.symmetric(horizontal: 16),
                         height: 50,
                         width: 140,
                       ),
                       menuItemStyleData: const MenuItemStyleData(
                         height: 40,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
              Column(
                children: [
                 Row(
                   children: [
                     Card(
                       elevation: 4,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton2<String>(
                           isExpanded: true,
                           hint: Text(
                             'Family Member',
                             style: TextStyle(
                               fontSize: 14,
                               color: Theme.of(context).hintColor,
                             ),
                           ),
                           items: items3
                               .map((String item) => DropdownMenuItem<String>(
                             value: item,
                             child: Text(
                               item,
                               style: const TextStyle(
                                 fontSize: 14,
                               ),
                             ),
                           )).toList(),
                           value: familymemberValue,
                           onChanged: (String? value) {
                             setState(() {
                               familymemberValue = value;
                             });
                           },
                           buttonStyleData: const ButtonStyleData(
                             padding: EdgeInsets.symmetric(horizontal: 16),
                             height: 50,
                             width: 140,
                           ),
                           menuItemStyleData: const MenuItemStyleData(
                             height: 40,
                           ),
                         ),
                       ),
                     ),
                     Card(
                       elevation: 4,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButton2<String>(
                           isExpanded: true,
                           hint: Text(
                             'Vehicle',
                             style: TextStyle(
                               fontSize: 14,
                               color: Theme.of(context).hintColor,
                             ),
                           ),
                           items: items4
                               .map((String item) => DropdownMenuItem<String>(
                             value: item,
                             child: Text(
                               item,
                               style: const TextStyle(
                                 fontSize: 14,
                               ),
                             ),
                           )).toList(),
                           value: vehicleValue,
                           onChanged: (String? value) {
                             setState(() {
                               print("vehicle type is ${vehicleValue}");
                               vehicleValue = value;
                               if(vehicleValue == 'thiredparty' ) {
                                 showAlertDialog(
                                   context,
                                   '',
                                   ''
                                   '',
                                 );
                               }
                             });
                           },
                           buttonStyleData: const ButtonStyleData(
                             padding: EdgeInsets.symmetric(horizontal: 16),
                             height: 50,
                             width: 140,
                           ),
                           menuItemStyleData: const MenuItemStyleData(
                             height: 40,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                ],
              ),
              Row(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Code',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items5
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                        value: codeValue,
                        onChanged: (String? value) {
                          setState(() {
                            codeValue = value;
                            print('customer valuee ${codeValue}');
                            if(codeValue == "STAB" || codeValue == "RB" || codeValue == "NORM"){
                              print("working in this codeeee${codeValue == "STAB" || codeValue == "RB" || codeValue == "NORM"}");
                             setState(() {
                               isVisible = true;
                               print("visisble ${isVisible}");
                             });
                            }
                            else{
                              setState(() {
                                isVisible = false;
                                print("visisble ${isVisible}");
                              });
                            }
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2.5,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: Card(
                      elevation: 5,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          _selectDateStart();
                        },
                        controller: dateController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            counterText: "",
                            hintText: 'Select Date',
                            contentPadding: EdgeInsets.only(left: 10)
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Start Date is required";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if(isVisible == true)
                stabDroupDown(),
               SizedBox(height: 10,),
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width/1.1,
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    maxLines:null,
                    maxLength: 100,
                    onTap: () {
                      setState(() {
                      });
                    },
                    controller: remarkCtr,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Remarks Here....',
                      counterText: '',
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              uploadMultiImage(),
              SizedBox(height: 20),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   primary: Color(0xff004276)
                 ),
                  onPressed: () {
                    addFeedbacks();
                  }, child: Text("Submit",)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  String _dateValue = '';
  var dateFormate;
  TimeOfDay? _selectedTime;
  String convertDateTimeDisplay(String date)  {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        dateController = TextEditingController(text: _dateValue);
      });
  }

  List imagePathList = [];
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple:false,
      allowCompression: true,

    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList}");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      // User canceled the picker
    }
  }
  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(


          height: 10,
        ),
        InkWell(
            onTap: () async {
              pickImageDialog(context, 1);

              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 165,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.primary),
                child: Center(
                    child: Text(
                      "Upload Picture",
                      style: TextStyle(color: colors.whiteTemp),
                    )))),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child: imagePathList != null ? buildGridView() : SizedBox.shrink()
        )
      ],
    );
  }
  Widget buildGridView() {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: InkWell(
                  onTap: (){
                    setState((){
                      imagePathList.remove(imagePathList[index]);
                    });

                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 30,
                    color: Colors.red.withOpacity(0.7),),
                ),
              )
            ],
          );
        },
      ),
    );
  }
  void pickImageDialog(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  getFromGallery();
                },
                child:  Container(
                  child: ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: colors.primary,
                      )),
                ),
              ),
              // Container(
              //   width: 200,
              //   height: 1,
              //   color: Colors.black12,
              // ),
              // InkWell(
              //   onTap: () async {
              //     getImage(ImgSource.Camera, context, i);
              //   },
              //   child: Container(
              //     child: ListTile(
              //         title:  Text("Camera"),
              //         leading: Icon(
              //           Icons.camera,
              //           color: colors.primary,
              //         )),
              //   ),
              // ),
            ],
          ),
        );
      },
    );

  }

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        currentDate: selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2025)
    );
    if (picked != null)
      setState(() {
        DateFormat('dd-MM-yyyy').format(selectedDate);
        selectedDate = picked;
        print('Dateeeeeeeee${selectedDate}');
      });
  }

  Future getImage(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      imageQuality:40,
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
    // back();
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    Navigator.pop(context);
    if (i == 1) {
      imagePathList.add(croppedFile!.path);
      setState(() {
        isImages = true;
      });
      print("this is my camera image $imagePathList");
      // imageFile = File(croppedFile!.path);
    }
    back();
  }
}
