import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:http/http.dart'as http;
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/model_all_response/get_user_check_in_out.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TodayCheckInOutScreen extends StatefulWidget {
  const TodayCheckInOutScreen({Key? key, String? title,}) : super(key: key);

  @override
  State<TodayCheckInOutScreen> createState() => _TodayCheckInOutScreenState();
}

class _TodayCheckInOutScreenState extends State<TodayCheckInOutScreen> {


  GetUserCheckInOutModel?getUserCheckInOutModel;
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
    print('user iddddddddddd${uids}');
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   Future.delayed(Duration(milliseconds: 100),(){
     return  getTodaysData();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:colors.primary,
        title: Text('Today Check In Check Out',style: TextStyle(fontSize: 14),),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: getUserCheckInOutModel?.error == true ?
        Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(child: Text("No check in for today", style: TextStyle(fontSize: 18, color: colors.primary, fontWeight: FontWeight.w600))),
        ):
        Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height/1.2,
              child: getUserCheckInOutModel?.data!=null? ListView.builder(
                  itemCount:getUserCheckInOutModel?.data?.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Card(
                        elevation:5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          // height: 45,
                            width: MediaQuery.of(context).size.width /1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:colors.whiteTemp),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width:MediaQuery.of(context).size.width/1 ,
                                  decoration: BoxDecoration(
                                      color: colors.primary,
                                    borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0,top:10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Details :',style: TextStyle(color:colors.whiteTemp,fontSize:17,fontWeight: FontWeight.bold),),
                                        Text('${getUserCheckInOutModel?.data?[index].date}',style: TextStyle(color:colors.whiteTemp,fontSize:17,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Id :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                          // SizedBox(height: 10,),
                                          // Text("Date :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("Check In :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("Check Out :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("Check In Address :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("Check Out Address :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("Time Distance :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                        ],
                                      ),
                                      SizedBox(width:20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${getUserCheckInOutModel?.data?[index].id}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                          // SizedBox(height: 10,),
                                          // Text("${getUserCheckInOutModel?.data[index].date}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("${getUserCheckInOutModel?.data?[index].checkin}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Text("${getUserCheckInOutModel?.data?[index].checkout}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                          SizedBox(height: 10,),
                                          Container(
                                              width: 160,
                                              child: Text("${getUserCheckInOutModel?.data?[index].checkinAddress}",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),)),
                                          SizedBox(height: 10,),
                                          Container(
                                              width:160,
                                              child: Text("${getUserCheckInOutModel?.data?[index].checkoutAddress}",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),)),
                                          SizedBox(height: 10,),
                                          Text("${getUserCheckInOutModel?.data?[index].timedistance}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                        ),
                      ),
                    );
                  }):Center(child: CircularProgressIndicator())
            ),
          ],
        ),
      ),
    );
  }
}
