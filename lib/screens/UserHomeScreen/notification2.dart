import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';


class UserNotificationScreen extends StatefulWidget {
  @override
  _UserNotificationScreenState createState() => _UserNotificationScreenState();
}

class _UserNotificationScreenState extends State<UserNotificationScreen> {
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
          stream: firebaseFirestore.collection("notifications").where("senderId",isEqualTo: firebaseAuth.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                reverse: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
              var ds=snapshot.data!.docs[index];
                return ds.get("status")!=null? Column(
                  children: [

                    SizedBox(height:appSize.height*0.01,),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(ds.get("userImage")),

                      ),
                      title: Text("Your appointment has been ${ds.get("status")}",style: TextStyle(
                          color: Colors.black,
                          fontSize: appSize.width*0.035
                      ),),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
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
