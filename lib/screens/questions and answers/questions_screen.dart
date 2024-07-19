import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/questions%20and%20answers/questions_answers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List questionListData = [
  '1. How to remove borders applied in Cells?',
  '2. How to remove borders applied in Cells?',
  '3. How to remove borders applied in Cells?',
  '4. How to remove borders applied in Cells?',
  '5. How to remove borders applied in Cells?',
  '6. How to remove borders applied in Cells?',
  '7. How to remove borders applied in Cells?',
  '8. How to remove borders applied in Cells?',
  '9. How to remove borders applied in Cells?',
  '10. How to remove borders applied in Cells?',
];

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
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
                  questionList(),
                  const Spacer(),
                  startButton(),
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
            text: 'Questions and Answers',
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

  Widget questionList() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: questionListData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 13.h),
            child: Container(
              height: 41.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: AppColor.grey2color, width: 2),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    AppText(
                        text: questionListData[index],
                        color: AppColor.blackcolor,
                        fontWeight: FontWeight.w400,
                        fontsize: 11.sp),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget startButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const QuestionsAnswersScreen();
          },
        ));
      },
      child: Container(
        height: 48,
        width: 205,
        decoration: BoxDecoration(
            color: AppColor.blackcolor,
            borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: AppText(
              text: 'Start Exam',
              color: AppColor.whitecolor,
              fontWeight: FontWeight.w600,
              fontsize: 15.sp),
        ),
      ),
    );
  }
}
