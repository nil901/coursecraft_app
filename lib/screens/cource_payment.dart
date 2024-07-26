import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursecraft_app/conts/utils.dart';
import 'package:coursecraft_app/core/app_button.dart';
import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/auth/login_screen.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CourcePayment extends StatefulWidget {
  const CourcePayment({super.key});

  @override
  State<CourcePayment> createState() => _CourcePaymentState();
}

class _CourcePaymentState extends State<CourcePayment> {
  TextEditingController trsactionCntroller = TextEditingController();
  File? _image;
  bool isLoading = false;
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  TextEditingController TrsactionController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference _database = FirebaseDatabase.instance.ref('users');

  Future<void> UploadImage(
      File imageFile, String userId, String userName) async {
    setState(() {
      isLoading = true;
    });
    try {
      String imageName = imageFile.path.split('/').last;
      print("Image Name: $imageName");
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/Pyment/$imageName');
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask;
      String downloadUrl = await ref.getDownloadURL();
      await FirebaseDatabase.instance.reference().child('users/$userId').set({
        "id": userId,
        "image": downloadUrl,
        "transactionId": trsactionCntroller.text,
        "transactionStatus": 'false',
        "userName": userName,
        "CourseName": "Excel Course"
      });
      print("Upload successful: $downloadUrl");
        Utils().tostMessage("Upload successful. Please note that processing may take 2-3 hours.");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ImageDisplayScreen()));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Failed to upload image: $e");
    }
  }

  String? userName;
  Future<String?> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is currently signed in.");
      return null;
    }

    try {
      // Debug print
      print("User ID: ${user.uid}");

      // Fetch user document from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Debug print for document existence
      print("Document exists: ${doc.exists}");

      if (doc.exists) {
        // Debug print for document data
        print("Document data: ${doc.data()}");

        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          // Debug print for name field
          userName = data['name'];
          print("Name field: ${data['name']}");
          return data['name'] as String?;
        } else {
          print("Data retrieved is null or not in expected format.");
          return null;
        }
      } else {
        print("No user data found in Firestore.");
        return null;
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      return null;
    }
  }

  @override
  void initState() {
    getUserName();
    // TODO: implement initState
    super.initState();
  }

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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/course/qrpyment.jpg"))),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  emailTextfiled(),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                        text: 'Enter transaction id',
                        color: AppColor.greycolor,
                        fontWeight: FontWeight.w400,
                        fontsize: 12.sp),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _image == null
                      ? InkWell(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: AppText(
                                text: 'Chosse File',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontsize: 12.sp),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: AppText(
                                      text: 'Chosse File',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontsize: 12.sp),
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 202, 197, 197),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.file(
                                        _image!,
                                        height: 80,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            print("kdkdk");

                                            _image = null;
                                          },
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  loginButton()
                ],
              ),
            ),
          ),
          Expanded(child: homeFrameImage())
        ],
      ),
    );
  }

  Widget emailTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Enter transaction id',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Enter transaction id',
          controller: trsactionCntroller,
        ),
      ],
    );
  }

  Widget loginButton() {
    print( "ssjsjsjsjs"+userName.toString());
    return InkWell(
      onTap: () async {
        User? user = FirebaseAuth.instance.currentUser;
        getUserName();
        if (user == null) {
          print("User not authenticated");
          return;
        }
        if (trsactionCntroller.text.isEmpty) {
          Utils().tostMessage("please Enter Transaction Id");
        } else if(_image == null) {
           Utils().tostMessage("please Upload Image");
         
        }else{
           await UploadImage(_image!, user.uid, userName.toString());
        }
        // // try {

        //   // Upload the file
        //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/foldername/1234');
        //   firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
        //   await uploadTask;  // Await the upload task to complete

        //   // Get the download URL
        //   String newurl = await ref.getDownloadURL();

        //   // Update the database with the new URL
        //   await _database.child(user.uid).set({"id": user.uid, "title": newurl});
        //   print("Upload and database update successful");

        // } catch (e) {
        //   print("Error: $e");
        // }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: isLoading
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  )
                ],
              )
            : Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
      ),
    );
  }
}

Widget appBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h),
      AppText(
          text: 'courses Payments ',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w600,
          fontsize: 13.sp),
      InkWell(
        onTap: () {
            // Navigator.pop(context);
        },
        child: Image.asset('${AppImages.courseImages}backarrow.png',
            height: 13.h, color: Colors.transparent),
      ),
    ],
  );
}

class ShowImageScreen extends StatelessWidget {
  final String imageUrl;

  const ShowImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploaded Image"),
      ),
      body: Center(
        child: Image.network(imageUrl), // Display the uploaded image
      ),
    );
  }
}

class ImageDisplayScreen extends StatefulWidget {
  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  late Future<Map<String, String?>> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture =
        fetchImage(); // Fetch image URL and transaction ID when the screen is initialized
  }

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

      // Get transaction ID and status
      String? imageUrl = data['title'];
      String? transactionId = data['transactionId'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Image'),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No image found.'));
          } else {
            String? imageUrl = snapshot.data!['title'];
            String? transactionId = snapshot.data!['transactionId'];
            String? userName = snapshot.data!['userName'];
             String? stutus = snapshot.data!['transactionStatus'];
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Uploaded Image:', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  if (imageUrl != null) Image.network(imageUrl, height: 500),
                  SizedBox(height: 20),
                  if (transactionId != null)
                    Text('Transaction ID: $stutus',
                        style: TextStyle(fontSize: 16)),
                  if (transactionId != null)
                    Text('user Name : $userName',
                        style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
