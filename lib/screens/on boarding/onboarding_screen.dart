import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/auth/signup_screen.dart';
import 'package:coursecraft_app/screens/on%20boarding/onboarding_contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  bool isLoginSelected = false;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    Color dotColor = AppColor.whitecolor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage == index ? dotColor : const Color(0xffD0D0D0),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 5,
      curve: Curves.easeIn,
      width: _currentPage == index ? 15 : 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackcolor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemCount: contents.length,
            itemBuilder: (context, i) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    contents[i].image,
                    height: MediaQuery.of(context).size.height / 2.8,
                  ),
                  sizeBoxHeight(35),
                  AppText(
                    text: contents[i].title,
                    fontsize: 18.sp,
                    color: AppColor.whitecolor,
                    textCenter: true,
                    fontWeight: FontWeight.w600,
                  ),
                  sizeBoxHeight(20),
                  AppText(
                    text: contents[i].desc,
                    fontsize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.whitecolor,
                    textCenter: true,
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 44, bottom: 68),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (int index) => _buildDots(
                      index: index,
                    ),
                  ),
                ),
                sizeBoxHeight(72),
                _currentPage == 1
                    ? Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.whitecolor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w, right: 3.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLoginSelected = false;
                                        Navigator.pushReplacement(context,
                                            CupertinoPageRoute(
                                          builder: (context) {
                                            return const SignUpScreen();
                                          },
                                        ));
                                      });
                                    },
                                    child: Container(
                                      height: 43,
                                      decoration: BoxDecoration(
                                          color: isLoginSelected
                                              ? AppColor.whitecolor
                                              : AppColor.blackcolor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: AppText(
                                          text: 'Sign Up',
                                          color: isLoginSelected
                                              ? AppColor.blackcolor
                                              : AppColor.whitecolor,
                                          fontWeight: FontWeight.w500,
                                          fontsize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizeBoxWidth(10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLoginSelected = true;
                                      });
                                    },
                                    child: Container(
                                      height: 43,
                                      decoration: BoxDecoration(
                                          color: isLoginSelected
                                              ? AppColor.blackcolor
                                              : AppColor.whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: AppText(
                                          text: 'Log In',
                                          color: isLoginSelected
                                              ? AppColor.whitecolor
                                              : AppColor.blackcolor,
                                          fontWeight: FontWeight.w500,
                                          fontsize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
