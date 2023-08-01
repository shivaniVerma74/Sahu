import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omega_employee_management/model_all_response/GetfaadbackModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Color.dart';
import '../../model_all_response/get_leads_status_model.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {

  String? lead_id;
  @override
  void initState() {
    super.initState();
    getfeedBacks();
    myLeadId();
  }

  myLeadId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    lead_id = preferences.getString('lead_id');
    print("lead datata isssss ${lead_id}");
  }

  GetfaadbackModel? getfeedback;
  bool? isLoading = true;
  getfeedBacks() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    lead_id = preferences.getString('lead_id');
    isLoading=true;

    var headers = {
      'Cookie': 'ci_session=9a220d46d663edd8947d53176fcc51a0594be97b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_lead_feedback'));
    request.fields.addAll({
      'lead_id': '${lead_id}'
    });
    print("lead datata in feedbackkkkk ${lead_id}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = GetfaadbackModel.fromJson(json.decode(Response));
      print("Aaaaaaaaaaaaaaaaaaaa ${Response}");
      setState(() {
        getfeedback = finalResponse;
      });
      setState(() {
        isLoading=false;
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
        title: Text("My Feedbacks", style: TextStyle(fontSize: 15)),
      ),
      body: SingleChildScrollView(
        child: getfeedback?.error == true ? Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(child: Text("No Feedback Found", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),)),
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // getfeedback?.data?.length == null || getfeedback?.data?.length == "" ? Center(child: CircularProgressIndicator(color: colors.primary,),):
            Container(
              height:MediaQuery.of(context).size.height/1.2,
              child: ListView.builder(
                  itemCount:getfeedback?.data==null||getfeedback?.data==""?0: getfeedback?.data?.length,
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
                            Container(
                                height: 200,
                                width:MediaQuery.of(context).size.width/1,
                                child: Image.network('${getfeedback?.data?[index].image}',fit: BoxFit.fill,)),
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
                                      SizedBox(height: 12,),
                                      Text("Customer Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                      SizedBox(height: 12,),
                                      Text("Customer:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Family Member:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Mobile :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Code:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Code Type:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("User Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Vehicle:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                      SizedBox(height: 10,),
                                      Text("Address:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${getfeedback?.data?[index].bankName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].customername}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].customer}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].familyMember}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].mobile}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].code}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].codeType}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].name}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].username}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].vechile}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      Text("${getfeedback?.data?[index].address}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                      SizedBox(height: 12),
                                      // SizedBox(height: 10,),
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
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
