import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Select%20industry/select_industry.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../Phase 6/Guest UI/Guest limitation pages/user_type_limitation.dart';
import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/widgets/containers/containers.dart';

class DemoVideoPage extends StatefulWidget {
  const DemoVideoPage({super.key});

  @override
  State<DemoVideoPage> createState() => _DemoVideoPageState();
}

class _DemoVideoPageState extends State<DemoVideoPage> {
  final NavigationController _navigationController =
      Get.put(NavigationController());
  //late VideoPlayerController _videoPlayerController;
  VideoViewerController videoViewerController = VideoViewerController();
  bool isLoading = false;
  bool isCheck = false;

  String checkGuestType = '';
  String businesstype = '';

  // Future _initVideoPlayer() async {
  //   _videoPlayerController = VideoPlayerController.network(
  //       'https://ciu.ody.mybluehostin.me/ringbell/watchsales.mp4'
  //       //'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4'
  //       );
  //   await _videoPlayerController.initialize();
  //   await _videoPlayerController.setLooping(true);
  //   //await _videoPlayerController.play();
  // }

  // repalyVideo() async {
  //   await _videoPlayerController.play();
  // }

  @override
  void initState() {
    setState(() {
      // isLoading = true;
    });
    checkGuest();
    //  _initVideoPlayer();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
      businesstype = preferencesData.getString('log_type').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: isCheck == true
          ? UserTypeLimitationPage(
              title1: 'Only Business Idea and',
              title2: 'Business Owners users',
              title3: 'can access this page.',
            )
          : Stack(
              children: [
                Container(
                  width: width(context),
                  height: height(context),
                  color: Color.fromARGB(255, 254, 254, 254),
                  child: VideoViewer(
                    controller: videoViewerController,
                    autoPlay: false,
                    enableHorizontalSwapingGesture: false,
                    enableVerticalSwapingGesture: false,
                    volumeManager: VideoViewerVolumeManager.device,
                    onFullscreenFixLandscape: false,
                    forwardAmount: 5,
                    defaultAspectRatio: 9 / 16,
                    rewindAmount: -5,
                    looping: true,
                    enableShowReplayIconAtVideoEnd: false,
                    style: VideoViewerStyle(
                        playAndPauseStyle: PlayAndPauseWidgetStyle(
                          background: Colors.transparent,
                          circleRadius: 80.0,
                          play: Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 80,
                              color: DynamicColor.white,
                            ),
                          ),
                          pause: Center(
                            child: Icon(
                              Icons.pause,
                              size: 80,
                              color: DynamicColor.white,
                            ),
                          ),
                        ),
                        thumbnail: Image.network(''),
                        loading: CircularProgressIndicator(
                          color: DynamicColor.gredient1,
                        )),
                    source: {
                      "Source": VideoSource(
                        video: VideoPlayerController.network(
                            'https://ciu.ody.mybluehostin.me/ringbell/addwatchsales.mp4'),
                      )
                    },
                  ),
                ),
                CustomAppbar(
                  title: 'Add Sales Pitch',
                  onPressad: () {
                    videoViewerController.pause();
                    if (checkGuestType.isNotEmpty && checkGuestType != 'null') {
                      PageNavigateScreen()
                          .push(
                              context,
                              ManuPage(
                                title: 'Add Sales Pitch',
                                pageIndex: 2,
                                isManu: 'Manu',
                              ))
                          .then((value) {
                        setState(() {
                          videoViewerController.play();
                        });
                      });
                    } else {
                      Get.to(() => GuestManuPage(
                            title: 'Add Sales Pitch',
                            pageIndex: 2,
                          ));
                    }
                  },
                  onPressadForNotify: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.getSize30(context: context) +
                          SizeConfig.getSize55(context: context) +
                          SizeConfig.getSize5(context: context),
                      right: SizeConfig.getFontSize25(context: context)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AppBarIconContainer(
                      height: SizeConfig.getSize38(context: context),
                      width: SizeConfig.getSize38(context: context),
                      color: DynamicColor.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Image.asset(
                            "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                            height: 30,
                            width: 30,
                            color: DynamicColor.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (checkGuestType.isNotEmpty &&
                            checkGuestType != 'null') {
                          if (businesstype == '3' || businesstype == '4') {
                            setState(() {
                              isCheck = true;
                            });
                          } else {
                            videoViewerController.pause();
                            _navigationController.navigationType.value = 'Post';
                            Get.to(() => SelectIndustryPage());
                          }
                        } else {
                          Get.to(() => LoginLimitationPage());
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    //  log('video');
    videoViewerController.pause();
    videoViewerController.dispose();

    super.dispose();
  }
}
