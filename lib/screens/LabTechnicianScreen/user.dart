import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/LabTechnicianScreen/chat/chat_detail_page.dart';
import 'package:untitled1/utils/constant.dart';
class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}
class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: firebaseFirestore.collection("users").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return  ListView.builder(
                reverse: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
              var ds=snapshot.data!.docs[index];
                return ds.id==firebaseAuth.currentUser!.uid?Container():Column(
                    children: [

                      SizedBox(height: appSize.height*0.02,),
                      ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatDetailPage(
receiverId: ds.id,
                            receiverImage: ds['imageLink'],
                            receiverName: ds['UserName'],
                            receiverToken: ds['token'],
                          )));
                        },
                        leading: CircleAvatar(
backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(ds['imageLink']),
                        ),
                        title: Text(ds['UserName'],style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing:Icon(Icons.chat,color: Colors.blue,),

                      ),
                      Divider(
                        color: Colors.grey,
                      ),


                    ]
                );
              });
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
