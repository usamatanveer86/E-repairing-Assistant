import 'package:flutter/material.dart';

import 'package:untitled1/screens/AuthScreen/forgotpasswordscreen.dart';
import 'package:untitled1/screens/AuthScreen/signupscreen.dart';
import 'package:untitled1/screens/AuthScreen/userlogin/usersignup.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/Drawer%20Page.dart';

import 'package:untitled1/utils/authutils.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constants.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:untitled1/widgets/myappbar.dart';
import 'package:untitled1/widgets/mybutton.dart';
import 'package:untitled1/widgets/mytext.dart';
import 'package:untitled1/widgets/mytextfield.dart';

class UserLoginScreen extends StatelessWidget {

  final GlobalKey<FormState>formkey=GlobalKey<FormState>();
  UserLoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: Size.width*0.04,right: Size.width*0.04),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: Size.height*0.04,),
// Center(child: MyText(text: "E-repairing Assistant",fontSize: Size.height*0.03,
// fontWeight: FontWeight.w900,
// ))
                MyAppbar(),

                SizedBox(height: Size.height*0.01,),
                MyText(text: "User Login",fontSize: Size.height*0.025,
                  fontWeight: FontWeight.w900,),
                SizedBox(height: Size.height*0.06,),
                MyTextField(
                  show: false,
                  validator: emailValidator,
                  controller: emailController,
                  hintText: "Email",),
                SizedBox(height: Size.height*0.02,),
                MyTextField(
                  show: true,
                  validator: passwordValidator,
                  controller: passwordController,
                  hintText: "Password",
                  eye: true,
                ),
                SizedBox(height: Size.height*0.01,),
                Padding(
                    padding: EdgeInsets.only(left: Size.width*0.55),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(_)=>ForgotPasswordScreen()));
                        },
                        child: MyText(text: "forgot password",fontSize: Size.height*0.02,))),
                SizedBox(height: Size.height*0.04,),
                MyButton(
                  text: "Login",
                  onPressed: (){
                    if(formkey.currentState!.validate()){
                      Customdialog.showDialogBox(context);
                      AuthUtils().loginUser(emailController.text.trim(),passwordController.text.trim(), context,"User");
                    }

                    // Navigator.push(context, MaterialPageRoute(builder: (_)=>DrawerFile2()));

                  },
                ),
                SizedBox(height: Size.height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(text: "Dn't have account?",fontSize: Size.height*0.02,),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>UserSignUpScreen(
                          )));
                        },
                        child: MyText(text: "Create Account",fontSize: Size.height*0.02,
                          fontWeight: FontWeight.w900,
                        ))
                  ],
                )
              ],),
          ),
        ),
      ),
    );
  }
}
