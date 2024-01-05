import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

import 'mytext.dart';

class MyAppbar extends StatelessWidget {
  bool? centerTitle;
  bool? automaticallyImplyLeading;
  MyAppbar({Key? key,this.automaticallyImplyLeading,this.centerTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size=MediaQuery.of(context).size;
    return AppBar(
      centerTitle: centerTitle??true,
      automaticallyImplyLeading: automaticallyImplyLeading??false,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      foregroundColor: BLACK,
      title: MyText(text: "E-Repairing Assistent",fontSize: Size.height*0.03,
        fontWeight: FontWeight.w900,
      ),
    ) ;
  }
}
