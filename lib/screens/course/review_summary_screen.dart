import 'package:coursecraft_app/core/app_button.dart';
import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/questions%20and%20answers/questions_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewSummaryScreen extends StatefulWidget {
  const ReviewSummaryScreen({super.key});

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
        child: Column(
          children: [
            appBar(),
            sizeBoxHeight(23),
            basicToAdvance(),
            sizeBoxHeight(23),
            language(),
            const Spacer(),
            purchaseNowButton(),
            sizeBoxHeight(20),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h),
        AppText(
            text: 'Review Summary',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        Image.asset('${AppImages.courseImages}backarrow.png',
            height: 13.h, color: Colors.transparent),
      ],
    );
  }

  Widget basicToAdvance() {
    return Container(
      height: 107,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColor.grey2color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset('${AppImages.homeImages}course.png'),
            sizeBoxWidth(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: AppColor.yellowcolor, size: 12.sp),
                    AppText(
                        text: ' 4.9',
                        color: AppColor.blackcolor,
                        fontWeight: FontWeight.w700,
                        fontsize: 9.sp),
                    AppText(
                        text: '  (37 Reviews)',
                        color: AppColor.greycolor,
                        fontWeight: FontWeight.w400,
                        fontsize: 10.sp)
                  ],
                ),
                sizeBoxHeight(5),
                AppText(
                    text: 'Basic to Advance Excel',
                    color: AppColor.blackcolor,
                    fontWeight: FontWeight.w600,
                    fontsize: 12.sp),
                sizeBoxHeight(5),
                Row(
                  children: [
                    Icon(Icons.people_alt_sharp,
                        color: AppColor.greycolor, size: 8.sp),
                    AppText(
                        text: '   Adsmain Joseph',
                        color: AppColor.greycolor,
                        fontWeight: FontWeight.w400,
                        fontsize: 8.sp),
                  ],
                ),
                sizeBoxHeight(5),
                Row(
                  children: [
                    Container(
                      height: 12.h,
                      width: 33.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColor.blue1color),
                      child: Center(
                        child: AppText(
                            text: '\$120.00',
                            color: AppColor.bluecolor,
                            fontWeight: FontWeight.w600,
                            fontsize: 8.sp),
                      ),
                    ),
                    sizeBoxWidth(20),
                    Container(
                      height: 12.h,
                      width: 33.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColor.yellow1color),
                      child: Center(
                        child: AppText(
                            text: 'Bestseller',
                            color: AppColor.yellowcolor,
                            fontWeight: FontWeight.w400,
                            fontsize: 6.sp),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget language() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Language',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: 'English',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Lessons',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: '14',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Level',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: 'Beginner',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(20),
        const Divider(),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Amount',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: '\$120.00',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Tax',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: '\$5.00',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(20),
        const Divider(),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Total',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
            AppText(
                text: '\$125.00',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w500,
                fontsize: 11.sp),
          ],
        ),
        sizeBoxHeight(20),
        const Divider(),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('${AppImages.courseImages}paypal.png',
                    height: 11.h),
                AppText(
                    text: '  Paypal',
                    color: AppColor.greycolor,
                    fontWeight: FontWeight.w500,
                    fontsize: 11.sp),
              ],
            ),
            AppText(
                text: 'Change',
                color: AppColor.bluecolor,
                fontWeight: FontWeight.w600,
                fontsize: 11.sp),
          ],
        ),
      ],
    );
  }

  Widget purchaseNowButton() {
    return AppBlackButton(
        buttonText: 'Purchase Now',
        onpressed: () {
          Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context) {
              return const QuestionsScreen();
            },
          ));
        });
  }
}
