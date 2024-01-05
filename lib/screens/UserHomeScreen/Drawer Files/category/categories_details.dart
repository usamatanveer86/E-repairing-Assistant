import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/localdatabase/localdatabase.dart';
import 'package:untitled1/screens/UserHomeScreen/appointment_screen.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../LabTechnicianScreen/chat/chat_detail_page.dart';


class CategoryDetails extends StatefulWidget {
  final String heading;
  CategoryDetails({Key? key, required this.heading}) : super(key: key);

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<String> eventImg = <String>[
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
    "assets/images/study.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        leading:  GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size:appSize.height*0.035 ,)),
        centerTitle: true,
        title: Text(
          widget.heading,
        ),


      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: appSize.height * 0.88 ,
                width: appSize.width,
                decoration: BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: appSize.height * 0.02,
                      ),


                      SizedBox(

                        height: appSize.height*0.86,
                      width: appSize.width,
                      child: StreamBuilder(
                          stream: firebaseFirestore.collection("users").where("Cetagory",isEqualTo: widget.heading).snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {

                              return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 18,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.78),
                                itemBuilder: (context, index) {
                                  var ds=snapshot.data!.docs[index];
                                  return  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentScreen(
                                        id: ds.id,
                                      )));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: appSize.width*0.04,left: appSize.width*0.05,right: appSize.width*0.02 ),

                                      height: appSize.height * 0.285,
                                      width: appSize.width * 0.42,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(color: Colors.grey, blurRadius: 4)
                                          ]),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: appSize.height * 0.18,
                                            width: appSize.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image:
                                                    NetworkImage(ds['imageLink']),
                                                    fit: BoxFit.cover)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.topLeft,
                                                    child: CircleAvatar(
                                                      radius: 5,
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder:(_)=>ChatDetailPage
                                                        (
                                                        receiverId: ds.id,
                                                        receiverImage: ds['imageLink'],
                                                        receiverName: ds['UserName'],
receiverToken: ds.get("token")
                                                      )));
                                                    },
                                                    child: Container(
                                                        height: appSize.height * 0.035,
                                                        width: appSize.width * 0.078,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(7),
                                                          color: Colors.green,
                                                        ),
                                                        child: Icon(
                                                          Icons.message,
                                                          color: Colors.white,
                                                          size: appSize.height * 0.025,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: appSize.height * 0.012,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      launchWhatsApp(message: "hello",phone: ds.get("phoneNumber"));
                                                    },
                                                    child: Container(
                                                        height: appSize.height * 0.035,
                                                        width: appSize.width * 0.078,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(7),
                                                          color: Colors.white,
                                                        ),
                                                        child: Icon(
                                                          Icons.call,
                                                          color: Colors.green,
                                                          size: appSize.height * 0.025,
                                                        )),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width:appSize.width*0.29,
                                                  margin: EdgeInsets.only(
                                                      top: appSize.height * 0.001,left: appSize.width*0.014 ),
                                                  child: Text(
                                                    ds['UserName'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: appSize.width * 0.045,
                                                        fontWeight: FontWeight.w700,
                                                        overflow: TextOverflow.ellipsis),
                                             overflow: TextOverflow.ellipsis,     ),
                                              ),
                                              Spacer(),
                                              Container(
                                                  margin: EdgeInsets.only(top: appSize.height * 0.015),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    ds.get("rating").toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,

                                                        fontSize: appSize.width * 0.038,
                                                        color: Colors.black.withOpacity(.80)
,                                                   overflow: TextOverflow.ellipsis,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(top: appSize.height * 0.015),
                                                child: Icon(Icons.star,color: Colors.orange,size: 18,),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: appSize.height * 0.015),
                                              alignment: Alignment.center,
                                              child: Text(
                                                ds['Address'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: appSize.width * 0.045,
                                                ),
                                              )),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Icon(Icons.error_outline));
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      ),






                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
  void launchWhatsApp(
      { required String phone,
 required String message,
      }) async {
    String url() {
      if (Platform.isAndroid) {
        return "https://wa.me/$phone:/?text=${Uri.parse(message)}";
      } else {
        return "https://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }


}
