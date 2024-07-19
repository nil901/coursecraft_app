import 'package:coursecraft_app/conts/utils.dart';
import 'package:coursecraft_app/core/app_button.dart';
import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;
   final _auth = FirebaseAuth.instance;
   void login() {
    setState(() {
      isLoading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
           Utils().tostMessage("Login Successful!"); 
            Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
           emailController.clear();
           passwordController.clear();
           setState(() {
        isLoading = true;
      });
      
      emailController.clear();
      passwordController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, StackTrace) {
      debugPrint(error.toString());
      Utils().tostMessage("Login Failed!");
     
      setState(() {
        isLoading = false;
      });
    });
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 25.h),
            child: Column(
              children: [
                getHelp(),
                sizeBoxHeight(28),
                helloBackText(),
                sizeBoxHeight(39),
                emailTextfiled(),
                sizeBoxHeight(20),
                passwordfiled(),
                sizeBoxHeight(10),
                forgotPasswordText(),
                sizeBoxHeight(40),
                signUpButton(),
                sizeBoxHeight(24),
                dontHave(),
              ],
            ),
          ),
          bottomNavigationBar: homeButton(),
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
          controller: emailController,
        )
      ],
    );
  }

  Widget passwordfiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Password',
            color: AppColor.greycolor,
            fontWeight: FontWeight.w400,
            fontsize: 12.sp),
        sizeBoxHeight(10),
        AppTextFormField(
          label: '',
          obscureText: _obscureText,
          hint: 'Enter your Password',
          controller: passwordController,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 5.w, top: 3),
            child: IconButton(
              icon: Icon(
                !_obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget forgotPasswordText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppText(
          text: 'Forgot Password ?',
          color: AppColor.greycolor,
          fontWeight: FontWeight.w400,
          fontsize: 10.sp,
        ),
      ],
    );
  }

  Widget dontHave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: 'Don\'t have an account ?',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w400,
          fontsize: 12.sp,
        ),
        AppText(
          text: ' Sign Up',
          color: AppColor.blackcolor,
          fontWeight: FontWeight.w600,
          fontsize: 12.sp,
        ),
      ],
    );
  }

  Widget homeButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Image.asset('${AppImages.authImages}home.png', height: 60.h),
      ),
    );
  }

  Widget signUpButton() {
    return AppBlackButton(
      isLoading: isLoading,
        buttonText: 'Log In',
        onpressed: () {
          if(emailController.text.isEmpty){
             Utils().tostMessage("Please Enter Email");
            
          }else if (!_isValidEmail(emailController.text)){
             Utils().tostMessage("Please Enter a Valid Email");
          }
          else if(passwordController.text.isEmpty){
             Utils().tostMessage("Please Enter Password");
          }else if(passwordController.text.length < 6){
              Utils().tostMessage("Password must be at least 6 characters");
          }else{
   login();
          }
       
        //  snackBar();
        });
  }

  snackBar() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.blackcolor,
            content: AppText(
              text: 'Please fill in all fields',
              color: AppColor.whitecolor,
              fontWeight: FontWeight.w600,
              fontsize: 11.sp,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColor.blackcolor,
            content: AppText(
              text: 'Login Successful',
              color: AppColor.whitecolor,
              fontWeight: FontWeight.w600,
              fontsize: 11.sp,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
