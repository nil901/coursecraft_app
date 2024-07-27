import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/auth/login_screen.dart';
import 'package:coursecraft_app/screens/cart_screen.dart';
import 'package:coursecraft_app/screens/cource_payment.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:coursecraft_app/screens/course_payment.dart';
import 'package:coursecraft_app/screens/widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.folderPath = '/'});

  final String folderPath;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;
  final _auth = FirebaseAuth.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Map<String, dynamic>> _videos = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _listItems();
    fetchData();
  }

  List<Reference> _folders = [];
  List<Reference> _files = [];
  Map<String, String> _fileUrls = {}; // Store file URLs

  Future<void> _listItems() async {
    try {
      final ListResult result = await _storage.ref(widget.folderPath).listAll();

      // Debugging information
      print('Listing items in: ${widget.folderPath}');
      print('All Folders:');
      result.prefixes.forEach((folder) {
        print(folder.fullPath);
      });

      print('Files:');
      result.items.forEach((file) {
        print(file.fullPath);
      });

      // Retrieve download URLs for files
      for (Reference file in result.items) {
        final String url = await file.getDownloadURL();
        _fileUrls[file.name] = url;
        print('File: ${file.name}, URL: $url');
      }

      setState(() {
        // Remove the "pyment" folder from the list
        _folders = result.prefixes
            .where((folder) => folder.name.toLowerCase() != 'pyment')
            .toList();
        _files = result.items; // Optionally, display files if needed
      });
    } catch (e) {
      print('Error listing items: $e');
    }
  }

  void _openFolder(Reference folder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StorageListPage(folderPath: folder.fullPath),
      ),
    );
  }

  void _playVideo(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(videoUrl: url),
      ),
    );
  }


  Future<Map<String, String?>> fetchtrsactionid() async {
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

      // Get transaction ID and status
      String? imageUrl = data['title'];
      transactionId = data['transactionId'];
      String? userName = data['userName'];
      String? transactionStatus =
          data['transactionStatus']; // Assuming this field exists

      // Determine if the transaction is successful
      bool isTransactionSuccessful =
          transactionStatus == 'true'; // Adjust as needed

      // Print transaction status
      if (isTransactionSuccessful) {
        print("Transaction is successful");
      } else {
        print("Transaction is not successful");
      }

      return {
        'title': imageUrl,
        'transactionId': transactionId,
        'transactionStatus': transactionStatus,
        'userName': userName
      };
    } else {
      print("No data found for user");
      return {};
    }
  }

  String? transactionId;
  void fetchData() async {
    Map<String, String?> data = await fetchtrsactionid();
    transactionId = data['transactionStatus'];
    if (transactionId != null) {
      print("Transaction ID: $transactionId");
    } else {
      print("Transaction ID not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _oneButtonPressed(context),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.w, left: 15.w,),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          findyourbest(), 
                         
                          // searchTextfield(),
                          sizeBoxHeight(40),
                          // continueyour(),
                          // sizeBoxHeight(40),
                          // topcategory(),
                          // sizeBoxHeight(25),
                          // topcategoryDetails(),
                       
                          // topcourses(),
                          // sizeBoxHeight(25),
                          //           _isLoading
                          // ? Center(child: CircularProgressIndicator())
                          // : _error != null
                          //     ? Center(child: Text('Error: $_error'))
                          //     : _videos.isEmpty
                          //         ? Center(child: Text('No videos found'))
                          //         : ListView.builder(
                          //           physics: NeverScrollableScrollPhysics(),
                          //           shrinkWrap: true,
                          //             itemCount: _videos.length,
                          //             itemBuilder: (context, index) {
                          //               final video = _videos[index];
                                        // return  topcoursesDetails(
                                        //       video['name'], video['url']
                                        // );
                          //             },
                          //           ),
          
                          ListView(
                            shrinkWrap: true,
                            children: [
                              // Conditionally render ListTile for folders excluding "pyment"
                              if (_folders.isNotEmpty) ...[
                                ..._folders.map((folder) =>topcoursesDetails(
                                            folder.name, folder
                                        ))
                              ] else ...[
                                // Center(child: Text('No folders found')),
                              ],
                              // Optionally display files
                              ..._files.map((file) => ListTile(
                                    leading: Icon(Icons.file_present),
                                    title: Text(file.name),
                                    //  subtitle: Text(_fileUrls[file.name] ?? 'Fetching URL...'),
                                    onTap: () {
                                      if (_fileUrls[file.name] != null) {
                                        _playVideo(_fileUrls[file.name]!);
                                      }
                                    },
                                  )),
                            ],
                          ),
                          // FutureBuilder(
                          //   future: _listVideos(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return const Center(
                          //           child: CircularProgressIndicator());
                          //     }
                          //     if (snapshot.hasError) {
                          //       return Center(
                          //           child: Text('Error: ${snapshot.error}'));
                          //     }
                          //     final List<Map<String, dynamic>> videos =
                          //         snapshot.data as List<Map<String, dynamic>>;
                          //     return ListView.builder(
                          //       shrinkWrap: true,
                          //       itemCount: videos.length,
                          //       itemBuilder: (context, index) {
                          //         final video = videos[index];
                          //         return topcoursesDetails(
                          //           video['name'],
                          //         );
                          //       },
                          //     );
                          //   },
                          // )
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: homeFrameImage())
              ],
            ),
          ),
        ),
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
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Image.asset('${AppImages.homeImages}cart.png',
                    height: 15.h)),
            const SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: () {
                  _auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
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
                child: const Icon(Icons.logout))
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
bool? access;

Future<Map<String, String?>> fetchImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // Handle the case where there is no authenticated user
    return {};
  }

  String userId = user.uid;
  DatabaseReference ref = FirebaseDatabase.instance.reference().child('users/$userId');
  DatabaseEvent event = await ref.once();
  DataSnapshot snapshot = event.snapshot;

  if (snapshot.value != null) {
    // Add a null check before accessing the key
    final data = snapshot.value as Map<dynamic, dynamic>;
    access = data['transactionStatus']; // Assuming this field exists

    // Determine if the transaction is successful
    bool isTransactionSuccessful = access == 'true'; // Adjust as needed

    // Print transaction status
    if (isTransactionSuccessful) {
      print("Transaction is successful");
    } else {
      print("Transaction is not successful");
    }

    return {
      'transactionStatus': access.toString(),
    };
  } else {
    print("No data found for user");
    return {};
  }
}

  Widget topcoursesDetails(String title, url) {
    return GestureDetector(
      onTap: () {
        print("$url");
       Navigator.pushReplacement(
  context,
  CupertinoPageRoute(
    builder: (context) {
      return CourseDetailsScreen(
        folderPath: url.fullPath,
        access: access, // Provide a default value if access is null
      );
    },
  ));
        // Navigator.pushReplacement(context, CupertinoPageRoute(
        //       builder: (context) {
        //         return  CourcePayment(

        //         );
        //       },
        //     ));
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
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset('${AppImages.homeImages}course.png'),
                SizedBox(width: 8), // Replace with your sizeBoxWidth(8)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: title,
                              color: AppColor.blackcolor,
                              fontWeight: FontWeight.w600,
                              fontsize: 12.sp,
                            ),
                          ),
                          SizedBox(
                              width: 5), // Replace with your sizeBoxWidth(5)
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColor.grey2color, width: 2),
                            ),
                            child: const Icon(Icons.favorite_border, size: 17),
                          ),
                        ],
                      ),
                      SizedBox(height: 5), // Replace with your sizeBoxHeight(5)
                      Row(
                        children: [
                          Image.asset('${AppImages.homeImages}play.png',
                              height: 10.h),
                          AppText(
                            text: '  14 Lectures',
                            color: AppColor.greycolor,
                            fontWeight: FontWeight.w400,
                            fontsize: 8.sp,
                          ),
                          SizedBox(
                              width: 12), // Replace with your sizeBoxWidth(12)
                          Image.asset('${AppImages.homeImages}time.png',
                              height: 10.h),
                          AppText(
                            text: '  40 Hours 30 min',
                            color: AppColor.greycolor,
                            fontWeight: FontWeight.w400,
                            fontsize: 8.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Replace with your sizeBoxHeight(8)
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: AppColor.yellowcolor, size: 12.sp),
                          AppText(
                            text: ' 4.9',
                            color: AppColor.blackcolor,
                            fontWeight: FontWeight.w700,
                            fontsize: 8.sp,
                          ),
                          AppText(
                            text: '  (37 Reviews)',
                            color: AppColor.greycolor,
                            fontWeight: FontWeight.w400,
                            fontsize: 8.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
Future<bool> _oneButtonPressed(BuildContext context) async {
    DateTime backPressedTime = DateTime.now();
    final differene = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (differene >= const Duration(seconds: 2)) {
      Fluttertoast.showToast(
        msg: "Click Again To Close The App",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0,
      );
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
Widget homeFrameImage() {
  return Image.asset(
    '${AppImages.homeImages}homeframe1.png',
    height: double.infinity,
    fit: BoxFit.fitHeight,
  );
}
