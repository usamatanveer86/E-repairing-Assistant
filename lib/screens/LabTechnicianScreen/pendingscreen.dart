
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';


class PendingclientScreen extends StatelessWidget {
  PendingclientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appColor,
          title: Text("Pending",style: TextStyle(
              color: Colors.white,
              fontSize: appSize.width*0.042
          ),),
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: appSize.height*0.033,)),
        ),
      body: Column(
        children: [

          SizedBox(
            height: appSize.height * 0.03,
          ),
          SizedBox(
            height: appSize.height*0.8,
            width: appSize.width,
            child: StreamBuilder(
                stream: firebaseFirestore.collection("notifications").where("receiverId",isEqualTo: firebaseAuth.currentUser!.uid).where("status",isEqualTo: "Accepted").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                      var ds=snapshot.data!.docs[index];
                      return Container(
                        margin:         EdgeInsets.only(
                      left: appSize.width * 0.04, right: appSize.width * 0.04),

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

                        child: Column(
                          children: [
                            Container(
                              height: appSize.height*0.17,
                              width: appSize.width,
                              decoration: BoxDecoration(

                                  image: DecorationImage(
                                      image: NetworkImage(ds.get("senderImage")),fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ds.get("name"),style: TextStyle(

                                    color: Colors.black,

                                    fontWeight: FontWeight.w500,
                                    fontSize: appSize.width*0.042

                                ),),
                                Text(ds.get("phoneNumber"),style: TextStyle(
                                  

                                    color: Colors.black,

                                    fontWeight: FontWeight.w300,
                                    fontSize: appSize.width*0.035

                                ),),
                              ],
                            ),
                            SizedBox(height: appSize.height*0.02,),
                            Container(
                              width: appSize.width,

                                alignment: Alignment.topLeft,
                                child: Text(   ds.get("description") )),
                            SizedBox(height: appSize.height*0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                            onTap:(){
                              firebaseFirestore.collection("notifications").doc(ds.id).update({
                                "status":"Discarded"
                              });
                            },
                                  child: Container(
                                    alignment: Alignment.center,

                                    height: appSize.height*0.06,
                                    width: appSize.width*0.3,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: appColor),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Text("Discard",style: TextStyle(

                                        color: appColor,

                                        fontWeight: FontWeight.w500,
                                        fontSize: appSize.width*0.042

                                    ),),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    firebaseFirestore.collection("notifications").doc(ds.id).update({
                                      "status":"Completed"
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,

                                    height: appSize.height*0.06,
                                    width: appSize.width*0.3,
                                    decoration: BoxDecoration(
                                        color: appColor,
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Text("Complete",style: TextStyle(

                                        color: Colors.white,

                                        fontWeight: FontWeight.w500,
                                        fontSize: appSize.width*0.042

                                    ),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: appSize.height*0.01,)
                          ],
                        ),
                      );
                    });
                  } else if (snapshot.hasError) {
                    return Center(child: Icon(Icons.error_outline));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          SizedBox(
            height: appSize.height * 0.03,
          ),
         ]
          )


    );
  }
}
