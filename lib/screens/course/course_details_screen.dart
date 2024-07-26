import 'package:coursecraft_app/conts/utils.dart';
import 'package:coursecraft_app/core/app_color.dart';
import 'package:coursecraft_app/core/app_image.dart';
import 'package:coursecraft_app/core/app_sized_box.dart';
import 'package:coursecraft_app/core/app_text.dart';
import 'package:coursecraft_app/screens/cource_payment.dart';
import 'package:coursecraft_app/screens/course/course_basic_details_screen.dart';
import 'package:coursecraft_app/screens/five_quetions.dart';
import 'package:coursecraft_app/screens/home/home_screen.dart';
import 'package:coursecraft_app/screens/questions%20and%20answers/questions_answers_screen.dart';
import 'package:coursecraft_app/screens/questions%20and%20answers/questions_screen.dart';
import 'package:coursecraft_app/screens/utils/keystore.dart';
import 'package:coursecraft_app/screens/utils/prefs/PreferencesKey.dart';
import 'package:coursecraft_app/screens/utils/prefs/app_preference.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen(
      {super.key, this.access, this.url, this.folderPath});
  final String? folderPath;
  final String? url;
  final bool? access;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isControlsVisible = true;
  bool _isFullScreen = false;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('videos');
  List<Reference> _folders = [];
  List<Reference> _files = [];
  Map<String, String> _fileUrls = {}; // Store file URLs

  @override
  void initState() {
    super.initState();
    sher();
    _listItems();
    _controller = VideoPlayerController.network(widget.url.toString())
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {}); // Update the UI when video state changes
      });
  }

  void sher() async {
    await AppPreference().initialAppPreference();
    // Save folderPath to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('folderPath', widget.folderPath ?? '');
  }

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

  Future<void> _listItems() async {
    // If data is already loaded, skip fetching it again
    if (_fileUrls.isNotEmpty && _folders.isNotEmpty && _files.isNotEmpty) {
      return;
    }

    try {
      // Retrieve folderPath from SharedPreferences if widget.folderPath is null
      final prefs = await SharedPreferences.getInstance();
      final folderPath =
          widget.folderPath ?? prefs.getString('folderPath') ?? '';

      // Debugging information
      print('Listing items in: $folderPath');

      // Fetch list of files and folders from Firebase Storage
      final ListResult result = await _storage.ref(folderPath).listAll();

      // Debugging information
      print('All Folders:');
      result.prefixes.forEach((folder) {
        print(folder.fullPath);
      });

      print('Files:');
      result.items.forEach((file) {
        print(file.fullPath);
      });

      // Retrieve download URLs for files
      Map<String, String> tempFileUrls = {};
      for (Reference file in result.items) {
        try {
          final String url = await file.getDownloadURL();
          tempFileUrls[file.name] = url;
          print('File: ${file.name}, URL: $url');
        } catch (e) {
          print('Error getting download URL for file: ${file.name}, $e');
        }
      }

      // Update the state only once with the fetched data
      setState(() {
        _folders = result.prefixes
            .where((folder) => folder.name.toLowerCase() != 'pyment')
            .toList();
        _files = result.items;
        _fileUrls = tempFileUrls;
      });
    } catch (e) {
      // Handle the error and update the UI accordingly
      print('Error listing items: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading items. Please try again later.')),
      );
    }
  }

  // void handleVideoPlayback(int index, String? fileUrl) {
  //   // Handle video playback logic based on index and URL
  //   print('Handling playback for video at index $index with URL $fileUrl');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: _isFullScreen
                  ? EdgeInsets.zero
                  : EdgeInsets.only(right: 15.0, left: 15.0, top: 30.0),
              child: InkWell(
                onTap: () {
                  _listItems();
                },
                child: SingleChildScrollView(
                  child: _files.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appBar(),
                            _isFullScreen ? SizedBox() : SizedBox(height: 25),
                            courseImage(),
                            SizedBox(height: 25),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _files.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final file = _files[index];
                                final fileUrl = _fileUrls[file.name];
                                return InkWell(
                                  onTap: () {
                                    print(_files.length);
                                    handleVideoPlayback(index, fileUrl);
                                  },
                                  child: courseData(file.name, fileUrl, index),
                                );
                              },
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Final Exam",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            _isFullScreen ? SizedBox() : SizedBox(height: 25),
                            _isFullScreen
                                ? SizedBox()
                                : widget.access == true
                                    ? SizedBox()
                                    : purchaseNow(),
                            _isFullScreen ? SizedBox() : SizedBox(height: 25),
                          ],
                        ),
                ),
              ),
            ),
          ),
          _isFullScreen
              ? Container()
              : Expanded(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    child: homeFrameImage(),
                  ),
                ),
        ],
      ),
    );
  }

  void handleVideoPlayback(int index, fileurl) {
    print(AppPreference().getBool(PreferencesKey.index0));
    // print(AppPreference().getBool(PreferencesKey.index2));
    // print(AppPreference().getBool(PreferencesKey.index3));
    // print(AppPreference().getBool(PreferencesKey.index4));
    // print(AppPreference().getBool(PreferencesKey.index5));
    // print(AppPreference().getBool(PreferencesKey.index6));
    // print(AppPreference().getBool(PreferencesKey.index7));
    // print(AppPreference().getBool(PreferencesKey.index8));
    // print(AppPreference().getBool(PreferencesKey.index9));
    // print(AppPreference().getBool(PreferencesKey.index10));

  
    switch (index) {
      case 0:
        if (AppPreference().getBool(PreferencesKey.index0) == true) {
          // _controller = VideoPlayerController.network(fileurl)
          //   ..initialize().then((_) {
          //     setState(() {});
          //   })
          //   ..addListener(() {
          //     setState(() {});
          //     Navigator.pushReplacement(context, CupertinoPageRoute(
          //       builder: (context) {
          //         return CourseBasicDetailsScreen(
          //           url: fileurl!,
          //         );
          //       },
          //     ));
          //   });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 1");
          print("Complete first video");

          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Show message or handle completion of the first video
        }
        break;
      case 1:
        if (AppPreference().getBool(PreferencesKey.index0) == true) {
          print("Second video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage(
              "Complete the first video questions after play secound video ");
          print("Play video for index 1");
          // Implement your logic here for when index2 is false
        }
        break;
      case 2:
        if (AppPreference().getBool(PreferencesKey.index1) == true) {
          print("Third video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 2");
          print("Play video for index 2");
          // Implement your logic here for when index3 is false
        }
        break;
      case 3:
        if (AppPreference().getBool(PreferencesKey.index2) == true) {
          print("ther video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 2");
          print("Play video for index 3");
          // Implement your logic here for when index4 is false
        }
        break;
      case 4:
        if (AppPreference().getBool(PreferencesKey.index3) == true) {
          print("Fifth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 3");
          print("Play video for index 4");
          // Implement your logic here for when index5 is false
        }
        break;
      case 5:
        if (AppPreference().getBool(PreferencesKey.index4) == true) {
          print("Sixth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 4");
          print("Play video for index 5");
          // Implement your logic here for when index6 is false
        }
        break;
      case 6:
        if (AppPreference().getBool(PreferencesKey.index5) == true) {
          print("Seventh video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 5");
          print("Play video for index 6");
          // Implement your logic here for when index7 is false
        }
        break;
      case 7:
        if (AppPreference().getBool(PreferencesKey.index6) == true) {
          print("Eighth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 6");
          print("Play video for index 7");
          // Implement your logic here for when index8 is false
        }
        break;
      case 8:
        if (AppPreference().getBool(PreferencesKey.index7) == true) {
          print("Ninth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 7");
          print("Play video for index 8");
          // Implement your logic here for when index9 is false
        }
        break;
      case 9:
        if (AppPreference().getBool(PreferencesKey.index8) == true) {
          print("Tenth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 8");
          print("Play video for index 9");
          // Implement your logic here for when index10 is false
        }
        break;
      case 10:
        if (AppPreference().getBool(PreferencesKey.index9) == true) {
          print("Eleventh video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 9");
          print("Play video for index 10");
          // Implement your logic here for when index11 is false
        }
        break;
      case 11:
        if (AppPreference().getBool(PreferencesKey.index10) == true) {
          print("Twelfth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 10");
          print("Play video for index 11");
          // Implement your logic here for when index12 is false
        }
        break;
      case 12:
        if (AppPreference().getBool(PreferencesKey.index11) == true) {
          print("Thirteenth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 11");
          print("Play video for index 12");
          // Implement your logic here for when index13 is false
        }
        break;
      case 13:
        if (AppPreference().getBool(PreferencesKey.index12) == true) {
          print("Fourteenth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 12");
          print("Play video for index 13");
          // Implement your logic here for when index14 is false
        }
      case 14:
        if (AppPreference().getBool(PreferencesKey.index13) == true) {
          print("Fourteenth video play");
          _controller = VideoPlayerController.network(fileurl)
            ..initialize().then((_) {
              setState(() {});
            })
            ..addListener(() {
              setState(() {}); // Update the UI when video state changes
            });
          // Implement your video playback logic here
        } else {
          Utils().tostMessage("Complete the questions 13");
          print("Play video for index 13");
          // Implement your logic here for when index14 is false
        }
     
      default:
        print("Index does not match any specific case");
        // Handle indices not covered by the cases
        break;
    }
  }

  Widget appBar() {
    return _isFullScreen
        ? Container()
        : Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, CupertinoPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ));
                  },
                  child: Image.asset('${AppImages.courseImages}backarrow.png',
                      height: 13.h)),
              SizedBox(
                width: 100,
              ),
              Center(
                child: AppText(
                    text: 'Course Details',
                    color: AppColor.blackcolor,
                    fontWeight: FontWeight.w600,
                    fontsize: 13.sp),
              ),
            ],
          );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$minutes:$seconds';
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
                            ? MediaQuery.of(context).size.height
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
                                  if (widget.access == true) {
                                    _togglePlayPause();
                                  } else {
                                    Utils().tostMessage(
                                        "Purchase course and access playlist");
                                  }
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

  Widget courseData(name, fileurl, index) {
    return GestureDetector(
      // onTap: () {
      //   print(name);
      //   setState(() {
      //    // selectedIndex = index;
      //     // Navigator.pushReplacement(context, CupertinoPageRoute(
      //     //   builder: (context) {
      //     //     return  CourseBasicDetailsScreen(url: fileurl!,);
      //     //   },
      //     // ));
      //   });
      // },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    '${AppImages.courseImages}play.png',
                    height: 30.h,
                    color: AppColor.blackcolor,
                  ),
                  sizeBoxWidth(18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: name,
                          color: AppColor.blackcolor,
                          fontWeight: FontWeight.w600,
                          fontsize: 12.sp,
                        ),
                        AppText(
                          text: '2 Min 30 Sec',
                          color: AppColor.greycolor,
                          fontWeight: FontWeight.w400,
                          fontsize: 9.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              '${AppImages.courseImages}lock.png',
              height: 23.h,
              // color: selectedIndex == index ? AppColor.blackcolor : null,
            ),
            sizeBoxWidth(5),
            InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, CupertinoPageRoute(
                    builder: (context) {
                      return QuestionsAnswersScreen(
                        indexquetions: index,
                        onRefresh: _listItems,
                      );
                    },
                  ));
                },
                child: Icon(
                  Icons.question_answer,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }

  Widget purchaseNow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
            text: '\₹ 120.00',
            color: AppColor.blackcolor,
            fontWeight: FontWeight.w600,
            fontsize: 18.sp),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) {
                return CourcePayment();
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
