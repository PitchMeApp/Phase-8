import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/noti.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  VoidCallback onPressad;
  VoidCallback onPressadForNotify;
  dynamic isManuColor;
  CustomAppbar({
    super.key,
    required this.title,
    required this.onPressad,
    required this.onPressadForNotify,
    this.isManuColor,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  Timer timer = Timer(Duration(seconds: 0), () {});
  @override
  void initState() {
    //Colors.white.withOpacity(0.3)
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _colorTween = ColorTween(begin: DynamicColor.blue, end: DynamicColor.blue)
        .animate(_animationController);
    Future.delayed(const Duration(seconds: 0), () {
      _animationController.status == AnimationStatus.completed
          ? _animationController.reset()
          : _animationController.forward();
    });
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      final postModel = Provider.of<DataClass>(context, listen: false);
      postModel.getPostData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.getSize30(context: context) +
                MediaQuery.of(context).size.height * 0.021,
            left: SizeConfig.getFontSize25(context: context),
            right: SizeConfig.getFontSize25(context: context)),
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: _colorTween,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarIconContainer(
                        onTap: widget.onPressadForNotify,
                        height: SizeConfig.getSize50(context: context),
                        width: SizeConfig.getSize50(context: context),
                        colorTween: _colorTween,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: loadSvg(
                            image: 'assets/image/notifications.svg',
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.35,
                        alignment: Alignment.center,
                        // decoration: widget.title != 'Profile'
                        //     ? BoxDecoration(
                        //         color: DynamicColor.blue,
                        //         borderRadius: BorderRadius.circular(8.0))
                        //     : null,
                        child: Text(
                          widget.title,
                          style: blue16bold,
                        ),
                      ),
                      AppBarIconContainer(
                        onTap: widget.onPressad,
                        height: SizeConfig.getSize50(context: context),
                        width: SizeConfig.getSize50(context: context),
                        colorTween: _colorTween,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: loadSvg(
                              image: 'assets/image/menu.svg',
                              color: widget.isManuColor == null
                                  ? null
                                  : DynamicColor.darkBlue),
                        ),
                      )
                    ],
                  );
                }),
            Consumer<DataClass>(
                builder: (BuildContext context, value, Widget? child) {
              return Visibility(
                visible: value.totalNotiCount == 0 ? false : true,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(left: 25, bottom: 20),
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: FittedBox(
                    child: Text(
                      value.totalNotiCount.toString(),
                      style: TextStyle(color: DynamicColor.white),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
