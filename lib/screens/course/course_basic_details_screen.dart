import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/cource_payment.dart';
import 'package:coursecraft_app/screens/course/course_details_screen.dart';
import 'package:coursecraft_app/screens/course/review_summary_screen.dart';
import 'package:coursecraft_app/screens/five_quetions.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/on%20boarding/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class CourseBasicDetailsScreen extends StatefulWidget {
  const CourseBasicDetailsScreen({super.key, this.url});
  final url;

  @override
  State<CourseBasicDetailsScreen> createState() =>
      _CourseBasicDetailsScreenState();
}

class _CourseBasicDetailsScreenState extends State<CourseBasicDetailsScreen> {
  int selectedIndex = -1;

  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isControlsVisible = true;
  bool _isFullScreen = false;
  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_controller.value.isPlaying;
      _isPlaying ? _controller.play() : _controller.pause();
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }
    @override
  void initState() {
    super.initState();
  
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {}); // Update the UI when video state changes
      });
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
                  _isFullScreen ?SizedBox():appBar(),
                _isFullScreen ?SizedBox():  sizeBoxHeight(25),
                  courseImage(),
                 _isFullScreen ?SizedBox(): sizeBoxHeight(32),
                 _isFullScreen ?SizedBox(): advanceExcel(),
                  _isFullScreen ?SizedBox():sizeBoxHeight(20),
                 _isFullScreen ?SizedBox(): mentor(),
                 _isFullScreen ?SizedBox(): sizeBoxHeight(20),
                 _isFullScreen ?SizedBox(): aboutThis(),
                 _isFullScreen ?SizedBox(): const Spacer(),
                 _isFullScreen ?SizedBox(): purchaseNow(),
                  _isFullScreen ?SizedBox():sizeBoxHeight(25),
                ],
              ),
            ),
          ),
        _isFullScreen ?SizedBox():  Expanded(child: homeFrameImage())
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
           onTap: (){
         Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailsScreen()), // Replace with your splash screen
      (Route<dynamic> route) => false, // Remove all previous routes
    );
          },child: Image.asset('${AppImages.courseImages}backarrow.png', height: 13.h)),
        AppText(
            text: 'Course Details',
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

 Widget courseImage() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return CourcePayment();
          },
        ));
      },
      child: GestureDetector(
        onTap: _toggleControls,
        child: Column(
          children: [
            Stack(
              children: [
                _controller.value.isInitialized
                    ? SizedBox(
                        height: _isFullScreen == true
                            ? MediaQuery.of(context).size.height-32
                            : 200,
                        width: _isFullScreen
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                if (_isControlsVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: Colors.red,
                              backgroundColor: Colors.grey,
                              bufferedColor: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                 _togglePlayPause();
                                },
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QuestionScreen2()));
                                  },
                                  child: Image.asset(
                                    "assets/home/conversation.png",
                                    height: 20,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                icon: Icon(
                                  _isFullScreen
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: Colors.white,
                                ),
                                onPressed: _toggleFullScreen,
                              ),
                              Text(
                                '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$minutes:$seconds';
  }
  Widget advanceExcel() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                text: 'Basix to Advance Excel',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w600,
                fontsize: 15.sp),
            Image.asset('${AppImages.courseImages}share.png', height: 30.h)
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: AppColor.yellowcolor, size: 14.sp),
            AppText(
                text: ' 4.9',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w700,
                fontsize: 13.sp),
            AppText(
                text: ' (37 Reviews)',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp),
            sizeBoxWidth(16),
            Image.asset('${AppImages.homeImages}time.png',
                height: 11.h, color: AppColor.greencolor),
            AppText(
                text: '  40 Hours 30 min',
                color: AppColor.greycolor,
                fontWeight: FontWeight.w400,
                fontsize: 11.sp),
          ],
        ),
      ],
    );
  }

  Widget mentor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
            text: 'Mentor',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.grey2color,
                      borderRadius: BorderRadius.circular(40.r)),
                ),
                sizeBoxWidth(11),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: 'Adsmain Joseph',
                        color: AppColor.blackcolor,
                        fontWeight: FontWeight.w600,
                        fontsize: 12.sp),
                    AppText(
                        text: 'Mentor :Excel Course',
                        color: AppColor.grey1color,
                        fontWeight: FontWeight.w400,
                        fontsize: 9.sp),
                  ],
                )
              ],
            ),
            AppText(
                text: '1k+ Enroll',
                color: AppColor.blackcolor,
                fontWeight: FontWeight.w600,
                fontsize: 14.sp),
          ],
        ),
      ],
    );
  }

  Widget aboutThis() {
    return Column(
      children: [
        AppText(
            text: 'About this course',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 13.sp),
        sizeBoxHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('${AppImages.courseImages}member.png',
                    height: 11.h),
                AppText(
                    text: '   420 Members',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
            Row(
              children: [
                Image.asset('${AppImages.homeImages}play.png', height: 11.h),
                AppText(
                    text: '   14 Courses',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
            Row(
              children: [
                Image.asset('${AppImages.courseImages}certificate.png',
                    height: 11.h),
                AppText(
                    text: '   Certificate',
                    color: AppColor.grey1color,
                    fontWeight: FontWeight.w500,
                    fontsize: 10.sp),
              ],
            ),
          ],
        ),
        sizeBoxHeight(20),
        AppText(
            text:
                'Lorem ipsum dolor sit amet consectetur. Nibh et pellent esque urna est egestas. Tincidunt gravida tincidunt imperdiet vestibulum. Accumsan facilisis sagittis felis et. Feugiat pulvinar pellentesque blandit',
            color: AppColor.grey1color,
            fontWeight: FontWeight.w400,
            fontsize: 11.sp),
      ],
    );
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
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return const ReviewSummaryScreen();
              },
            ));
          },
          child: Container(
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
          ),
        )
      ],
    );
  }
}
