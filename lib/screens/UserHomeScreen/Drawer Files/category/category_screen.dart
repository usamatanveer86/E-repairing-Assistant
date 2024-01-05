import 'package:flutter/material.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/category/categories_details.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/postscreen.dart';
import 'package:untitled1/utils/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> eventName = <String>[
    'Laptop',
    'Smartphone',
    'Television',
    'Digital Camera',
    'Electric Battery',
  ];
  List<String> eventImg = <String>[
    "assets/images/laptop.jpg",
    "assets/images/phones.jpg",
    "assets/images/tv.jpg",
    "assets/images/camera.jpg",
    "assets/images/battery.jpg",


  ];
  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColor,

        onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UploadRepairManScreen()));

      },
        child: Icon(Icons.upload_outlined),),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: GridView.builder(
                  itemCount: eventName.length,
                  physics: const ScrollPhysics(),
                  primary: true,
                  shrinkWrap: true,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.99,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 6),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        print(eventName[index]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetails(heading: eventName[index],)));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen()));
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          color: appColor.withOpacity(.10),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(eventImg[index]),fit: BoxFit.cover
                            )
                          ),
                          alignment: Alignment.center,
                          child:Stack(
                            children: [
                              Container(height: appSize.height,
                              width: appSize.width,
                                color: Colors.black.withOpacity(.30),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(eventName[index],style: TextStyle(
                                  color: Colors.white,fontSize:appSize.width*0.055,
                                  fontWeight: FontWeight.bold,

                                ),),
                              ),
                            ],
                          )
                        )

                      ),
                    );
                  }),
            ),
          ],

        ),
      ),
    );
  }
}
