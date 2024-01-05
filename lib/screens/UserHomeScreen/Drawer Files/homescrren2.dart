import 'package:flutter/material.dart';

import 'package:untitled1/utils/colors.dart';


class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.only(
            left: appSize.width * 0.02, right: appSize.width * 0.02,),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: appSize.height * 0.02,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Services",style: TextStyle(

                    color: Colors.black,

                    fontWeight: FontWeight.w500,
                  fontSize: appSize.width*0.045

                ),),
              ),



              GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.95),
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: (){

print("jhggggggggggggggggg");
                    },
                    child: Container(

                      height: appSize.height * 0.2,
                      width: appSize.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 4)
                          ]),

                    ),
                  );
                },
              ),



            ],
          ),
        ),
      ),
    );
  }
}
