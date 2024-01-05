import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/LabTechnicianScreen/shopdetail.dart';
import 'package:untitled1/utils/colors.dart';


class Approved extends StatefulWidget {
  @override
  _ApprovedState createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height:appSize.height*0.02,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_)=>ShopDetailScreen()));

              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: appSize.width*0.05,vertical: appSize.height*0.02),
                height: appSize.height*0.11,
                width: appSize.width*0.9,
                decoration: BoxDecoration(
                  color: appColor.withOpacity(.40),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:appSize.height*0.02,),
                    Container(
                      margin: EdgeInsets.only(left:appSize.width*0.04),
                      child: CircleAvatar(
                        backgroundColor: appColor.withOpacity(.40),
                        radius: 20,
                        child: Image.asset("assets/images/3.png",scale: 9,),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: appSize.width*0.01,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                                margin: EdgeInsets.only(top: appSize.height*0.03,left: appSize.width*0.01),
                                child: Text("Zohaib",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)),
                            Container(
                              margin: EdgeInsets.only(top: appSize.height*0.01),

                              child: Text("03075154488",style: TextStyle(color: Colors.white,fontSize: 13),),
                            ),
                          ],
                        ),


                        Container(
                          margin: EdgeInsets.only(left: appSize.width*0.25),
                          child: Icon(Icons.check_circle,color: Colors.white,size: 50,),

                        ),
                        SizedBox(width:appSize.width*0.02,),
                        CircleAvatar(

                          backgroundColor: appColor,
                          radius: 22,
                          child: Icon(Icons.close_sharp,color: Colors.white,size: 30,),

                        ),

                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: appSize.height*0.01,),




                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
