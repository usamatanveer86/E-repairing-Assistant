import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';

import '../../LabTechnicianScreen/chat/chat_detail_page.dart';




class MyPostScreen extends StatefulWidget {
  MyPostScreen({Key? key}) : super(key: key);

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  TextEditingController commentController=TextEditingController();
String userName="";
String userImage="";
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
 firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((value){
  userName= value.get("UserName");
 userImage=value.get("imageLink");
 });
 } @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: backgroundColor,

      body: Padding(
        padding: EdgeInsets.only(
            left: appSize.width * 0.04, right: appSize.width * 0.04),
        child: SizedBox(
          height: appSize.height*0.9,
          width: appSize.width,
          child: StreamBuilder(
              stream: firebaseFirestore.collection("posts").where("UserId",isEqualTo:firebaseAuth.currentUser!.uid ).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        var ds=snapshot.data!.docs[index];
                        return Container(
                          margin: EdgeInsets.only(top: appSize.height*0.02),
                          height: appSize.height*0.59,

                          width: appSize.width*0.9,

                          decoration: BoxDecoration(

                              color: Colors.white,

                              boxShadow: [

                                BoxShadow(

                                    color: Colors.grey,

                                    blurRadius: 2

                                )

                              ]

                          ),
                          child: Padding(

                            padding:  EdgeInsets.only(top: appSize.height*0.01),

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Row(

                                  children: [

                                    SizedBox(width: appSize.width*0.01,),

                                    CircleAvatar(

                                      backgroundColor: Colors.blueGrey.withOpacity(.30),

                                      radius: 23,

                                      backgroundImage: NetworkImage(ds['UserImage']),

                                    ),

                                    SizedBox(width: appSize.width*0.01,),

                                    Text(ds['UserName'],style: TextStyle(

                                        color: Colors.black,

                                        fontWeight: FontWeight.w500

                                    ),)

                                  ],

                                ),

                                Padding(

                                  padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01),

                                  child: Text(ds['description'],style: TextStyle(

                                      color: Colors.black,

                                      fontSize: appSize.width*0.04,

                                      fontWeight: FontWeight.w300

                                  ),textAlign: TextAlign.left,),

                                ),



                                Container(

                                  margin: EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.02 ),

                                  height: appSize.height*0.2,

                                  width: appSize.width,

                                  decoration: BoxDecoration(

                                      image: DecorationImage(

                                          image: NetworkImage(ds['imageLink']),fit: BoxFit.cover

                                      )

                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatDetailPage(
                                        receiverName: ds.get("UserName"),
                                        receiverImage: ds.get("UserImage"),
                                        receiverId: ds.get("UserId"),
                                        receiverToken: ds.get("token"),
                                      )));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right:appSize.width*0.02,top: appSize.height*0.01),
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.chat,color: Colors.white,size: appSize.height*0.035,)),
                                  ),
                                ),

                                SizedBox(height: appSize.height*0.01,),



                                Padding(

                                  padding:  EdgeInsets.only(left: appSize.width*0.04,right: appSize.width*0.04,top: appSize.height*0.01),

                                  child: Row(

                                    children: [

                                      Container(



                                        height: appSize.height*0.06,

                                        width: appSize.width*0.65,

                                        child: TextFormField(
                                          controller: commentController,
                                          style: TextStyle(color: Colors.black),

                                          //     controller: _email,

                                          decoration: InputDecoration(

                                            hintText: 'Comment',hintStyle: TextStyle(color: Colors.grey),

                                            //  suffixIcon: Icon(Icons.phone,color: Colors.grey,),suffixStyle: TextStyle(color: Colors.grey),

                                            border: OutlineInputBorder(

                                              borderSide: BorderSide(color: Colors.grey,width: 1.5),

                                              borderRadius: BorderRadius.circular(7.0),

                                            ),

                                            enabledBorder: OutlineInputBorder(

                                                borderSide: BorderSide(color: Colors.grey,width: 1.5),

                                                borderRadius: BorderRadius.circular(7.0)

                                            ),

                                            focusedBorder: OutlineInputBorder(

                                                borderSide: BorderSide(color: Colors.grey,width: 1.5),

                                                borderRadius: BorderRadius.circular(7.0)

                                            ),

                                          ),





                                        ),

                                      ),

                                      SizedBox(width: appSize.width*0.04,),

                                      InkWell(
                                        onTap: (){
                                          if(commentController.text.isNotEmpty){
                                            firebaseFirestore.collection("comments").add({
                                              "postId":ds.id,
                                              'userId':firebaseAuth.currentUser!.uid,
                                              "content":commentController.text,
"userName":userName,
                                              "userImage":userImage,
                                              "time":DateTime.now()
                                            }).then((value) {
                                              FocusScope.of(context).unfocus();
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: appSize.width*0.01),

                                          height: appSize.width*0.11,

                                          width: appSize.width*0.12,



                                          decoration: BoxDecoration(

                                            color: Colors.grey.withOpacity(.30),

                                            borderRadius: BorderRadius.circular(7.0),

                                          ),

                                          child: Icon(Icons.send,color: Colors.white,),

                                        ),
                                      )

                                    ],

                                  ),

                                ),
                                Divider(

                                  color: Colors.grey,

                                  thickness: 1,



                                ),
                                Flexible(
                                  child: StreamBuilder(
                                      stream: firebaseFirestore.collection("comments").where("postId",isEqualTo: ds.id).snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> asnapshot) {
                                        if (asnapshot.hasData) {

                                          return asnapshot.data!.docs.length==0?Center(child: Text("No Comments")): ListView.builder(
itemCount: asnapshot.data!.docs.length,
  reverse: true,
                                              itemBuilder: (context, i) {

                                                var ds1=asnapshot.data!.docs[i];
                                            return Row(
                                              children: [
                                                SizedBox(width: appSize.width*0.01,),

                                                CircleAvatar(

                                                  backgroundColor: Colors.blueGrey.withOpacity(.30),

                                                  radius: 23,

                                                  backgroundImage: NetworkImage(ds1['userImage']),

                                                ),

                                                SizedBox(width: appSize.width*0.02,),
                                                Container(
                                                    margin: EdgeInsets.only(top: appSize.height*0.02),
                                                    alignment: Alignment.topLeft,

                                                    width: appSize.width*0.5,

                                                    decoration: BoxDecoration(
                                                        color: Colors.grey.withOpacity(.30),
                                                        borderRadius: BorderRadius.circular(12)
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.only(top: appSize.height*0.02,left: appSize.width*0.015,bottom: appSize.height*0.005),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(ds1.get("userName"),style: TextStyle(

                                                              color: Colors.black,

                                                              fontWeight: FontWeight.w800

                                                          ),),
                                                          SizedBox(height: appSize.height*0.01,),
                                                          Text(ds1.get("content"),style: TextStyle(

                                                              color: Colors.black,

                                                              fontWeight: FontWeight.w300

                                                          ),),
                                                        ],
                                                      ),
                                                    )
                                                ),



                                              ],

                                            );
                                          });
                                        } else if (asnapshot.hasError) {
                                          return Center(child: Icon(Icons.error_outline));
                                        } else {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                      }),
                                )
                              ],

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

        ),
      ),
    );
  }
}
