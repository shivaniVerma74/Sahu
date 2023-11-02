import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import '../../Helper/Color.dart';
import '../../Helper/String.dart';
import '../../model_all_response/get_leads_model.dart';
import '../Model/BankDetailsModel.dart';
import 'AllLeadsDetails.dart';

class BankLeads extends StatefulWidget {
  BankData? bankModel;
  BankLeads({Key? key, this.bankModel}) : super(key: key);

  @override
  State<BankLeads> createState() => _BankLeadsState();
}

class _BankLeadsState extends State<BankLeads> {
 TextEditingController searchCtr = TextEditingController();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getLeads();
  }

  GetLeadsModel? getLeadData;
  List <LeadsData> leadData = [];
  bool isLoading = true;

  getLeads() async {
    setState(() {
      isLoading=true;
    });
    var headers = {
      'Cookie': 'ci_session=e739bf3509ae8bb7102d8891dd88233ab61f48ff'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/get_leads'));
    request.fields.addAll({
      'user_id':'${CUR_USERID}',
      'search':"${widget.bankModel?.bankName}"
    });
    print("paraaa ${request.fields}");
    // print(Uri.parse("https://alphawizzserver.com/sahu/app/v1/api/get_leads?user_id=${CUR_USERID}&search=${widget.bankModel?.bankName.toString()}"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      print(Result);
      final finalResult = GetLeadsModel.fromJson(json.decode(Result));
      // print("woirkinhjjj ${finalResult}");
      setState(() {
        getLeadData = finalResult;
        leadData = getLeadData?.data ?? [];
      });
      print("get leadsss datata${leadData}");
      setState(() {
        isLoading=false;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  searchLeads1(String value) {
    if (value.isEmpty) {
      getLeads();
      setState(() {});
    }else{
      final suggestions = leadData.where((element) {
        final leadsTitle = element.customername.toString().toLowerCase();
        final leadsPhone = element.phone1.toString().toLowerCase();
        final leadsId = element.agreementid.toString().toLowerCase();
        final input = value.toLowerCase();
        return leadsTitle.contains(input) || leadsPhone.contains(input) || leadsId.contains(input)  ;
      }).toList();
      leadData = suggestions;
      setState(() {
      });
    }
  }

 _callNumber(String? mobileNumber) async {
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
        title: Text("Bank Leads", style: TextStyle(fontSize: 15)),
      ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                height:50,
                padding: EdgeInsets.only(left:15,right:15),
                child: TextFormField(
                  onChanged: (value){
                    searchLeads1(value);
                  },
                  controller: searchCtr,
                  decoration: InputDecoration(
                      suffixIcon: Container(
                          width: 20,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                          child: Icon(
                              Icons.search, color: Colors.white)),
                      hintText: "Search here",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
              ),
               SizedBox(height: 10),
              // isLoading == true ? CircularProgressIndicator(color: colors.primary,) :
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.3,
                        child: ListView.builder(
                            itemCount: leadData.length == null || leadData.length==""?0 : leadData.length,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllLeadsDetails(model: getLeadData!.data![index])));
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
                                                  Text("Bank Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                                  SizedBox(height: 12,),
                                                  Text("Customer Name:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:colors.blackTemp),),
                                                  SizedBox(height: 10,),
                                                  Text("Bucket :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                                  SizedBox(height: 10,),
                                                  SizedBox(height: 10,),
                                                  Text("Caller :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                                  SizedBox(height: 10,),
                                                  Text("Principal Outstanding", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                                  SizedBox(height: 10,),
                                                  Text("Agreement Id", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                                  SizedBox(height: 10,),
                                                  Text("Phone 1:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${leadData[index].bankName}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  Text("${leadData[index].customername}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  Text("${leadData[index].bomBkt}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  Text("${leadData[index].caller}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  Text("${leadData[index].principalOutstanding}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  Text("${leadData[index].agreementid}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),),
                                                  SizedBox(height: 12),
                                                  InkWell(
                                                    onTap: () {
                                                      _callNumber(leadData[index].phone1);
                                                    },
                                                      child: Text("${leadData[index].phone1}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: colors.blackTemp),)),
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
                                        Container(
                                          width:MediaQuery.of(context).size.width/1.2,
                                          child: Divider(
                                            color: colors.primary,
                                            height:15,
                                            thickness: 1,
                                          ),
                                        ),
                                        // SizedBox(height: 10,),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: () {
                                        //         getUserCheckIn();
                                        //       },
                                        //       child: Container(
                                        //         height:40,
                                        //         width:150,
                                        //         decoration: BoxDecoration(
                                        //           color:colors.primary,
                                        //           borderRadius: BorderRadius.circular(7),
                                        //         ),
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(top:10.0),
                                        //           child: Text('Check In',style: TextStyle(color: colors.whiteTemp),textAlign: TextAlign.center,),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 10,),
                                        //     InkWell(
                                        //       onTap: () {
                                        //       CheckOut();
                                        //       },
                                        //       child: Container(
                                        //         height:40,
                                        //         width:150,
                                        //         decoration: BoxDecoration(
                                        //           color:colors.secondary,
                                        //           borderRadius: BorderRadius.circular(7),
                                        //         ),
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(top:10.0),
                                        //           child: Text('Check Out',style: TextStyle(color: colors.whiteTemp),textAlign: TextAlign.center,),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
