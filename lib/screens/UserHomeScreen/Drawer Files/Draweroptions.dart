import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/category/category_screen.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/mypost_screen.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/user_pendingscreen.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/usercompleted_screen.dart';
import 'package:untitled1/screens/UserHomeScreen/notification2.dart';
import 'package:untitled1/utils/colors.dart';

import '../../../localdatabase/localdatabase.dart';
import '../../../main.dart';
import '../../../utils/constant.dart';
import '../../LabTechnicianScreen/Drawer Files/settingscreen.dart';
import '../../LabTechnicianScreen/paymentscreen.dart';
import '../../LabTechnicianScreen/user.dart';
import '../../firstscreen.dart';
class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomePage2 extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Services", Icons.home_sharp),
    DrawerItem("My Post", Icons.post_add_outlined),
    DrawerItem("Completed", Icons.check_circle),
    DrawerItem("Pending", Icons.landscape_outlined),



    DrawerItem("Counselers", Icons.person),
    DrawerItem("Payment", Icons.money),
    DrawerItem("Setting", Icons.settings),






  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePage2State();
  }
}

class HomePage2State extends State<HomePage2> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  CategoryScreen();

      case 1:
        return  MyPostScreen();
      case 2:
        return  UserCompletedScreen();
      case 3:
        return  PendinguserScreen();
        case 4:
        return  UserScreen();
      case 5:
        return PaymentScreen();

      case 6 :
        return SettingScreen();
      default:
        return  Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  late double width;
  late double height;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).update(
        {"token": token});
}
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var drawerOptions = <Widget>[];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];


      drawerOptions.add( ListTile(
        leading: new Icon(
          d.icon,
          color: Colors.white,
        ),
        title: new Text(
          d.title,
          style: TextStyle(
              fontFamily: 'Circularstd-Med', fontWeight: FontWeight.w700,color: Colors.white),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ),


      );


    }
    var appSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor:appColor,
        title: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: TextStyle(color: Colors.white, fontFamily: 'Circularstd-Med'),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: appSize.width*0.02),
            child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(_)=>UserNotificationScreen
                    ()));

                },
                child: Icon(Icons.notifications,color: Colors.white,size: appSize.height*0.037,)),
          )
        ],

      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: appColor),
        child: new Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(left: appSize.width*0.05,top: appSize.height*0.08),
                    child: FutureBuilder(
                        future: firebaseFirestore.collection("users").doc(firebaseAuth.currentUser!.uid).get(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var ds=snapshot.data!;
                            return Column(
                              children: [
                                SizedBox(width: appSize.width*0.01,),
                                CircleAvatar(
                                  radius: 46,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(ds.get("imageLink")),
                                )
                                ,

                                SizedBox(height: appSize.height*0.01,),
                                Text(ds.get("UserName"),style: TextStyle(color: Colors.white,fontSize: appSize.width*0.038),),


                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Icon(Icons.error_outline));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  SizedBox(height: appSize.height*0.02,),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: appSize.height*0.02,),

                  new Column(

                      children: drawerOptions),
                  SizedBox(height: appSize.height*0.1,),
                  Divider(
                    color: Colors.white,
                  ),

                  Padding(
                      padding:  EdgeInsets.only(top: appSize.height*0.05, ),
                      child: ListTile(
                        onTap: ()async{
                          await LocalDatabase().removeData(key: "type");
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>FirstScreen()), (route) => false);
                        },
                        leading: Icon(Icons.power_settings_new,color: Colors.white,size: appSize.height*0.04,),
                        title: Text("Logout",style: TextStyle(color: Colors.white,fontSize: appSize.width*0.042),),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
