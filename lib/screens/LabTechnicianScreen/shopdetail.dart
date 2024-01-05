import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

import '../../utils/mytext.dart';


class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: appSize.height,
        width: appSize.width,
        margin: EdgeInsets.only(top: appSize.height*0.04),
        decoration: BoxDecoration(
          color:Colors.white,
          // borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(
                  height: appSize.height*0.35,
                  width: appSize.width,
                  child: Image.asset("assets/images/study.jpg",fit: BoxFit.cover,)),
                Padding(
                  padding:  EdgeInsets.only(top: appSize.height*0.01,left: appSize.width*0.04,right: appSize.width*0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: appSize.height*0.02,),
                      MyText(text: "Address",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                      SizedBox(height: appSize.height*0.02,),

                      MyText(text: "Lorem ipsum dolor sit amet, consetetur ",fontSize: appSize.height*0.02,color: Colors.black,),
                      SizedBox(height: appSize.height*0.02,),
                      Divider(
                        color: Colors.grey,
                      ),
                      MyText(text: "Phone no.",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                      SizedBox(height: appSize.height*0.02,),

                      MyText(text: "Lorem ipsum dolor sit amet, consetetur ",fontSize: appSize.height*0.02,color: Colors.black,),
                      SizedBox(height: appSize.height*0.02,),
                      Divider(
                        color: Colors.grey,
                      ),




                      MyText(text: "Description",fontSize: appSize.height*0.025,color:Colors.black,fontWeight: FontWeight.bold,),
                      SizedBox(height: appSize.height*0.02,),

                      MyText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor inigfh ghgf",fontSize: appSize.height*0.02,color: Colors.black,),
                      SizedBox(height: appSize.height*0.02,),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: appSize.height*0.1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
alignment: Alignment.center,
                            height: appSize.height*0.063,
                            width: appSize.width*0.35,
                            decoration: BoxDecoration(
borderRadius: BorderRadius.circular(7),
                             border: Border.all(color: appColor)
                            ),
                            child: Text("Reject",style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: appSize.width*0.042

                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: appSize.height*0.063,
                            width: appSize.width*0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color:appColor,
                            ),
                            child: Text("Accept",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: appSize.width*0.042

                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
            Positioned(
                top: appSize.height*0.33,
                right: appSize.width*0.06,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.person),),
                    SizedBox(height: appSize.height*0.007,),
                    MyText(text: "Mohsin Tariq",fontSize: appSize.height*0.012,color: Colors.black,),

                  ],
                )),
            Positioned(
                top: appSize.height*0.015,
                left: appSize.width*0.04,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)))
          ],
        ),
      ),
    );
  }
}