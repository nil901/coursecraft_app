// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:coursecraft_app/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFormField extends StatelessWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool hideOutline;
  final TextInputAction? inputAction;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final inputFormatters;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(String)? onsubmite;
  final String? initialValue;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final Color? background;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextFormField(
      {super.key,
      this.hint,
      this.hintStyle,
      this.label,
      this.focusNode,
      this.inputAction,
      this.maxLength,
      this.onChanged,
      this.onsubmite,
      this.inputFormatters,
      this.controller,
      this.initialValue,
      this.errorText,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.hideOutline = false,
      this.suffixIcon,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.background,
      this.minLines,
      this.maxLines,
      this.cursorColor,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.textfieldbgcolor,
          borderRadius: BorderRadius.circular(3.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 1)
          ]),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onsubmite,
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: cursorColor ?? AppColor.blackcolor,
        obscureText: obscureText,
        readOnly: readOnly,
        textInputAction: textInputAction,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.blackcolor),
        cursorHeight: 15.h,
        decoration: InputDecoration(
          filled: background != null ? true : false,
          fillColor: background ?? Colors.transparent,
          isDense: true,
          constraints: const BoxConstraints(maxHeight: 40, minHeight: 35),
          counterText: '',
          errorText: errorText,
          errorStyle:
              GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(15, 14, 15, 12),
          labelStyle: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
          hintStyle: hintStyle ??
              GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greycolor),
          label: Text(label ?? ""),
          hintText: hint!,
          border: InputBorder.none,
          focusColor: const Color(0xfffafafa),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: validator,
      ),
    );
  }
}

class SearchAppTextFormField extends StatelessWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool hideOutline;
  final TextInputAction? inputAction;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool obscureText;
  final inputFormatters;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(String)? onsubmite;
  final String? initialValue;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final Color? background;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;

  const SearchAppTextFormField(
      {super.key,
      this.hint,
      this.hintStyle,
      this.label,
      this.focusNode,
      this.inputAction,
      this.maxLength,
      this.onChanged,
      this.onsubmite,
      this.inputFormatters,
      this.controller,
      this.initialValue,
      this.errorText,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.hideOutline = false,
      this.suffixIcon,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.background,
      this.minLines,
      this.maxLines,
      this.cursorColor,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.textfieldbgcolor,
          borderRadius: BorderRadius.circular(7.r),
          boxShadow: [
            BoxShadow(
                blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 1)
          ]),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onsubmite,
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: cursorColor ?? AppColor.blackcolor,
        obscureText: obscureText,
        readOnly: readOnly,
        textInputAction: textInputAction,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.blackcolor),
        cursorHeight: 15.h,
        decoration: InputDecoration(
          filled: background != null ? true : false,
          fillColor: background ?? Colors.transparent,
          isDense: true,
          constraints: const BoxConstraints(maxHeight: 50, minHeight: 35),
          counterText: '',
          errorText: errorText,
          errorStyle:
              GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(15, 14, 15, 16),
          labelStyle: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
          hintStyle: hintStyle ??
              GoogleFonts.poppins(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.greycolor),
          label: Text(label ?? ""),
          hintText: hint!,
          border: InputBorder.none,
          focusColor: const Color(0xfffafafa),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: validator,
      ),
    );
  }
}
