import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/images..dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushNamed(context, '/first'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 900),
          tween: Tween<double>(begin: 2.0 * 25, end: 0),
          builder: (context, double val, child) {
            return Padding(
                padding: EdgeInsets.only(top: val, left: val, right: val),
                
                child: child!);
          },
          child: SizedBox(
            height: Size.height * 0.8,
            width: Size.width,
            child:
                // Text("jdjsdgf")

                Image.asset(
              splashlogo,
              // scale: 5,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
