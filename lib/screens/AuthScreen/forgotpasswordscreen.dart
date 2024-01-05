import 'package:flutter/material.dart';

import 'package:untitled1/utils/authutils.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/utils/constants.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:untitled1/widgets/myappbar.dart';
import 'package:untitled1/widgets/mybutton.dart';
import 'package:untitled1/widgets/mytext.dart';
import 'package:untitled1/widgets/mytextfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState>formkey=GlobalKey<FormState>();
  ForgotPasswordScreen({Key? key}) : super(key: key);
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyAppbar(),

              SizedBox(height: Size.height*0.01,),
              MyText(text: "Forgot Password",fontSize: Size.height*0.025,
                fontWeight: FontWeight.w900,),
              SizedBox(height: Size.height*0.1,),
              MyTextField(
                show: false,
                validator: emailValidator,
                controller: emailController,
                hintText: "Email",),
              SizedBox(height: Size.height*0.05,),

              MyButton(
                text: "Forgot Password",
                onPressed: (){
                  if(formkey.currentState!.validate()){
                    Customdialog.showDialogBox(context);
                    AuthUtils().resetPassword(emailController.text.trim(), context);
                 emailController.clear();
                  }
                },
              ),
              SizedBox(height: Size.height*0.03,),
            ],),
        ),
      ),
    );
  }
}
