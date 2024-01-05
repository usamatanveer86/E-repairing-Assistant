import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/widgets/customdialog.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

import 'package:untitled1/widgets/mybutton.dart';
import 'package:untitled1/widgets/mycard.dart';
import 'package:untitled1/widgets/mytext.dart';
import 'package:untitled1/widgets/mytextfield.dart';


class UploadRepairManScreen extends StatefulWidget {
  UploadRepairManScreen({Key? key}) : super(key: key);

  @override
  State<UploadRepairManScreen> createState() => _UploadRepairManScreenState();
}

class _UploadRepairManScreenState extends State<UploadRepairManScreen> {
  File? imageUrl;

  String? imageLink;

  final ImagePicker _picker = ImagePicker();

  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }
String Username="";
  String UserImage="";
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get().then((value){
  Username=  value.get("UserName");
   UserImage= value.get("imageLink");
  });
  }
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        leading:  GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size:appSize.height*0.035 ,)),
        centerTitle: true,
        title: Text(
         "Upload Post"
        ),


      ),
      backgroundColor: backgroundColor,
      body: ListView(
        children: [

          SizedBox(
            height: appSize.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: appSize.width * 0.05, right: appSize.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: appSize.height*0.06,),
                Container(
                  height: appSize.height * 0.15,
                  width: appSize.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                      onTap: addImage,
                      child: imageUrl == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_outlined,
                            size: 35,
                          ),
                          MyText(
                            text: "Upload",
                            fontSize: appSize.height * 0.02,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          )
                        ],
                      )
                          : Image.file(
                        imageUrl!,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: appSize.height * 0.03,
                ),
                SizedBox(
                  height: appSize.height * 0.02,
                ),
                MyTextField(
                  show: false,
                  controller: descriptionController,
                  hintText: "Description",
                ),
                SizedBox(
                  height: appSize.height * 0.03,
                ),



                SizedBox(
                  height: appSize.height * 0.1,
                ),
                MyButton(
                  text: "Upload",
                  onPressed: () async {
                     if(imageUrl==null){
                    Customdialog().showInSnackBar("Required image", context);
                    }
                    else   if(descriptionController.text.isEmpty){
     Customdialog().showInSnackBar("Required Description", context);
   }

   else if(descriptionController.text.isNotEmpty&&imageUrl!=null){
     Customdialog.showDialogBox(context);
     uploadImageToFirebase().then((value) {
       firebaseFirestore.collection("posts").add({
         "imageLink":imageLink,
         "UserName":Username,
         "UserId":firebaseAuth.currentUser!.uid,
         "UserImage":UserImage,
         "description":descriptionController.text.trim()
       }).then((value) {

         Navigator.pop(context);
         Navigator.pop(context);
         Customdialog().showInSnackBar("New post Added", context);});
     });
   }

                  },
                )
              ],
            ),
          ),
        ],
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
