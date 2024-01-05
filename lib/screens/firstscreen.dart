import 'package:flutter/material.dart';
import 'package:untitled1/screens/AuthScreen/loginscreen.dart';
import 'package:untitled1/screens/AuthScreen/userlogin/userlogin.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/images..dart';
import 'package:untitled1/widgets/myappbar.dart';
import 'package:untitled1/widgets/mycard.dart';
import 'package:untitled1/widgets/mytext.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding:
            EdgeInsets.only(left: Size.width * 0.02, right: Size.width * 0.02),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyAppbar(),
            SizedBox(
              height: Size.height * 0.02,
            ),
            Image.asset(
              splashlogo,
              scale: 2,
            ),
            SizedBox(
              height: Size.height * 0.01,
            ),
            MyText(
              text: "Choose Your Identity",
              fontSize: Size.height * 0.025,
              fontWeight: FontWeight.w900,
            ),
            SizedBox(
              height: Size.height * 0.01,
            ),
            MyText(
              text:
                  "Please Select from the following.It will help up to find your service fast",
              fontSize: Size.height * 0.02,
            ),
            SizedBox(
              height: Size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MYCard(
                  image: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  title: "Lab Technician",
                  imageLink: person1,
                ),
                MYCard(
                  image: true,
                  title: "User",
                  imageLink: person1,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => UserLoginScreen()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
