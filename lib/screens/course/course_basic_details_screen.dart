import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/cource_payment.dart';
import 'package:coursecraft_app/screens/course/review_summary_screen.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseBasicDetailsScreen extends StatefulWidget {
  const CourseBasicDetailsScreen({super.key});

  @override
  State<CourseBasicDetailsScreen> createState() =>
      _CourseBasicDetailsScreenState();
}

class _CourseBasicDetailsScreenState extends State<CourseBasicDetailsScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appBar(),
                  sizeBoxHeight(25),
                  courseImage(),
                  sizeBoxHeight(32),
                  advanceExcel(),
                  sizeBoxHeight(20),
                  mentor(),
                  sizeBoxHeight(20),
                  aboutThis(),
                  const Spacer(),
                  purchaseNow(),
                  sizeBoxHeight(25),
                ],
              ),
            ),
          ),
          Expanded(child: homeFrameImage())
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
           onTap: (){
           // Navigator.pop(context);
          },child: Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h)),
        AppText(
            text: 'Course Details',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset('${AppImages.courseImages}backarrow.png',
              height: 13.h, color: Colors.transparent),
        ),
      ],
    );
  }

  Widget courseImage() {
    return InkWell(
      onTap: (){
           Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const CourcePayment();
          },));
      },
      child: Image.asset('${AppImages.courseImages}coursede.png'));
  }

  Widget advanceExcel() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Basix to Advance Excel',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w600,
                fontsize: 15.sp),
            Image.asset('${AppImages.courseImages}share.png', height: 30.h)
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: AppColor.yellowcolor, size: 14.sp),
            AppText(
                text: ' 4.9',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w700,
                fontsize: 13.sp),
            AppText(
                text: ' (37 Reviews)',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp),
            sizeBoxWidth(16),
            Image.asset('${AppImages.homeImages}time.png',
                height: 11.h, color: AppColor.greencolor),
            AppText(
                text: '  40 Hours 30 min',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp),
          ],
        ),
      ],
    );
  }

  Widget mentor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Mentor',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.grey2color,
                      borderRadius: BorderRadius.circular(40.r)),
                ),
                sizeBoxWidth(11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: 'Adsmain Joseph',
                        color: AppColor.blackcolor,
                        fontWeight: FontWeight.w600,
                        fontsize: 12.sp),
                    AppText(
                        text: 'Mentor :Excel Course',
                        color: AppColor.grey1color,
                        fontWeight: FontWeight.w400,
                        fontsize: 9.sp),
                  ],
                )
              ],
            ),
            AppText(
                text: '1k+ Enroll',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w600,
                fontsize: 14.sp),
          ],
        ),
      ],
    );
  }

  Widget aboutThis() {
    return Column(
      children: [
        AppText(
            text: 'About this course',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('${AppImages.courseImages}member.png',
                    height: 11.h),
                AppText(
                    text: '   420 Members',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
            Row(
              children: [
                Image.asset('${AppImages.homeImages}play.png', height: 11.h),
                AppText(
                    text: '   14 Courses',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
            Row(
              children: [
                Image.asset('${AppImages.courseImages}certificate.png',
                    height: 11.h),
                AppText(
                    text: '   Certificate',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
          ],
        ),
        sizeBoxHeight(20),
        AppText(
            text:
                'Lorem ipsum dolor sit amet consectetur. Nibh et pellent esque urna est egestas. Tincidunt gravida tincidunt imperdiet vestibulum. Accumsan facilisis sagittis felis et. Feugiat pulvinar pellentesque blandit',
            color: AppColor.grey1color,
            fontWeight: FontWeight.w400,
            fontsize: 11.sp),
      ],
    );
  }

  Widget purchaseNow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
            text: '\$120.00',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 18.sp),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return const ReviewSummaryScreen();
              },
            ));
          },
          child: Container(
            height: 48,
            width: 196,
            decoration: BoxDecoration(
                color: AppColor.blackcolor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: AppText(
                  text: 'Purchase Now',
                  color: AppColor.whitecolor,
                  fontWeight: FontWeight.w600,
                  fontsize: 15.sp),
            ),
          ),
        )
      ],
    );
  }
}
