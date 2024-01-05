import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/screens/AuthScreen/loginscreen.dart';
import 'package:untitled1/screens/AuthScreen/userlogin/userlogin.dart';

import 'package:untitled1/utils/authutils.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constants.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:untitled1/widgets/myappbar.dart';
import 'package:untitled1/widgets/mybutton.dart';
import 'package:untitled1/widgets/mytext.dart';
import 'package:untitled1/widgets/mytextfield.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
class UserSignUpScreen extends StatefulWidget {
  UserSignUpScreen({Key? key}) : super(key: key);

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final GlobalKey<FormState>key=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  bool checkValue=false;
  int _radioValue = 0;
  File? imageUrl;
  String? imageLink;
  final ImagePicker _picker = ImagePicker();

  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }
  void _handleRadioValueChange(int? value) {
    setState(() {
      _radioValue = value!;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var Size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: Size.width*0.04,right: Size.width*0.04),
        child: Form(
          key: key,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: Size.height*0.04,),
// Center(child: MyText(text: "E-repairing Assistant",fontSize: Size.height*0.03,
// fontWeight: FontWeight.w900,
// ))
              MyAppbar(),

              SizedBox(height: Size.height*0.01,),
              Center(
                child: MyText(text: "User SignUp",fontSize: Size.height*0.025,
                  fontWeight: FontWeight.w900,),
              ),
              SizedBox(height: Size.height*0.01,),
              InkWell(
                onTap: addImage,
                child: Container(
                  height: Size.height*0.09,
                  width: Size.width*.16,
                  decoration:BoxDecoration(
                      color:  appColor,

                      shape: BoxShape.circle) ,
                  child:CircleAvatar(
                    backgroundColor: appColor,

                    child: imageUrl==null? Icon(Icons.camera_alt_outlined,color: WHITE,):CircleAvatar(
radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: FileImage(imageUrl!,scale: 12,),),)
                ),
              ),
              SizedBox(height: Size.height*0.01,),
              Center(
                child: MyText(text: "Please upload your photo",fontSize: Size.height*0.02,
                  color: BLACK,
                  fontWeight: FontWeight.w900,),
              ),
              SizedBox(height: Size.height*0.06,),
              MyTextField(
                show: false,
                controller: nameController,
                hintText: "Name",
                validator:   RequiredValidator(errorText: 'name is required') ,
              ),
              SizedBox(height: Size.height*0.02,),
              MyTextField(
                show: false,
                validator: emailValidator,
                controller: emailController,
                hintText: "Email",),
              SizedBox(height: Size.height*0.02,),
              MyTextField(
                show: false,
                validator:   RequiredValidator(errorText: 'address is required'),
                controller: addressController,
                hintText: "Address",),
              SizedBox(height: Size.height*0.02,),

              MyTextField(
                show: true,
                validator: passwordValidator,
                controller: passwordController,
                hintText: "Password",eye: true,),
              SizedBox(height: Size.height*0.01,),
              Row(
                children: [
                  Radio(
                      activeColor: appColor,
                      value: 0, groupValue: _radioValue, onChanged: _handleRadioValueChange ),
                  MyText(text: "Male",fontSize: Size.height*0.02,),
                  Radio(
                      activeColor: appColor,
                      value: 1, groupValue: _radioValue, onChanged: _handleRadioValueChange ),
                  MyText(text: "Female",fontSize: Size.height*0.02,),
                ],
              ),

              Row(
                children: [
                  Checkbox(
                      activeColor: appColor,
                      value:checkValue, onChanged: (value){
                    setState(() {
                      checkValue=!checkValue;
                    });
                  }),
                  MyText(text: "I agree with our terms and condition",fontSize: Size.height*0.02,),
                ],
              ),
              SizedBox(height: Size.height*0.04,),
              MyButton(
                text: "Sign Up",
                onPressed: (){
                  if(checkValue==true){
                    if(key.currentState!.validate()){
                      Customdialog.showDialogBox(context);
                      uploadImageToFirebase().then((value) =>
                          AuthUtils().registerUser(
                              imageLink!, nameController.text.trim(),
                              emailController.text.trim(),
                              addressController.text.trim(),
                              passwordController.text.trim(),
                              _radioValue==0?"male":"female",
                              "User", null,"",context)
                      );

                    }
                  }

                },
              ),
              SizedBox(height: Size.height*0.03,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(text: "Aleady have an account?",fontSize: Size.height*0.02,),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>UserLoginScreen(
                        )));
                      },
                      child: MyText(text: "Login",fontSize: Size.height*0.02,                    fontWeight: FontWeight.w900,
                      ))
                ],
              )
            ],),
        ),
      ),
    );
  }
  Future uploadImageToFirebase() async {
    File? fileName = imageUrl;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('cetagory/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
    firebaseStorageRef.putFile(fileName!);
    firebase_storage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }
}
