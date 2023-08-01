import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../model_all_response/GetFtdModel.dart';
import '../model_all_response/GetReportModel.dart';
import '../model_all_response/GetStandingModel.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  @override
  void initState() {
    super.initState();
    getReport();
    getFtdReports();
    getStandingReport();
  }

  GetFtdModel? getFtdModel;
  getFtdReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=f7f558efca353424a5fef9a0ea2e9392efbabc4d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_ftd_report'));
    request.fields.addAll({
      'user_id': '${uids}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = GetFtdModel.fromJson(json.decode(Response));
      print("get report responsee ${Response}");
      setState(() {
        getFtdModel = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetReportModel? getReportModel;
  getReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=f7f558efca353424a5fef9a0ea2e9392efbabc4d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_pos_report'));
    request.fields.addAll({
      'user_id': '${uids}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = GetReportModel.fromJson(json.decode(Response));
      print("get report responsee ${Response}");
      setState(() {
        getReportModel = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text("Reports", style: TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            customTabbar(),
            SizedBox(height: 10,),
            _currentIndex==1?
            dRRView():
            _currentIndex == 2?
            ftdView():
            _currentIndex == 3 ?
            standingView() :SizedBox(),
          ],),
      ),
    );
  }

  Widget dRRView() {
    return  Column(
      children: [
        getReportModel?.data==null||getReportModel?.data==""? Center(child: CircularProgressIndicator()):Container(
          height:MediaQuery.of(context).size.height/1.3,
          child: ListView.builder(
              itemCount: getReportModel?.data==null || getReportModel?.data==""? 0 :getReportModel?.data?.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AllLeadsDetails(model: getLeadData!.data![index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
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
                                    Text("Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("BKT:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Total Leads:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Count Day Wise:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("POS Day Wise:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${getReportModel?.data?[index].name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getReportModel?.data?[index].userId}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getReportModel?.data?[index].totalLeads}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getReportModel?.data?[index].countDayWise}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getReportModel?.data?[index].posDayWise}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget ftdView() {
    return getFtdModel?.error == true ? Padding(
      padding: const EdgeInsets.only(top: 250),
      child: Center(child: Text("No Report found !", style: TextStyle(fontWeight: FontWeight.w500),)),
    ):
    Column(
      children: [
        getFtdModel?.data==null||getFtdModel?.data==""?Center(child: CircularProgressIndicator()):Container(
          height:MediaQuery.of(context).size.height/1.3,
          child: ListView.builder(
              itemCount: getFtdModel?.data==null||getFtdModel?.data==""?0: getFtdModel?.data?.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AllLeadsDetails(model: getLeadData!.data![index])));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
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
                                    Text("Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("Total Leads:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                    SizedBox(height: 10,),
                                    Text("POS:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${getFtdModel?.data?[index].name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getFtdModel?.data?[index].totalLeads}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                    SizedBox(height: 10),
                                    Text("${getFtdModel?.data?[index].pos}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget standingView() {
    return  getStandingModel?.error == true? Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Center(child: Text("No Found Report", style: TextStyle(fontWeight: FontWeight.w600),)),
    ):
    Column(
      children: [
        getStandingModel?.data==null||getStandingModel?.data==""?Center(child: CircularProgressIndicator()):Container(
          height:MediaQuery.of(context).size.height/1.3,
          child: ListView.builder(
              itemCount:getStandingModel?.data==null||getStandingModel?.data==""?0: getStandingModel?.data?.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10),
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
                                  Text("Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                  SizedBox(height: 10,),
                                  Text("BKT:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  SizedBox(height: 10,),
                                  Text("Paid:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  SizedBox(height: 10,),
                                  Text("PPTP:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  SizedBox(height: 10,),
                                  Text("RB:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                  SizedBox(height: 10,),
                                  Text("PRB:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${getStandingModel?.data?[index].name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                  SizedBox(height: 10),
                                  Text("${getStandingModel?.data?[index].bomBkt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                  SizedBox(height: 10),
                                  Text("${getStandingModel?.data?[index].paid}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  SizedBox(height: 10),
                                  Text("${getStandingModel?.data?[index].pptp}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  SizedBox(height: 10),
                                  Text("${getStandingModel?.data?[index].rb}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                  SizedBox(height: 10),
                                  Text("${getStandingModel?.data?[index].prb}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }


  int _currentIndex = 1;
  customTabbar(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 1 ?
                  colors.primary : colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)
              ),
              height: 40,
              width: 85,
              child: Center(
                child: Text("DRR",style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp)),
              ),
            ),
          ),
          SizedBox(width: 15,),
          InkWell(
            onTap: (){
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 2 ?
                  colors.primary : colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)
              ),
              height: 40,
              width: 85,
              child: Center(
                child: Text("FTD",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp)),
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 3;
                // isReport = true;
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen()));
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 3 ?
                    colors.primary : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)
                ),
                // width: 120,
                height: 40,
                width: 85,
                child: Center(
                  child: Text("Standing",style: TextStyle(color: _currentIndex == 3 ? colors.whiteTemp:colors.blackTemp),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GetStandingModel? getStandingModel;
  getStandingReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=f54c0529687a70d543348ff9361634dd5307fe68'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_standing_report'));
    request.fields.addAll({
      'user_id': '${uids}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = GetStandingModel.fromJson(json.decode(Response));
      print("get report responsee ${Response}");
      setState(() {
        getStandingModel = finalResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
