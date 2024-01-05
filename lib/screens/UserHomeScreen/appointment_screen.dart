import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:untitled1/widgets/mytextfield.dart';

import '../../utils/mytext.dart';


class AppointmentScreen extends StatefulWidget {
  String? id;
  AppointmentScreen({Key? key,this.id}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
TextEditingController descriptionController=TextEditingController();
TextEditingController phoneController=TextEditingController();
final formkey=GlobalKey<FormState>() ;
  String userName="";
String senderImage="";
String senderEmail="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((value) {
 userName = value.get("UserName");
 senderImage=value.get("imageLink");
 senderEmail=value.get("Email");
 });
  }
  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: appSize.height,
          width: appSize.width,
          margin: EdgeInsets.only(top: appSize.height*0.04),
          decoration: BoxDecoration(
            color:Colors.white,
            // borderRadius: BorderRadius.circular(10)
          ),
          child: FutureBuilder(
              future: firebaseFirestore.collection("users").doc(widget.id).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var ds=snapshot.data!;
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: appSize.height*0.3,
                            width: appSize.width,
                            child: Image.network(ds.get("imageLink"),fit: BoxFit.cover,)),
                          Padding(
                            padding:  EdgeInsets.only(top: appSize.height*0.01,left: appSize.width*0.04,right: appSize.width*0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: appSize.height*0.01,),
                                MyText(text: "Name",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                                SizedBox(height: appSize.height*0.01,),

                                MyText(text:  ds['UserName'],fontSize: appSize.height*0.02,color: Colors.black,),
                                SizedBox(height: appSize.height*0.01,),
                                Divider(
                                  color: Colors.grey,
                                ),

                                SizedBox(height: appSize.height*0.01,),
                                MyText(text: "Address",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                                SizedBox(height: appSize.height*0.01,),

                                MyText(text: ds['Address'],fontSize: appSize.height*0.02,color: Colors.black,),
                                SizedBox(height: appSize.height*0.01,),
                                Divider(
                                  color: Colors.grey,
                                ),
                                MyText(text: "Email",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                                SizedBox(height: appSize.height*0.01,),

                                MyText(text: ds["Email"],fontSize: appSize.height*0.02,color: Colors.black,),
                                SizedBox(height: appSize.height*0.01,),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(text: "Phone Number",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                                      // SizedBox(height: appSize.height*0.01,),
                                      MyTextField(
             show: false,
                                        controller: phoneController,
                                        hintText: "Phone Number",
                                        validator: RequiredValidator(errorText: "Required Phone Number"),
                                      ),
                                      SizedBox(height: appSize.height*0.01,),
                                      MyText(text: "Description",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                                      SizedBox(height: appSize.height*0.01,),

                                      MyTextField(
                                        show: false,
                                        maxLines: 3,
                                        controller: descriptionController,
                                       hintText: "Description",
                                       validator: RequiredValidator(errorText: "Required description"),
                               ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: appSize.height*0.02,),
                                InkWell(
                                  onTap: (){
                                    if(formkey.currentState!.validate()){
                                    Customdialog.showDialogBox(context);
                                    firebaseFirestore.collection("notifications").add(
                                        {
                                          "senderId":firebaseAuth.currentUser!.uid,
                                      "senderName":userName,
                                          "senderImage":senderImage,
                                  "senderEmail":senderEmail,
                                          "receiverId":ds.id,

                                          "name":ds.get("UserName"),
                                          "userImage":ds.get("imageLink"),
                                          "email":ds.get("Email"),
                                          "status":null,
                                 "description":descriptionController.text.trim(),
                                          "phoneNumber":"+92"+phoneController.text.trim()
                                        }).then((value) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Customdialog().showInSnackBar("Appointment Booking Please wait...", context);

                                    });
                                  }},
                                  child: Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: appSize.height*0.063,
                                      width: appSize.width*0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color:appColor,
                                      ),
                                      child: Text("Book Appointment",style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: appSize.width*0.038

                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),

                      Positioned(
                          top: appSize.height*0.015,
                          left: appSize.width*0.04,
                          child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 23,)))
                    ],
                  );
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