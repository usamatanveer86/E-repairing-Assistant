import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/LabTechnicianScreen/chat/components/chat_detail_page_appbar.dart';


import 'package:untitled1/utils/colors.dart';

import '../../../main.dart';
import '../../../utils/constant.dart';
import '../../../utils/notificationapi.dart';


enum MessageType{
  Sender,
  Receiver,
}

int _messageCount = 0;

class ChatDetailPage extends StatefulWidget{

  String receiverName;
  String receiverId;
  String receiverImage;
String receiverToken;
  ChatDetailPage({required this.receiverId,required this.receiverName,required this.receiverImage,required this.receiverToken});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with WidgetsBindingObserver{

  void showModal(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height/2,
          color: Color(0xff737373),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade200,
                  ),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        );
      }
    );
  }
  TextEditingController messageController=TextEditingController();
  ScrollController scrollController = ScrollController();
  String groupChatId="";
String senderName="";
// String receiverToken="";
String status="";
  @override
  void initState() {
    // TODO: implement initState
   if (firebaseAuth.currentUser!.uid.hashCode <= widget.receiverId.hashCode) {
     groupChatId = "${firebaseAuth.currentUser!.uid}-${widget.receiverId}";
   } else {
     groupChatId = "${widget.receiverId}-${firebaseAuth.currentUser!.uid}";
   }
    super.initState();
print(widget.receiverToken);
print("hdgddddddddddddddd");
   WidgetsBinding.instance!.addObserver(this);
   setStatus("online");
   super.initState();

   firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((value){
 senderName= value.get("UserName");
status=value.get("status");
   });
   print(_messageCount);
  }
  void setStatus(String status )async{
    await firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).update({
      "status":status
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state==AppLifecycleState.resumed){
      setStatus("online");
    }
    else{
      setStatus("offline");
    }
  }

  @override
  Widget build(BuildContext context) {
  var appSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar: ChatDetailPageAppBar(
        receiverName: widget.receiverName,
        receiverImage: widget.receiverImage,
        receiverId: widget.receiverId,
        status: status,
      ),
      body: ListView(
        children: <Widget>[
          Container(

          height: appSize.height*0.8,
            width: appSize.width,
            child: StreamBuilder(
                stream: firebaseFirestore.collection("messages").doc(groupChatId).collection(groupChatId)
                    .orderBy("timestamp",descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length==0?Center(child: Text("Emphty")): ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      controller: scrollController,
shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      itemBuilder: (context, index){
                        var ds=snapshot.data!.docs[index];
                        return Container(
                          padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                          child: Align(
                            alignment: (ds['senderId'] == widget.receiverId?Alignment.topLeft:Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: (ds['senderId'] == widget.receiverId ?Colors.white:Colors.grey.shade200),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(ds['content']),
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
          Container(
            padding: EdgeInsets.only(left: 16,bottom: 10,top: 10),
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16,),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 30,bottom: 10),
                  child: FloatingActionButton(
                    onPressed: (){
                      sendMessage(messageController.text.trim(), 0);
                      // NotificationApi.ShowNotification(body: "dkjhdhd",title: "kjdh");
                    // sendPushMessage(title: token,body: "hgd", token1: token);
                    // print(token);
                    },
                    child: Icon(Icons.send,color: Colors.white,),
                    backgroundColor:appColor,
                    elevation: 0,
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      messageController.clear();

      var documentReference = firebaseFirestore
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      firebaseFirestore.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": firebaseAuth.currentUser!.uid,
            "receiverId": widget.receiverId,
            "time": DateTime.now(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      }).then((value) {
        sendPushMessage(title: senderName,body: content);
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload({ String? title, String? body}) {
    _messageCount++;

    return jsonEncode({
      'registration_ids': [widget.receiverToken],
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': title,
        'body': body,
      }
    });
  }

  Future<void> sendPushMessage({ String? title,String? body}) async {
    if (widget.receiverToken == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':"key=AAAApzieTqI:APA91bGVKq2Er29M_5aG8aimSK5IX59o3smz6eyojjd5WNEVkzUtdDTEk2-YeGMWKX_LNFIE_eLKP1XAu7Pgw_j_9m0xj8QRG8OQppscOxmBJJWEWxdpIORM90aeN2Z9UmdGdvgx5Dbi",
        },
        body: constructFCMPayload(body: body,title: title),
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FCM request for device sent!')));
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}