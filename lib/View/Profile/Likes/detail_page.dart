import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:sizer/sizer.dart';
import 'package:video_viewer/video_viewer.dart';

class ShowFullVideoPage extends StatefulWidget {
  String url;
  ShowFullVideoPage({super.key, required this.url});

  @override
  State<ShowFullVideoPage> createState() => _ShowFullVideoPageState();
}

class _ShowFullVideoPageState extends State<ShowFullVideoPage>
    with SingleTickerProviderStateMixin {
  VideoViewerController videoViewerController = VideoViewerController();

  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorTween =
        ColorTween(begin: Color(0xff599CD0), end: Colors.white.withOpacity(0.3))
            .animate(_animationController);
    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width(context),
            height: height(context),
            color: Color.fromARGB(255, 254, 254, 254),
            child: VideoViewer(
              controller: videoViewerController,
              autoPlay: true,
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
                  thumbnail: Image.network(''),
                  loading: CircularProgressIndicator(
                    color: Colors.blue,
                  )),
              source: {
                "Source": VideoSource(
                  video: VideoPlayerController.network(widget.url),
                )
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sizeW * 0.025, top: sizeW * 0.12),
            child: AnimatedBuilder(
                animation: _colorTween,
                builder: (context, child) {
                  return InkWell(
                    onTap: () {
                      videoViewerController.pause();
                      // videoViewerController.dispose();

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 6.h,
                      width: 12.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _colorTween.value,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(108, 148, 147, 147)
                                  .withOpacity(0.3),
                              blurRadius: 100.0,
                              spreadRadius: 10,
                              offset: Offset(
                                10,
                                10,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: DynamicColor.white,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    videoViewerController.pause();
    super.dispose();
  }
}
