import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/LabTechnicianScreen/pendingscreen.dart';

import 'package:untitled1/utils/colors.dart';

import '../../utils/constant.dart';
import 'chat/chat_detail_page.dart';
import 'completed_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController commentController = TextEditingController();
  String userName = "";
  String userImage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      userName = value.get("UserName");
      userImage = value.get("imageLink");
    });
  }

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldpop = await showMyDialog();
        return shouldpop ?? false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
            padding: EdgeInsets.only(
                left: appSize.width * 0.04, right: appSize.width * 0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: appSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PendingclientScreen()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: appSize.height * 0.15,
                          width: appSize.width * 0.4,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Pending",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: appSize.width * 0.042),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CompletedScreen()));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: appSize.height * 0.15,
                            width: appSize.width * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: appSize.width * 0.042),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: appSize.height * 0.7,
                    width: appSize.width,
                    child: StreamBuilder(
                        stream:
                            firebaseFirestore.collection("posts").snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.docs.isEmpty
                                ? const Text("Empty")
                                : ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var ds = snapshot.data!.docs[index];
                                      return SingleChildScrollView(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: appSize.height * 0.02),
                                          height: appSize.height * 0.69,
                                          width: appSize.width * 0.9,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 2)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: appSize.height * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          appSize.width * 0.01,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: Colors
                                                          .blueGrey
                                                          .withOpacity(.30),
                                                      radius: 23,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              ds['UserImage']),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          appSize.width * 0.01,
                                                    ),
                                                    Text(
                                                      ds['UserName'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          appSize.width * 0.02,
                                                      right:
                                                          appSize.width * 0.02,
                                                      top: appSize.height *
                                                          0.01),
                                                  child: Text(
                                                    ds['description'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            appSize.width *
                                                                0.04,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          appSize.width * 0.02,
                                                      right:
                                                          appSize.width * 0.02,
                                                      top: appSize.height *
                                                          0.02),
                                                  height: appSize.height * 0.28,
                                                  width: appSize.width,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              ds['imageLink']),
                                                          fit: BoxFit.fill)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      firebaseFirestore
                                                          .collection("users")
                                                          .doc(ds.get("UserId"))
                                                          .get()
                                                          .then((value) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    ChatDetailPage(
                                                                      receiverName:
                                                                          ds.get(
                                                                              "UserName"),
                                                                      receiverImage:
                                                                          ds.get(
                                                                              "UserImage"),
                                                                      receiverId:
                                                                          ds.get(
                                                                              "UserId"),
                                                                      receiverToken:
                                                                          value.get("token") ??
                                                                              "",
                                                                    )));
                                                      });
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right:
                                                                appSize.width *
                                                                    0.02,
                                                            top:
                                                                appSize.height *
                                                                    0.01),
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Icon(
                                                          Icons.chat,
                                                          color: Colors.white,
                                                          size: appSize.height *
                                                              0.035,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: appSize.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          appSize.width * 0.04,
                                                      right:
                                                          appSize.width * 0.04,
                                                      top: appSize.height *
                                                          0.01),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: appSize.height *
                                                            0.06,
                                                        width: appSize.width *
                                                            0.65,
                                                        child: TextFormField(
                                                          controller:
                                                              commentController,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                          //     controller: _email,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: 'Comment',
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                            //  suffixIcon: Icon(Icons.phone,color: Colors.grey,),suffixStyle: TextStyle(color: Colors.grey),

                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          1.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7.0),
                                                            ),

                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.0)),

                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.0)),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: appSize.width *
                                                            0.04,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (commentController
                                                              .text
                                                              .isNotEmpty) {
                                                            firebaseFirestore
                                                                .collection(
                                                                    "comments")
                                                                .add({
                                                              "postId": ds.id,
                                                              'userId':
                                                                  firebaseAuth
                                                                      .currentUser!
                                                                      .uid,
                                                              "content":
                                                                  commentController
                                                                      .text,
                                                              "userName":
                                                                  userName,
                                                              "userImage":
                                                                  userImage,
                                                              "time":
                                                                  DateTime.now()
                                                            }).then((value) {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              commentController
                                                                  .clear();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: appSize
                                                                      .width *
                                                                  0.01),
                                                          height:
                                                              appSize.width *
                                                                  0.11,
                                                          width: appSize.width *
                                                              0.12,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .30),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          ),
                                                          child: Icon(
                                                            Icons.send,
                                                            color: Colors.purple
                                                                .shade300,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                                Flexible(
                                                  child: StreamBuilder(
                                                      stream: firebaseFirestore
                                                          .collection(
                                                              "comments")
                                                          .where("postId",
                                                              isEqualTo: ds.id)
                                                          .snapshots(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              asnapshot) {
                                                        if (asnapshot.hasData) {
                                                          return asnapshot.data!
                                                                  .docs.isEmpty
                                                              ? const Center(
                                                                  child: Text(
                                                                      "No Comments"))
                                                              : ListView
                                                                  .builder(
                                                                      itemCount: asnapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                      reverse:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        var ds1 = asnapshot
                                                                            .data!
                                                                            .docs[i];
                                                                        return Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: appSize.width * 0.01,
                                                                            ),
                                                                            CircleAvatar(
                                                                              backgroundColor: Colors.blueGrey.withOpacity(.30),
                                                                              radius: 23,
                                                                              backgroundImage: NetworkImage(ds1['userImage']),
                                                                            ),
                                                                            SizedBox(
                                                                              width: appSize.width * 0.02,
                                                                            ),
                                                                            Container(
                                                                                margin: EdgeInsets.only(top: appSize.height * 0.02),
                                                                                alignment: Alignment.topLeft,
                                                                                width: appSize.width * 0.5,
                                                                                decoration: BoxDecoration(color: Colors.grey.withOpacity(.30), borderRadius: BorderRadius.circular(12)),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: appSize.height * 0.02, left: appSize.width * 0.015, bottom: appSize.height * 0.005),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        ds1.get("userName"),
                                                                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: appSize.height * 0.01,
                                                                                      ),
                                                                                      Text(
                                                                                        ds1.get("content"),
                                                                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        );
                                                                      });
                                                        } else if (asnapshot
                                                            .hasError) {
                                                          return const Center(
                                                              child: Icon(Icons
                                                                  .error_outline));
                                                        } else {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                      }),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Icon(Icons.error_outline));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<bool?> showMyDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Do you want to exit the App?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Exit'))
            ],
          ));
}
