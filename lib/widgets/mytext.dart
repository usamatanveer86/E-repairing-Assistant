import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/fonts.dart';
class MyText extends StatelessWidget {
  String text;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
   MyText({Key? key,required this.text,this.fontWeight,this.color,this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text( text,style:
        MyTextStyle.poppins().copyWith(
color: color??appColor,
          fontWeight: fontWeight,
          fontSize: fontSize
        )
        ,softWrap: true,
      overflow: TextOverflow.fade,
    );
  }
}
