import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/utils/helper.dart';
import 'package:untitled1/widgets/customTextInput.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = "/paymentScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 40),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Payment Details",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: const [
                        Text(
                          "Customize your payment method",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: AppColor.placeholder,
                      thickness: 1.5,
                      height: 30,
                    ),
                  ),
                  Container(
                    height: 170,
                    width: Helper.getScreenWidth(context),
                    decoration: const BoxDecoration(
                      color: AppColor.placeholderBg,
                      boxShadow: [],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [],
                          ),
                          const Divider(
                            color: AppColor.placeholder,
                            thickness: 1,
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                child: Image.asset("assets/images/visa.png"),
                              ),
                              const Text("**** ****"),
                              const Text("2187"),
                              OutlinedButton(
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: appColor,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      const StadiumBorder(),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all(appColor)),
                                onPressed: () {},
                                child: const Text("Delete Card"),
                              )
                            ],
                          ),
                          const Divider(
                            color: AppColor.placeholder,
                            thickness: 1,
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Other Methods",
                                style: TextStyle(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: appColor),
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              isScrollControlled: true,
                              isDismissible: false,
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: SizedBox(
                                    height:
                                        Helper.getScreenHeight(context) * 0.7,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              children: const [
                                                Text("Add Credit/Debit Card",
                                                    style: TextStyle())
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Divider(
                                              color: AppColor.placeholder
                                                  .withOpacity(0.5),
                                              thickness: 1.5,
                                              height: 40,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: CustomTextInput(
                                              hintText: "card Number",
                                              key: key,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text("Expiry"),
                                                SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: CustomTextInput(
                                                    hintText: "MM",
                                                    padding: EdgeInsets.only(
                                                        left: 35),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: CustomTextInput(
                                                    hintText: "YY",
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: CustomTextInput(
                                                hintText: "Security Code"),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: CustomTextInput(
                                                hintText: "First Name"),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: CustomTextInput(
                                                hintText: "Last Name"),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    "You can remove this card"),
                                                Switch(
                                                  value: false,
                                                  onChanged: (_) {},
                                                  thumbColor:
                                                      MaterialStateProperty.all(
                                                    AppColor.secondary,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: SizedBox(
                                              height: 50,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              appColor),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 40),
                                                      Text(
                                                        "Add Card",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(width: 40),
                                                    ],
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text(
                              "Add Another Credit/Debit Card",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
