import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../Model/FoscollectionModel.dart';

class FosCollection extends StatefulWidget {
  const FosCollection({Key? key}) : super(key: key);

  @override
  State<FosCollection> createState() => _FosCollectionState();
}

class _FosCollectionState extends State<FosCollection> {

 @override
 initState() {
   super.initState();
   collectionAmount();
 }
  bool isLoading = true;
  FoscollectionModel? foscollectionModel;
  List<CollectionData> collectionData = [];

  collectionAmount() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=c2f6d65d231bb09a25b69b42d7f113f4f517913c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://alphawizzserver.com/sahu/app/v1/api/collection_list'));
    request.fields.addAll({
    'fos_id': '${uids}'
    });
    print("fos collection is ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      print(Result);
      final finalResult = FoscollectionModel.fromJson(json.decode(Result));
      // print("woirkinhjjj ${finalResult}");
      setState(() {
        foscollectionModel = finalResult;
        collectionData = foscollectionModel?.data ?? [];
      });
      // print("get leadsss datata${}");
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
        backgroundColor: colors.primary,
        centerTitle: true,
        elevation: 0,
        title: Text("FOS Collection"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            foscollectionModel?.data?.length == null || foscollectionModel?.data?.length == "" ? Center(child: Text("No Data Found", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),))
            :Container(
              // height: MediaQuery.of(context).size.height/0.,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: foscollectionModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height:10),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 10,top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.only(left:5.0,right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Amount :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: colors.blackTemp),),
                                          Text("${foscollectionModel?.data?[index].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:10,),
                                    Padding(
                                      padding: const EdgeInsets.only(left:5.0,right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Remarks :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                                          Text("${foscollectionModel?.data?[index].remarks}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left:5.0,right: 5),
                                      child: Row (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Status :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
                                          Text("${foscollectionModel?.data?[index].statusText}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0,top:15),
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width/1.085,
                              decoration: BoxDecoration(
                                color: colors.primary,
                                border: Border.all(color: colors.secondary),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left:5.0,right: 5),
                                child: Row (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Collection Date :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),),
                                    Text("${foscollectionModel?.data?[index].createdAt}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },),
            ),
          ],
        ),
      )
    );
  }
}
