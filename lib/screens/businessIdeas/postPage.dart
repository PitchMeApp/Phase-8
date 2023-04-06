import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/controller/businessIdeas/postPageController.dart';
import 'package:pitch_me_app/screens/businessIdeas/feedbackscreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/interestedSwipe.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/extras/directVideoViewer.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

class PostPageWidget extends StatefulWidget {
  const PostPageWidget({
    Key? key,
    required this.controller,
    required this.onSwipe,
    required this.postModel,
  }) : super(key: key);
  final PageController controller;
  final Function(int index, String title, bool isFinish) onSwipe;
  final SalesPitchListModel postModel;

  @override
  State<PostPageWidget> createState() => _PostPageWidgetState();
}

class _PostPageWidgetState extends State<PostPageWidget>
    with AutomaticKeepAliveClientMixin<PostPageWidget>, WidgetsBindingObserver {
  void _listenController() => setState(() {});
  PostPageController controller = Get.put(PostPageController());
  var directionn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controller.swipableStackController.addListener(_listenController);
    videoViewerControllerList.clear();

    videoViewerControllerList.addAll(List.generate(
        widget.postModel.result.docs.length,
        (index) => VideoViewerController()));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: SwipableStack(
            swipeAssistDuration: Duration.zero,
            swipeAnchor: SwipeAnchor.bottom,
            dragStartDuration: Duration.zero,
            stackClipBehaviour: Clip.hardEdge,
            // overlayBuilder: (context, properties) {
            //   final opacity = min(properties.swipeProgress, 1.0);
            //   final isRight = properties.direction == SwipeDirection.right;
            //   return Container(
            //     height: 240,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Color.fromARGB(255, 253, 253, 253),
            //     ),
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset(
            //             "assets/image/Group 12261.png",
            //             height: sizeH * 0.13,
            //           ),
            //           Image.asset(
            //             "assets/image/Group 12262.png",
            //             height: sizeH * 0.13,
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // },
            // onWillMoveNext: (index, direction) {
            //   final allowedActions = [
            //     SwipeDirection.right,
            //     SwipeDirection.left,
            //   ];
            //   return allowedActions.contains(direction == null
            //       ? ''
            //       : controller.direction == SwipeDirection.left
            //           ? Container(
            //               color: Colors.red,
            //               height: 10,
            //               width: 10,
            //             )
            //           : Text("data"));
            // },
            detectableSwipeDirections: const {
              SwipeDirection.right,
              SwipeDirection.left,
            },
            allowVerticalSwipe: false,
            controller: controller.swipableStackController,
            // stackClipBehaviour: Clip.hardEdge,
            onSwipeCompleted: (index, direction) {
              print("left123direction $index");
              if (direction == SwipeDirection.left) {
                controller.left = !controller.left;
              }
              if (direction == SwipeDirection.right) {
                controller.right = !controller.right;
              }
              if (!mounted) {
                return;
              }
              setState(() {
                directionn = direction;
                controller.updateProgressOfCard(0.0);
                controller.updateDirectionOfCard(null);
              });
              print('index is $index, direction is $direction');
              controller.label =
                  direction == SwipeDirection.right ? 'Saved' : 'Seen';
              controller.setVisibleSeen(true);
              Future.delayed(Duration(milliseconds: 200)).then((value) {
                controller.setVisibleSeen(false);
              });
              //SEND INDEX AND TITLE
              log('length = ' + widget.postModel.result.docs.length.toString());
              log('index = ' + index.toString());
              if (index != widget.postModel.result.docs.length) {
                log('index1 = ' + index.toString());
                widget.onSwipe(
                    index + 1,
                    widget.postModel.result.docs[index + 1].title.toString(),
                    false);
              } else {
                log('index2 = ' + index.toString());
                widget.onSwipe(index, "", true);
              }

              if (directionn == SwipeDirection.left &&
                  controller.left == true) {
                controller.swipableStackController.rewind();
              }
              if (directionn == SwipeDirection.right &&
                  controller.right == true) {
                controller.swipableStackController.rewind();
              }

              if (widget.postModel.result.docs[index].status == 2 &&
                  videoViewerControllerList[index].isPlaying) {
                videoViewerControllerList[index].pause();
                if (!mounted) {
                  return;
                }
                setState(() {});
              }
              controller.refreshed.value = false;
            },
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 0.8,

            itemCount: widget.postModel.result.docs.length,
            builder: (context, properties) {
              final itemIndex =
                  properties.index % widget.postModel.result.docs.length;

              if (mounted) {
                controller.updateProgressOfCard(properties.swipeProgress);
                controller.updateDirectionOfCard(properties.direction);
              }
              print(
                  "urll2 ${widget.postModel.result.docs[properties.index].vid1}");

              return Stack(
                children: [
                  directionn == SwipeDirection.left
                      ? controller.left == false
                          ? controller.getSliderWidget2(
                              post: widget.postModel.result.docs[itemIndex],
                              context: context,
                              itemIndex: itemIndex)
                          : ratingScreen()
                      : controller.right == true
                          ? interestedSwipe()
                          : controller.getSliderWidget2(
                              post: widget.postModel.result.docs[itemIndex],
                              context: context,
                              itemIndex: itemIndex)
                ],
              );
            },
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: controller.progressOfCard.value.toStringAsFixed(2) == "0.00"
                /* &&
                      controller.direction == null */
                ? SizedBox()
                : AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: controller.progressOfCard.value * 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      height: 1,
                    ),
                    child: Text(
                      controller.direction == null
                          ? ''
                          : controller.direction == SwipeDirection.left
                              ? 'Not interested'
                              : 'interested',
                    ),
                  )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.getSize10(context: context), right: 8),
            child: GestureDetector(
              onTap: () {
                widget.controller.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: Container(
                height: SizeConfig.getSize35(context: context),
                width: SizeConfig.getSize35(context: context),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(70, 51, 50, 50).withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(
                          0,
                          0,
                        ))
                  ],
                ),
                child: Image.asset(
                  "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: SizeConfig.getSize10(context: context)),
            child: GestureDetector(
              onTap: () {
                controller.swipableStackController.next(
                  duration: Duration(milliseconds: 10),
                  swipeDirection: SwipeDirection.left,
                );
              },
              child: Container(
                  height: SizeConfig.getSize35(context: context),
                  width: SizeConfig.getSize35(context: context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromARGB(71, 60, 60, 60).withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(
                            0,
                            0,
                          ))
                    ],
                  ),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                        "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png"),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      controller.appIsInBackground.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint(
          "App is resumed and visibility is ${controller.videoVisibilityPercent.value}");
      controller.appIsInBackground.value = false;
      setState(() {});
    }
  }
}
