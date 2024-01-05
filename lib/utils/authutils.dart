

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/widgets/customdialog.dart';

import '../screens/LabTechnicianScreen/Drawer Files/Drawer Page.dart';
import '../screens/UserHomeScreen/Drawer Files/Drawer Page.dart';
import 'constant.dart';


class AuthUtils{

   registerUser(
       String imageLink,
      String name,
      String email,
      String address,
      String password,
       String gender,
       String type,
       String? cetagory,
       String phoneno,
       BuildContext context

      )async{
  try{
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      firebaseFirestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
        'UserName':name,
        'Email':email,
        'Address':address,
        'Gender':gender,
        'imageLink':imageLink,
        'Type':type,
        "Cetagory":cetagory,
        "token":"",
        "status":"",
        "rating":0.0,
        "phoneNumber":"+92"+phoneno
        // 'Password':password
      }).then((value) {
        Customdialog().showInSnackBar("Logged in", context);
        // Provider.of<CircularProgressProvider>(context,listen: false).setValue(false);
        Customdialog.closeDialog(context);
cetagory==null?                     Navigator.push(context, MaterialPageRoute(builder: (_)=>DrawerFile2())):
Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => DrawerFile()), (
            route) => false);
        // Navigator.push(context, MaterialPageRoute(builder: (_)=>DrawerFile2()));

      });
    }  ).catchError((onError){
      throw onError;
      Navigator.pop(context);
      Customdialog.showBox(context,onError);

    });
  }on FirebaseAuthException catch(e){
    Navigator.pop(context);

    Customdialog.showBox(context,e.toString());


  }
  }

   loginUser(
       String email,
       String password,
       BuildContext context,
       String type
       )async{
try{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  await
   firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((v) {
     firebaseFirestore.collection('users').doc(v.user!.uid)
         .get().then((doc)  {
       print(doc['Email']);
       if(doc['Email']==email&&doc['Type']==type){
sharedPreferences.setString("email", email);
sharedPreferences.setString("id", firebaseAuth.currentUser!.uid);
sharedPreferences.setString("type", type);
Customdialog().showInSnackBar("Logged in", context);
         Customdialog.closeDialog(context);

           type=="Counceler"? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> DrawerFile()), (route) => false):
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> DrawerFile2()), (route) => false);
       } else if(doc['Type']!=type){
         Customdialog.closeDialog(context);
         Customdialog().showInSnackBar("You are Not register Please Register", context);
       }
       else{
         Customdialog.closeDialog(context);
         // Customdialog.closeDialog(context);
         Customdialog().showInSnackBar("wrong", context);
         Customdialog.closeDialog(context);
       }
     }
     );
   }).catchError((e){
     throw e;
   });
}
catch(e){
Navigator.pop(context);
  Customdialog.showBox(context,e.toString());
}
   }
   resetPassword(String email,BuildContext context)async{
try{
  await    firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
   Customdialog.closeDialog(context);
   Customdialog.closeDialog(context);
   Customdialog().showInSnackBar("Please Check your email", context);
  }).catchError((e){
    throw e;
  });
}
   catch(e){
     Navigator.pop(context);
     Customdialog.showBox(context,e.toString());
   }
   }

}
