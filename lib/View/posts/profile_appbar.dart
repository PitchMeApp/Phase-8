import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/styles.dart';

class ProfilePostHeader extends StatefulWidget {
  String title;
  ProfilePostHeader({Key? key, required this.title}) : super(key: key);

  @override
  State<ProfilePostHeader> createState() => _ProfilePostHeaderState();
}

class _ProfilePostHeaderState extends State<ProfilePostHeader>
    with SingleTickerProviderStateMixin {
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
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
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
                                blurRadius: 50.0,
                                spreadRadius: 10,
                                offset: Offset(
                                  20,
                                  20,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:
                              loadSvg(image: 'assets/image/notifications.svg'),
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.35,
                    alignment: Alignment.center,
                    decoration: widget.title == 'Posts'
                        ? BoxDecoration(
                            color: DynamicColor.blue,
                            borderRadius: BorderRadius.circular(10.0))
                        : null,
                    child: Text(
                      widget.title,
                      style: widget.title != 'Posts'
                          ? blue16bold
                          : white15TextStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
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
                                blurRadius: 45.0,
                                spreadRadius: 10,
                                offset: Offset(
                                  20,
                                  20,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: loadSvg(image: 'assets/image/menu.svg'),
                        ),
                        // const Icon(
                        //   Icons.menu,
                        //   color: DynamicColor.white,
                        //   size: 30,
                        // ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
