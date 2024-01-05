import 'package:flutter/material.dart';

import 'Constants.dart';

class MyText extends StatelessWidget {
  String text;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
   MyText({Key? key,required this.text,this.color,this.fontWeight,this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color:color??Colors.grey,fontSize:fontSize ,overflow: TextOverflow.fade,fontWeight:fontWeight ),
    softWrap: true,
    overflow: TextOverflow.fade,);
  }
}
