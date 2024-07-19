import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/auth/login_screen.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:coursecraft_app/screens/widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;
   final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 30.h),
                child: Column(
                  children: [
                    findyourbest(),
                    sizeBoxHeight(30),
                    // searchTextfield(),
                    // sizeBoxHeight(40),
                    // continueyour(),
                    // sizeBoxHeight(40),
                    // topcategory(),
                    // sizeBoxHeight(25),
                    // topcategoryDetails(),
                    sizeBoxHeight(40),
                    topcourses(),
                    sizeBoxHeight(25),
                    topcoursesDetails(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: homeFrameImage())
        ],
      ),
    );
  }

  Widget findyourbest() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                    text: 'Find Your ',
                    color: AppColor.blackcolor,
                    fontWeight: FontWeight.w600,
                    fontsize: 20.sp),
                AppText(
                    text: 'Best',
                    color: AppColor.redcolor,
                    fontWeight: FontWeight.w600,
                    fontsize: 20.sp),
              ],
            ),
            AppText(
                text: 'Online Course!!',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w600,
                fontsize: 20.sp),
          ],
        ),
        Row(
          children: [
           
            sizeBoxWidth(15),
            Image.asset('${AppImages.homeImages}cart.png', height: 15.h),
              SizedBox(width: 10,),
              
              InkWell(
   onTap: (){
   _auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, StackTrace) {
                  debugPrint(error.toString());
                  final snackBar = SnackBar(
                    content: Text('Login Logout ${error.toString()}'),
                    backgroundColor: Colors.black,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
                child: Icon(Icons.logout))
          ],
        )
      ],
    );
  }

  Widget searchTextfield() {
    return Row(
      children: [
        SizedBox(
          width: 240.w,
          child: SearchAppTextFormField(
            label: '',
            hint: 'Search',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 2.w, top: 13.h, bottom: 13.h),
              child: Image.asset(
                '${AppImages.homeImages}search.png',
              ),
            ),
          ),
        ),
        sizeBoxWidth(10),
        Container(
          height: 47,
          width: 47,
          decoration: BoxDecoration(
              color: AppColor.textfieldbgcolor,
              borderRadius: BorderRadius.circular(7.r),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 1)
              ]),
          child: Center(
            child: Image.asset(
              '${AppImages.homeImages}filter.png',
              height: 13.h,
            ),
          ),
        )
      ],
    );
  }

  Widget continueyour() {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColor.blackcolor,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                    text: 'Continue your lessons',
                    color: AppColor.whitecolor,
                    fontWeight: FontWeight.w600,
                    fontsize: 13.sp),
                sizeBoxHeight(10.h),
                AppText(
                    text:
                        'Nullam quis pretium ac dictum venenatis\nfeugiat dui. Urna mauris nisl dapibus\ntortor ',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w400,
                    fontsize: 7.sp),
              ],
            ),
            Image.asset('${AppImages.homeImages}lesson.png', height: 45.h),
          ],
        ),
      ),
    );
  }

  Widget topcategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
            text: 'Top Category',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 14.sp),
        AppText(
            text: 'Sell All',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 10.sp)
      ],
    );
  }

  // Widget topcategoryDetails() {
  //   return Stack(
  //     alignment: Alignment.topCenter,
  //     children: [
  //       Container(
  //         height: 70,
  //         width: 70,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(80.r),
  //             border: Border.all(color: AppColor.grey2color)),
  //         child: Center(
  //           child: AppText(
  //               text: 'Design',
  //               color: AppColor.blackcolor,
  //               fontWeight: FontWeight.w400,
  //               fontsize: 10.sp),
  //         ),
  //       ),
  //       Positioned(
  //         top: -10.0,
  //         child: Image.asset(
  //           '${AppImages.homeImages}design.png',
  //           height: 35.h,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget topcategoryDetails() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              height: 70,
              width: 70,
              margin: EdgeInsets.only(right: 15.w),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColor.blackcolor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: AppColor.grey2color),
              ),
              child: Center(
                child: AppText(
                  text: 'Design',
                  color: selectedIndex == index
                      ? AppColor.whitecolor
                      : AppColor.blackcolor,
                  fontWeight: FontWeight.w400,
                  fontsize: 10.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget topcourses() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
            text: 'Top Courses',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 14.sp),
        AppText(
            text: 'Sell All',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 10.sp)
      ],
    );
  }
  String? access;
Future<Map<String, String?>> fetchImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case where there is no authenticated user
      return {};
    }

    String userId = user.uid;
    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child('users/$userId');
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      // Add a null check before accessing the key
      final data = snapshot.value as Map<dynamic, dynamic>;
     access =
          data['transactionStatus']; // Assuming this field exists

      // Determine if the transaction is successful
      bool isTransactionSuccessful =
          access == 'true'; // Adjust as needed

      // Print transaction status
      if (isTransactionSuccessful) {
        print("Transaction is successful");
      } else {
        print("Transaction is not successful");
      }

      return {
        'transactionStatus': access,
      };
    } else {
      print("No data found for user");
      return {};
    }
  }
  Widget topcoursesDetails() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(
                builder: (context) {
                  return const CourseDetailsScreen(access:5 ,);
                },
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
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
                              AppText(
                                  text: 'Basic to Advance Excel',
                                  color: AppColor.blackcolor,
                                  fontWeight: FontWeight.w600,
                                  fontsize: 12.sp),
                              sizeBoxWidth(13),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColor.grey2color, width: 2),
                                ),
                                child:
                                    const Icon(Icons.favorite_border, size: 17),
                              )
                            ],
                          ),
                          sizeBoxHeight(5),
                          Row(
                            children: [
                              Image.asset('${AppImages.homeImages}play.png',
                                  height: 10.h),
                              AppText(
                                  text: '  14 Lectures',
                                  color: AppColor.greycolor,
                                  fontWeight: FontWeight.w400,
                                  fontsize: 8.sp),
                              sizeBoxWidth(12),
                              Image.asset('${AppImages.homeImages}time.png',
                                  height: 10.h),
                              AppText(
                                  text: '  40 Hours 30 min',
                                  color: AppColor.greycolor,
                                  fontWeight: FontWeight.w400,
                                  fontsize: 8.sp),
                            ],
                          ),
                          sizeBoxHeight(8),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: AppColor.yellowcolor, size: 12.sp),
                              AppText(
                                  text: ' 4.9',
                                  color: AppColor.blackcolor,
                                  fontWeight: FontWeight.w700,
                                  fontsize: 8.sp),
                              AppText(
                                  text: '  (37 Reviews)',
                                  color: AppColor.greycolor,
                                  fontWeight: FontWeight.w400,
                                  fontsize: 8.sp)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget homeFrameImage() {
  return Image.asset(
    '${AppImages.homeImages}homeframe1.png',
    height: double.infinity,
    fit: BoxFit.fitHeight,
  );
}
