// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/businessIdeas/dashBoardController.dart';
import 'package:pitch_me_app/screens/businessIdeas/Apicall.dart/noti.dart';
import 'package:pitch_me_app/screens/businessIdeas/blankScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/dashBoardScreen_Two.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/businessIdeas/postPageController.dart';
import '../../utils/extras/extras.dart';
import '../../utils/widgets/containers/containers.dart';

class mainHome_Two extends StatefulWidget {
  const mainHome_Two({super.key});

  @override
  State<mainHome_Two> createState() => _mainHome_TwoState();
}

var businesstype;

class _mainHome_TwoState extends State<mainHome_Two>
    with SingleTickerProviderStateMixin {
  PostPageController postPageController = Get.put(PostPageController());
  DashboardController dashboardController = Get.put(DashboardController());
  Businesslog() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      businesstype = preferencesData.getString("log_type");
      print("ABCDDATA  ${businesstype}");
    });
  }

  late AnimationController _animationController;
  late Animation _colorTween;

  bool _isInitialValue = false;
  bool fullScreen = false;

  String title = '';
  int currentIndexOfDashboard = 0;
  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
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
    currentScreen = DashBoardScreen_Two(
      currentPage: (int index) {
        currentIndexOfDashboard = index;
        if (!mounted) {
          return;
        }
        setState(() {});
      },
      onSwipe: (int index, String _title, bool isFinish) {
        print("index is $index and title is $title");
        title = _title;
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    );
    if (!mounted) {
      return;
    }
    setState(() {});
    Businesslog();
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        body: businesstype == "2" || businesstype == "1"
            ? comingSoon()
            : Stack(
                children: [
                  currentScreen,
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.getSize30(context: context) +
                            SizeConfig.getSize20(context: context),
                        bottom: SizeConfig.getSize20(context: context),
                        left: SizeConfig.getSize20(context: context),
                        right: SizeConfig.getSize20(context: context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currentIndexOfDashboard == 0
                            ? AnimatedBuilder(
                                animation: _colorTween,
                                builder: (context, child) {
                                  return AnimatedContainer(
                                    height: _isInitialValue
                                        ? sizeH * 0.5
                                        : sizeH * 0.06,
                                    width: _isInitialValue
                                        ? sizeW * 0.65
                                        : sizeW * 0.120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _isInitialValue ? 20 : 10),
                                        color: _colorTween.value
                                        //  _isInitialValue
                                        //     ? Color(0xff377eb4).withOpacity(0.8)
                                        //     : Color(0xff377eb4),
                                        ),
                                    duration: Duration(milliseconds: 300),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isInitialValue = !_isInitialValue;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: _isInitialValue
                                            ? Consumer<DataClass>(builder:
                                                (BuildContext context, value,
                                                    Widget? child) {
                                                return ListView.separated(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemCount: value.post?.result
                                                          ?.length ??
                                                      2,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return value.loading
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              print(
                                                                  "Click in notification");
                                                              setState(() {
                                                                _isInitialValue ==
                                                                        true
                                                                    ? Future.delayed(
                                                                        Duration(
                                                                            milliseconds:
                                                                                300),
                                                                        () {
                                                                        // Get.to(() =>
                                                                        //     noti_feedback());
                                                                      })
                                                                    : false;

                                                                _isInitialValue =
                                                                    false;
                                                              });
                                                            },
                                                            child: Container(
                                                              height:
                                                                  sizeH * 0.06,
                                                              width:
                                                                  sizeW * 0.65,
                                                              // color: Colors.red,
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .notifications_active_outlined,
                                                                          color:
                                                                              Color(0xff000a5e)),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left: sizeW *
                                                                                0.03,
                                                                            top:
                                                                                sizeH * 0.01),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              height: sizeH * 0.02,
                                                                              width: sizeW * 0.45,
                                                                              // color: Color
                                                                              //     .fromARGB(
                                                                              //         255,
                                                                              //         39,
                                                                              //         221,
                                                                              //         23),
                                                                              child: Text(
                                                                                value.post?.result?[index].title.toString() ?? "",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              value.post?.result?[index].text.toString() ?? "",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: sizeW * 0.02,
                                                          right: sizeW * 0.02),
                                                      child: Divider(
                                                        color:
                                                            Color(0xff000a5e),
                                                      ),
                                                    );
                                                  },
                                                );
                                              })
                                            : loadSvg(
                                                image:
                                                    'assets/image/notifications.svg'),
                                      ),
                                    ),
                                  );
                                })
                            : Container(),
                        currentIndexOfDashboard == 0
                            ? _isInitialValue == true
                                ? Container()
                                : Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xff377eb4),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: sizeH * 0.04,
                                    width: sizeW * 0.35,
                                    child: Center(
                                      child: Text(
                                        dashboardController.salespitch != null
                                            ? dashboardController.salespitch!
                                                    .result.docs.isNotEmpty
                                                ? dashboardController
                                                    .salespitch!
                                                    .result
                                                    .docs[postPageController
                                                        .swipableStackController
                                                        .currentIndex]
                                                    .title
                                                : 'No Title'
                                            : 'No Title',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                            : Container(),
                        Column(
                          children: [
                            currentIndexOfDashboard == 0
                                ? AppBarIconContainer(
                                    height:
                                        SizeConfig.getSize50(context: context),
                                    width:
                                        SizeConfig.getSize50(context: context),
                                    colorTween: _colorTween,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: loadSvg(
                                          image: 'assets/image/menu.svg'),
                                    ))
                                : Container(),
                            currentIndexOfDashboard == 0
                                ? spaceHeight(10)
                                : spaceHeight(0),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: currentIndexOfDashboard == 0
                                    ? AppBarIconContainer(
                                        height: SizeConfig.getSize50(
                                            context: context),
                                        width: SizeConfig.getSize50(
                                            context: context),
                                        colorTween: _colorTween,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: loadSvg(
                                            image: 'assets/image/setting.svg',
                                          ),
                                        ))
                                    : Container())
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
