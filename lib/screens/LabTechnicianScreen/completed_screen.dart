
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';


class CompletedScreen extends StatelessWidget {
  CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appColor,
          title: Text("Completed ",style: TextStyle(
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
              SizedBox(height: appSize.height*0.8,
              width: appSize.width,
              child: StreamBuilder(
                stream: firebaseFirestore.collection("notifications").where("receiverId",isEqualTo: firebaseAuth.currentUser!.uid).where("status",isEqualTo: "Completed").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          var ds=snapshot.data!.docs[index];
                          return Container(
                            margin: EdgeInsets.only(left: appSize.width*0.04,right: appSize.width*0.04,bottom: appSize.height*0.04),

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
                                      image: NetworkImage(ds.get("senderImage")),fit: BoxFit.cover
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
                            SizedBox(height: appSize.height*0.01,),
                            Container(
                                width: appSize.width,

                                alignment: Alignment.topLeft,
                                child: Text(   "Description",style: TextStyle(color: Colors.black,fontSize: appSize.width*0.037,fontWeight: FontWeight.bold),)),
                            SizedBox(height: appSize.height*0.01,),
                            Container(
                                width: appSize.width,

                                alignment: Alignment.topLeft,
                                child: Text(   ds.get("description") )),


                          ],
                        ),
                      ),
                    );});
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
