import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor,
        title: Text("Notifications",style: TextStyle(
          color: Colors.white,
          fontSize: appSize.width*0.042
        ),),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: appSize.height*0.033,)),
      ),

      body: StreamBuilder(
          stream: firebaseFirestore.collection("notifications")
              .where("receiverId",isEqualTo: firebaseAuth.currentUser!.uid)
              .where("status",isEqualTo: null).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {

              return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var ds=snapshot.data!.docs[index];
                return ds.get("status")==null? GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder:(_)=>ShopDetailScreen()));

                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: appSize.width*0.02,vertical: appSize.height*0.02),
                    height: appSize.height*0.11,
                    width: appSize.width,
                    decoration: BoxDecoration(
                      color: appColor.withOpacity(.40),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height:appSize.height*0.02,),
                        Container(
                          margin: EdgeInsets.only(left:appSize.width*0.04),
                          child: CircleAvatar(
                            backgroundColor: appColor.withOpacity(.40),
                            radius: 20,

                          backgroundImage: NetworkImage(ds.get("senderImage"),
                          ),
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: appSize.width*0.01,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: appSize.height*0.03,left: appSize.width*0.01),
                                    child: Text(ds.get("senderName"),style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)),
                                Container(
                                  width: appSize.width*0.25,
                                  margin: EdgeInsets.only(top: appSize.height*0.01),

                                  child: Text(ds.get("senderEmail"),style: TextStyle(color: Colors.white,fontSize: 13,overflow: TextOverflow.fade,),softWrap: true,overflow: TextOverflow.fade,),
                                ),
                              ],
                            ),



                            InkWell(
                              onTap: (){
                                firebaseFirestore.collection("notifications").doc(ds.id).update({
                                  "status":"Accepted"
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: appSize.width*0.2),
                                child: Icon(Icons.check_circle,color: Colors.white,size: 50,),

                              ),
                            ),
                            SizedBox(width:appSize.width*0.02,),
                            InkWell(
                              onTap: (){
                                firebaseFirestore.collection("notifications").doc(ds.id).update({
                                  "status":"Rejected"
                                });
                              },
                              child: CircleAvatar(

                                backgroundColor: appColor,
                                radius: 22,
                                child: Icon(Icons.close_sharp,color: Colors.white,size: 30,),

                              ),
                            ),

                          ],
                        ),


                      ],
                    ),
                  ),
                ):Container();
              });
            } else if (snapshot.hasError) {
              return Center(child: Icon(Icons.error_outline));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
