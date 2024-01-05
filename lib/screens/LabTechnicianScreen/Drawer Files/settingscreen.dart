import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/AuthScreen/changepassword.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var ds=snapshot.data!;
                    return Column(children: [

                      Padding(
                        padding: EdgeInsets.only(top: appSize.height*0.02,left: appSize.width*0.02),
                        child: Text("ACCOUNT",style: TextStyle(color: Colors.black,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                      ),
                      SizedBox(height: appSize.height*0.01,),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Username",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                            Text(ds.get("UserName"),
                              style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),


                          ],
                        ),
                      ),
                      SizedBox(height: appSize.height*0.01,),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                            Text(ds.get("Email"),style: TextStyle(color: Colors.grey,
                                fontSize: appSize.width*0.039,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),


                          ],
                        ),
                      ),
                      SizedBox(height: appSize.height*0.01,),
                      Divider(
                        color: Colors.grey,
                      ),


                      Padding(
                        padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("User ID",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                            Text(ds.id,style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),


                          ],
                        ),
                      ),
                      SizedBox(height: appSize.height*0.01,),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen(
                              email: ds.get("Email"),
                            )));

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Password",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                              Icon(Icons.arrow_forward_ios,color: Colors.grey,size: appSize.height*0.03,



                              )

                            ],
                          ),
                        ),
                      ),
                    ],);
                  } else if (snapshot.hasError) {
                    return Center(child: Icon(Icons.error_outline));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              SizedBox(height: appSize.height*0.01,),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(top: appSize.height*0.02,left: appSize.width*0.02),
                child: Text("MORE INFORMATION",style: TextStyle(color: Colors.black,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
              ),
              SizedBox(height: appSize.height*0.01,),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Version",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                    Text("3.11.1",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),


                  ],
                ),
              ),
              SizedBox(height: appSize.height*0.01,),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("About us",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                Icon(Icons.arrow_forward_ios,color: Colors.grey,size: appSize.height*0.03,

                )

              ],
            ),
          ),
              SizedBox(height: appSize.height*0.01,),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Privacy Policy",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                    Icon(Icons.arrow_forward_ios,color: Colors.grey,size: appSize.height*0.03,

                    )

                  ],
                ),
              ),
              SizedBox(height: appSize.height*0.01,),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding:  EdgeInsets.only(left: appSize.width*0.02,right: appSize.width*0.02,top: appSize.height*0.01 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Terms & Conditions",style: TextStyle(color: Colors.grey,fontSize: appSize.width*0.039,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                    Icon(Icons.arrow_forward_ios,color: Colors.grey,size: appSize.height*0.03,

                    )

                  ],
                ),
              ),


            ],
          )
        ),
      ),
    );
  }
}
