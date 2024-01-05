import 'package:flutter/material.dart';
import 'package:untitled1/utils/colors.dart';

class MyTextField extends StatefulWidget {
  String? hintText;
  bool? eye;
  int? maxLines;
  bool show = false;
  TextEditingController? controller;
  String? Function(String?)? validator;
  MyTextField(
      {Key? key,
      this.maxLines,
      required this.show,
      this.hintText,
      this.eye,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.show,
      maxLines: widget.maxLines ?? 1,
      cursorColor: appColor,
      decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          suffixIcon: widget.eye == null
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.show = !widget.show;
                    });
                  },
                  icon: widget.show
                      ? Icon(
                          Icons.visibility,
                          color: appColor,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: appColor,
                        ),
                )),
    );
  }
}
