import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsAnswersScreen extends StatefulWidget {
  const QuestionsAnswersScreen({super.key});

  @override
  State<QuestionsAnswersScreen> createState() => _QuestionsAnswersScreenState();
}

class _QuestionsAnswersScreenState extends State<QuestionsAnswersScreen> {
  int selectedAnswerIndex = -1;

  List<String> answers = [
    'Select None on the Border tab of Format cells',
    'Open the list on the Border tool in the Format Cell toolbar then choose the first tool (none)',
    'Both of above',
    'None of above',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appBar(),
              sizeBoxHeight(25),
              questionData(),
              sizeBoxHeight(25),
              endButton(),
              sizeBoxHeight(25),
            ],
          ),
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
            text: 'Questions and Answers',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        Image.asset('${AppImages.courseImages}backarrow.png',
            height: 13.h, color: Colors.transparent),
      ],
    );
  }

  Widget questionData() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Column(
              children: [
                Container(
                  height: 41.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.grey3color,
                      borderRadius: BorderRadius.circular(7.r)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      children: [
                        AppText(
                            text: '1. How to remove borders applied in Cells?',
                            color: AppColor.blackcolor,
                            fontWeight: FontWeight.w400,
                            fontsize: 11.sp),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: answers
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Material(
                                type: MaterialType.canvas,
                                shadowColor: AppColor.grey2color,
                                child: Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  activeColor: AppColor.blackcolor,
                                  value: selectedAnswerIndex == entry.key,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswerIndex =
                                          value! ? entry.key : -1;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    color: AppColor.greycolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          );
        });
  }

  Widget endButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 48,
        width: 205,
        decoration: BoxDecoration(
            color: AppColor.blackcolor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: AppText(
              text: 'End Exam',
              color: AppColor.whitecolor,
              fontWeight: FontWeight.w600,
              fontsize: 15.sp),
        ),
      ),
    );
  }
}
