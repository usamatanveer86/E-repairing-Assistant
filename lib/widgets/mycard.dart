import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

import 'mytext.dart';

class MYCard extends StatelessWidget {
  String? title;
  String? imageLink;
  VoidCallback? onPressed;
  bool? image;
  Color? backgroundColor;
   MYCard({Key? key,this.title,this.imageLink,this.onPressed,this.image,this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Size=MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(

        height: Size.height*0.15,
        width: Size.width*0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor??WHITE,
          border: Border.all(width: 1,color: BLACK),borderRadius: BorderRadius.circular(15),
        ),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageLink==null?Container() :Image.asset(imageLink!,scale: 5,color: appColor,),
            MyText(text: title??"hello",
            color: backgroundColor==null?null:WHITE,
            fontWeight: FontWeight.w900,),
          ],
        ),
      ),
    );
  }
}
