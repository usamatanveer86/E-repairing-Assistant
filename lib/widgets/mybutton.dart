import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

import 'mytext.dart';

class MyButton extends StatelessWidget {
  String ? text;
  VoidCallback? onPressed;
   MyButton({Key? key,this.text,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size=MediaQuery.of(context).size;
    return MaterialButton(
      height: Size.height*0.07,
      minWidth: Size.width,
      onPressed: onPressed,
      child: MyText(text:text??"",fontSize: Size.height*0.02,
        color: backgroundColor,),
      color: appColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
