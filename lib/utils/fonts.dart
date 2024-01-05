import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  static TextStyle poppins() {
    return GoogleFonts.poppins();
  }
  static TextStyle poppinsBold() {
    return GoogleFonts.poppins(fontWeight: FontWeight.bold);
  }

}