import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBlackButton extends StatelessWidget {
  final String buttonText;
  final double? width;
  final Function onpressed;
  final bool isLoading;

  const AppBlackButton({
    super.key,
    required this.buttonText,
    this.width,
    required this.onpressed,  this.isLoading= false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.blackcolor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(3, 3))
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isLoading ?Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
            
              child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white,)),
          ],
        ): Center(
          child: AppText(
            fontsize: 15.sp,
            text: buttonText,
            color: AppColor.whitecolor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class AppWhiteButton extends StatelessWidget {
  final String buttonText;
  final double? width;
  final Function onpressed;
  final bool isLoading;

  const AppWhiteButton({
    super.key,
    required this.buttonText,
    
    this.width,
    required this.onpressed,  this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        height: 45.h,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.whitecolor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(3, 3))
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isLoading ? CircularProgressIndicator():Center(
          child: AppText(
            fontsize: 15.sp,
            text: buttonText,
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
