import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/constant.dart';
import 'package:untitled1/widgets/customdialog.dart';

class RatingScreen extends StatefulWidget {
  String? id;
  RatingScreen({Key? key, this.id}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late double height;
  late double width;
  double rating = 0.0;
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future:
                  firebaseFirestore.collection("users").doc(widget.id).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var ds = snapshot.data!;
                  return ds.get("rating") == 0.0
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.15,
                                  right: width * 0.1,
                                  top: height * 0.2),
                              child: Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (myrating) {
                                      // print(rating);
                                      setState(() {
                                        rating = myrating;
                                      });
                                      print(myrating);
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Container(
                              height: height * 0.065,
                              width: width * 0.9,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                child: Text(
                                  'Send Feedback',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appColor,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Customdialog.showDialogBox(context);
                                  firebaseFirestore
                                      .collection("users")
                                      .doc(widget.id)
                                      .update({"rating": rating}).then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                  // Navigator.pop(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>FCSignInPinHere(phone: '',)));
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.15,
                                  right: width * 0.1,
                                  top: height * 0.2),
                              child: Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: ds.get("rating"),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (myrating) {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            const Text("You already rated")
                          ],
                        );
                } else if (snapshot.hasError) {
                  return const Center(child: Icon(Icons.error_outline));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
