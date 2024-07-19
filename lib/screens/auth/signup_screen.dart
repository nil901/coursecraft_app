import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursecraft_app/conts/utils.dart';
import 'package:coursecraft_app/core/app_button.dart';
import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/auth/login_screen.dart';
import 'package:coursecraft_app/screens/auth/profile_screen.dart';
import 'package:coursecraft_app/screens/widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 25.h),
            child: Column(
              children: [
                getHelp(),
                sizeBoxHeight(28),
                helloBackText(),
                sizeBoxHeight(39),
                nameTextfiled(),
                sizeBoxHeight(22),
                collegeTextfiled(),
                sizeBoxHeight(22),
                addressTextfiled(),
                sizeBoxHeight(22),
                phoneTextfiled(),
                sizeBoxHeight(22),
                emailTextfiled(),
                sizeBoxHeight(40),
                passworldTextfiled(),
                sizeBoxHeight(40),
                signUpButton(),
                sizeBoxHeight(19),
                loginButton(),
                sizeBoxHeight(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHelp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText(
          text: 'Get Help ?',
          color: AppColor.greycolor,
          fontWeight: FontWeight.w500,
          fontsize: 12.sp,
        ),
      ],
    );
  }

  Widget helloBackText() {
    return Row(
      children: [
        AppText(
          text: 'Hello!',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w600,
          fontsize: 16.sp,
        ),
        AppText(
          text: ' Welcome Back,',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w400,
          fontsize: 12.sp,
        ),
      ],
    );
  }

  Widget nameTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Name',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Enter Your name',
          controller: _nameController,
        )
      ],
    );
  }

  Widget collegeTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'College Name',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Select your college name',
          controller: _collegeController,
        )
      ],
    );
  }

  Widget addressTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Address',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
            label: '',
            hint: 'Enter your Address',
            controller: _addressController)
      ],
    );
  }

  Widget phoneTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Phone Number',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Enter your number',
          controller: _phoneController,
        )
      ],
    );
  }

  Widget emailTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Email address',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Enter your Email address',
          controller: _emailController,
        )
      ],
    );
  }

  Widget passworldTextfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: ' Enter Passworld',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          hint: 'Enter your Passworld ',
          controller: _passwordController,
        )
      ],
    );
  }

  Widget signUpButton() {
    return AppBlackButton(
        isLoading: isLoading,
        buttonText: 'Sign Up',
        onpressed: () {
          if (_nameController.text.isEmpty) {
            Utils().tostMessage("Please Enter Name");
          } else if (_collegeController.text.isEmpty) {
            Utils().tostMessage("Please Enter College Name");
          } else if (_addressController.text.isEmpty) {
            Utils().tostMessage("Please Enter Address");
          } else if (_phoneController.text.isEmpty) {
            Utils().tostMessage("Please Enter Mobile Number");
          } else if (_emailController.text.isEmpty) {
            Utils().tostMessage("Please Enter Email");
          } else if (!_isValidEmail(_emailController.text)) {
            Utils().tostMessage("Please Enter a Valid Email");
          } else if (_passwordController.text.isEmpty) {
            Utils().tostMessage("Please Enter Password");
          } else if (_passwordController.text.length < 6) {
            Utils().tostMessage("Password must be at least 6 characters");
          } else {
            _signUp();
          }
        });
  }

  Widget loginButton() {
    return AppWhiteButton(
        buttonText: 'Log In',
        //isLoading: isLoading,
        onpressed: () {
          Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ));
        });
  }

  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Utils().tostMessage('User already registered. Please log in.');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e is FirebaseAuthException && e.code == 'user-not-found') {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          User? user = userCredential.user;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'name': _nameController.text.trim(),
              'college': _collegeController.text.trim(),
              'address': _addressController.text.trim(),
              'phone': _phoneController.text.trim(),
              'email': _emailController.text.trim(),
            }).then((value) {
              Utils().tostMessage("User registered successfully");
              setState(() {
                isLoading = false;
              });
              Navigator.pushReplacement(context, CupertinoPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ));
              _nameController.clear();
              _collegeController..clear();
              _addressController..clear();
              _phoneController..clear();
              _emailController..clear();
            }).onError((error, stackTrace) {
              Utils().tostMessage("Failed to register: $error");
              setState(() {
                isLoading = false;
              });
            });
          }
        } catch (e) {
          print('Failed to register: $e');
          Utils().tostMessage('Failed to register: $e');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });

        // Handle other sign-in errors
        print('Failed to sign in: $e');
        Utils().tostMessage('Failed to sign in: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
