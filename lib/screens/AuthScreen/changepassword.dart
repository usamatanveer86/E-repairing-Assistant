import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/Drawer%20Page.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/widgets/customdialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  String? email;
  ChangePasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: appColor,
            )),
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: appSize.height * 0.2,
              ),
              Center(
                child: Container(
                  height: appSize.height * 0.063,
                  width: appSize.width * 0.87,
                  margin: EdgeInsets.only(top: appSize.height * 0.03),
                  child: TextFormField(
                    controller: oldPassword,
                    style: const TextStyle(
                      fontFamily: 'Poppin',
                    ),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(width: 1, color: appColor),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Old Password",
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppin',
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.visibility_off, color: appColor)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Please enter password";
                      } else if (value.length < 6) {
                        return 'Password too short.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: appSize.height * 0.063,
                  width: appSize.width * 0.87,
                  margin: EdgeInsets.only(top: appSize.height * 0.03),
                  child: TextFormField(
                    controller: newPassword,
                    style: const TextStyle(
                      fontFamily: 'Poppin',
                    ),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        borderSide: BorderSide(width: 1, color: appColor),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "New Password",
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppin',
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.visibility_off, color: appColor)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Please enter password";
                      } else if (value.length < 6) {
                        return 'Password too short.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: appSize.height * 0.08,
              ),
              SizedBox(
                height: appSize.height * 0.063,
                width: appSize.width * 0.87,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3,
                  ),
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arboria_Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      Customdialog.showDialogBox(context);
                      try {
                        User firebaseUser = firebaseAuth.currentUser!;
                        var result =
                            await firebaseUser.reauthenticateWithCredential(
                                EmailAuthProvider.credential(
                                    email: firebaseUser.email!,
                                    password: oldPassword.text.trim()));
                        await result.user!
                            .updatePassword(newPassword.text.trim())
                            .then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Customdialog().showInSnackBar(
                              "Password Successfully updated", context);
                        }).catchError((e) {
                          throw e;
                        });
                      } on FirebaseAuthException catch (e) {
                        Navigator.pop(context);
                        Customdialog.showBox(context, e.toString());
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
