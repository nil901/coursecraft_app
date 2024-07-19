// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//============================= APP TEXT ====================================//

class AppText extends StatelessWidget {
  final TextEditingController? controller;

  final String text;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontWeight;
  final double? wordspace;
  final bool textCenter;
  final dynamic foreground;
  final double? laterspacing;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final void Function()? onTap;
  final void Function(String)? onsubmite;
  final String? Function(String?)? validator;

  const AppText({
    Key? key,
    required this.text,
    this.color,
    this.fontsize,
    this.fontWeight,
    this.wordspace,
    this.laterspacing,
    this.decoration,
    this.foreground,
    this.style,
    this.maxLines,
    this.overflow,
    this.textCenter = false,
    this.onTap,
    this.onsubmite,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.clip,
      maxLines: maxLines,
      textAlign: textCenter ? TextAlign.center : null,
      style: style ??
          GoogleFonts.poppins(
            letterSpacing: laterspacing,
            color: color,
            fontSize: fontsize,
            fontWeight: fontWeight,
            wordSpacing: wordspace,
            decoration: decoration,
            foreground: foreground,
          ),
    );
  }
}
