import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int selectedIndex = 1;
  final _auth = FirebaseAuth.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Map<String, dynamic>> _videos = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
      fetchData();
  }

  Future<void> _fetchVideos() async {
    try {
      List<Map<String, dynamic>> files = [];

      final ListResult result = await _storage.ref().listAll();
      final List<Reference> allFiles = result.items;

      await Future.forEach<Reference>(allFiles, (file) async {
        final String fileURL = await file.getDownloadURL();
        final FullMetadata fileMeta = await file.getMetadata();

        files.add({
          "url": fileURL,
          "name": file.name,
          "size": fileMeta.size,
        });
      });

      setState(() {
        _videos = files;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<Map<String, String?>> fetchtrsactionid() async {
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

      // Get transaction ID and status
      String? imageUrl = data['title'];
      String? transactionId = data['transactionId'];
      String? userName = data['userName'];
      String? transactionStatus = data['transactionStatus']; // Assuming this field exists

      // Determine if the transaction is successful
      bool isTransactionSuccessful = transactionStatus == 'true'; // Adjust as needed

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


String? transactionId ;
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
    return Scaffold(
      appBar: AppBar(  
        leading: Icon(Icons.arrow_back),
      ),
      body:    _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _videos.isEmpty
                  ? Center(child: Text('No videos found'))
                  : ListView.builder(
                    shrinkWrap: true,
                      itemCount: _videos.length,
                      itemBuilder: (context, index) {
                        final video = _videos[index];
                        return  topcoursesDetails(
                              video['name'], video['url']
                        );
                      },
                    ),
    );
  }
  Widget topcoursesDetails(String title,url) {
  return GestureDetector(
    onTap: () {
      print("$url");
      Navigator.pushReplacement(context, CupertinoPageRoute(
        builder: (context) {
          return  CourseDetailsScreen(
          //  access: transactionId,
            url:url ,

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
      padding: EdgeInsets.only(bottom: 0.h),
      child: Container(
        height: 107,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColor.grey2color, width: 2),
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
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
                        SizedBox(width: 5), // Replace with your sizeBoxWidth(5)
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.grey2color, width: 2),
                          ),
                          child: const Icon(Icons.favorite_border, size: 17),
                        ),
                      ],
                    ),
                    SizedBox(height: 5), // Replace with your sizeBoxHeight(5)
                    Row(
                      children: [
                        Image.asset('${AppImages.homeImages}play.png', height: 10.h),
                        AppText(
                          text: '  14 Lectures',
                          color: AppColor.greycolor,
                          fontWeight: FontWeight.w400,
                          fontsize: 8.sp,
                        ),
                        SizedBox(width: 12), // Replace with your sizeBoxWidth(12)
                        Image.asset('${AppImages.homeImages}time.png', height: 10.h),
                        AppText(
                          text: '  40 Hours 30 min',
                          color: AppColor.greycolor,
                          fontWeight: FontWeight.w400,
                          fontsize: 8.sp,
                        ),
                      ],
                    ),
                  
                    // Row(
                    //   children: [
                    //     Icon(Icons.star, color: AppColor.yellowcolor, size: 12.sp),
                    //     AppText(
                    //       text: ' 4.9',
                    //       color: AppColor.blackcolor,
                    //       fontWeight: FontWeight.w700,
                    //       fontsize: 8.sp,
                    //     ),
                    //     AppText(
                    //       text: '  (37 Reviews)',
                    //       color: AppColor.greycolor,
                    //       fontWeight: FontWeight.w400,
                    //       fontsize: 8.sp,
                    //     ),
                    //   ],
                    // ),
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

