
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';

import '../../LabTechnicianScreen/Drawer Files/reviewscreen.dart';


class UserCompletedScreen extends StatelessWidget {
  UserCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
   
        body: Column(
            children: [

              SizedBox(
                height: appSize.height * 0.03,
              ),
              SizedBox(
              height: appSize.height*0.8,
                width: appSize.width,
                child: StreamBuilder(
          stream: firebaseFirestore.collection("notifications").where("senderId",isEqualTo: firebaseAuth.currentUser!.uid).where("status",isEqualTo: "Completed").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
                return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
var ds=snapshot.data!.docs[index];
                  return               GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>RatingScreen(
                        id: ds.get("receiverId"),
                      )));
                    },
                    child: Container(
                      height: appSize.height*0.29,
                      width: appSize.width*0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey
                            )
                          ]
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              height: appSize.height*0.18,
                              width: appSize.width,
                              decoration: BoxDecoration(

                                  image: DecorationImage(
                                      image: NetworkImage(ds.get("userImage")),fit: BoxFit.cover
                                      
                                  )
                              ),
                            ),
                            SizedBox(height: appSize.height*0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name",style: TextStyle(

                                    color: Colors.black,

                                    fontWeight: FontWeight.w500,
                                    fontSize: appSize.width*0.042

                                ),),
                                Text(ds.get("name"),style: TextStyle(

                                    color: Colors.black,

                                    fontWeight: FontWeight.w300,
                                    fontSize: appSize.width*0.035

                                ),),
                              ],
                            ),
                            SizedBox(height: appSize.height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email",style: TextStyle(

                                    color: Colors.black,

                                    fontWeight: FontWeight.w500,
                                    fontSize: appSize.width*0.042

                                ),),
                                Text(ds.get("email"),style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: appSize.width*0.035

                                ),),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                });
            } else if (snapshot.hasError) {
                return Center(child: Icon(Icons.error_outline));
            } else {
                return Center(child: CircularProgressIndicator());
            }
          }),
              )
    ]
        )


    );
  }
}
