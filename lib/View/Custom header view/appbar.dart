import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatefulWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar>
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
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.getSize15(context: context),
          left: SizeConfig.getSize20(context: context),
          right: SizeConfig.getSize20(context: context)),
      child: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, child) {
            return Row(
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
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: loadSvg(image: 'assets/image/notifications.svg'),
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.blue,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    widget.title,
                    style: white15TextStyle,
                  ),
                ),
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
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: loadSvg(image: 'assets/image/menu.svg'),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
