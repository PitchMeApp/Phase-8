import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

class CustomHeaderView extends StatefulWidget {
  String title;
  String subTitle;
  var subTitle2;
  String icon;
  double progressPersent;
  double padding;
  CustomHeaderView({
    super.key,
    required this.title,
    required this.icon,
    required this.subTitle,
    this.subTitle2,
    required this.progressPersent,
    required this.padding,
  });

  @override
  State<CustomHeaderView> createState() => _CustomHeaderViewState();
}

class _CustomHeaderViewState extends State<CustomHeaderView>
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
    return Container(
      child: Column(
        children: [
          iconsAndTitle(),
          iconAndProgressBar(),
        ],
      ),
    );
  }

  Widget iconsAndTitle() {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.getSize15(context: context),
                left: SizeConfig.getSize20(context: context),
                right: SizeConfig.getSize20(context: context)),
            child: Row(
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
                        child: loadSvg(image: 'assets/image/notifications.svg'),
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: DynamicColor.blue,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    TextStrings.textKey['add_seles_pitch']!,
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
                )
              ],
            ),
          );
        });
  }

  Widget iconAndProgressBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        //alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: widget.progressPersent == 0.0
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.progressPersent == 0.0
                  ? Container(
                      height: 6.h,
                      width: 12.w,
                    )
                  : AnimatedBuilder(
                      animation: _colorTween,
                      builder: (context, child) {
                        return InkWell(
                          onTap: () {
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.progressPersent == 0.0
                      ? Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width - 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: DynamicColor.lightGrey),
                        )
                      : LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 150,
                          lineHeight: 5.0,
                          percent: widget.progressPersent,
                          backgroundColor: DynamicColor.lightGrey,
                          progressColor: DynamicColor.blue,
                          barRadius: const Radius.circular(10),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 170,
                      child: Text(
                        widget.title,
                        style: blue19,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  widget.icon.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            widget.icon,
                            height: 30,
                          ),
                        )
                      : Container(
                          height: 30,
                        ),
                ],
              ),
              SizedBox(
                height: 6.h,
                width: 12.w,
              )
            ],
          ),
          subText(),
          widget.subTitle2 != null ? subText2() : Container()
        ],
      ),
    );
  }

  Widget subText() {
    return Container(
      alignment:
          widget.subTitle2 != null ? Alignment.topLeft : Alignment.center,
      width: MediaQuery.of(context).size.width - 80,
      margin: EdgeInsets.only(top: 8),
      child: Text(
        widget.subTitle,
        style: blue12,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget subText2() {
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width - 80,
      //margin: EdgeInsets.only(top: 0),
      child: Text(
        widget.subTitle2,
        style: blue12,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
