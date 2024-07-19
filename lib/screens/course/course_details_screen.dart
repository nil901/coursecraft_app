import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/cource_payment.dart';
import 'package:coursecraft_app/screens/course/course_basic_details_screen.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key, this.access});
  final access;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
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
                  sizeBoxHeight(25),
                  courseData(),
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
        Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h),
        AppText(
            text: 'Course Details',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        Image.asset('${AppImages.courseImages}backarrow.png',
            height: 13.h, color: Colors.transparent),
      ],
    );
  }

  Widget courseImage() {
    return InkWell(
      onTap: (){
         Navigator.pushReplacement(context, CupertinoPageRoute(
                builder: (context) {
                  return CourcePayment();
                },
              ));
      },
      child: Image.asset('${AppImages.courseImages}coursede.png'));
  }

  Widget courseData() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                Navigator.pushReplacement(context, CupertinoPageRoute(
                  builder: (context) {
                    return const CourseBasicDetailsScreen();
                  },
                ));
              });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        '${AppImages.courseImages}play.png',
                        height: 30.h,
                        color:
                            selectedIndex == index ? AppColor.blackcolor : null,
                      ),
                      sizeBoxWidth(18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                              text: 'Introduction',
                              color: AppColor.blackcolor,
                              fontWeight: FontWeight.w600,
                              fontsize: 12.sp),
                          AppText(
                              text: '2 Min 30 Sec',
                              color: AppColor.greycolor,
                              fontWeight: FontWeight.w400,
                              fontsize: 9.sp),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    '${AppImages.courseImages}lock.png',
                    height: 23.h,
                    color: selectedIndex == index ? AppColor.blackcolor : null,
                  ),
                ],
              ),
            ),
          );
        });
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
        Container(
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
        )
      ],
    );
  }
}
