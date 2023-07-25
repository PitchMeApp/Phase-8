import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Demo%20Video/demo_video.dart';
import 'package:pitch_me_app/View/Profile/profile.dart';
import 'package:pitch_me_app/controller/businessIdeas/homepagecontroller.dart';
import 'package:pitch_me_app/screens/businessIdeas/VideoScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/mainHome.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Floatbar extends StatefulWidget {
  // const Floatbar({super.key, var index = 3});
  var selectData;
  Floatbar(this.selectData);

  @override
  State<Floatbar> createState() => _FloatbarState();
}

String businesstype = '';

class _FloatbarState extends State<Floatbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  // Color _contairColor = Color.fromARGB(255, 225, 225, 225).withOpacity(0.3);
  // Color _CoColor = Color(0xff37B47E);
  // Color _xyz = Color(0xff375454);
  int selectIndex = 0;

  bool isSelectedScreen = true;

  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    changeColors();
    getUserType();
    if (widget.selectData != null) {
      controller.PageIndexData.value = widget.selectData;
    }
    super.initState();
    //getBoolValuesSF();
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
  }

  Future changeColors() async {
    await Future.delayed(const Duration(seconds: 0), () {
      _animationController.reset();
    });
  }

  List iconlist = [
    "assets/Phase 2 icons/ic_home_24px (1).png",
    "assets/Phase 2 icons/ic_play_circle_notfilled_24px.png",
    "assets/Phase 2 icons/ic_add_24px.png",
    "assets/Phase 2 icons/equalizer_light.png",
    "assets/Phase 2 icons/ic_person_24px.png",
  ];

  List filleIcons = [
    "assets/Phase 2 icons/ic_home_24px.png",
    "assets/Phase 2 icons/ic_play_circle_filled_24px.png",
    "assets/Phase 2 icons/ic_add_24px (1).png",
    "assets/Phase 2 icons/equalizer_dark.png",
    "assets/Phase 2 icons/ic_person_24px (1).png",
  ];
  List<Widget> pages = [
    MainHomeScreen(),
    mainHome_Two(),
    DemoVideoPage(),
    DealsPage(),
    ProfilePage(),
  ];

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      businesstype = prefs.getString('log_type').toString();
    });
  }

  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        body: pages.isEmpty
            ? Container()
            : Obx(() => pages[controller.PageIndexData.value]),
        bottomNavigationBar: Container(
          // height: 70,

          decoration: BoxDecoration(gradient: DynamicColor.gradientColorChange),
          child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              iconSize: 0.0,
              selectedFontSize: 0.0,
              unselectedFontSize: 0.0,
              currentIndex: controller.PageIndexData.value,
              onTap: (index) {
                setState(() {
                  pageindex = index;
                  isSelectedScreen = false;
                  controller.PageIndexData.value = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconlist[0],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  activeIcon: Image.asset(
                    filleIcons[0],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconlist[1],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  activeIcon: Image.asset(
                    filleIcons[1],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconlist[2],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  activeIcon: Image.asset(
                    filleIcons[2],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconlist[3],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  activeIcon: Image.asset(
                    filleIcons[3],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconlist[4],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  activeIcon: Image.asset(
                    filleIcons[4],
                    height: sizeH * 0.04,
                    width: sizeW * 0.07,
                  ),
                  label: '',
                ),
              ]),
        ));
  }

  @override
  void dispose() {
    _animationController.clearListeners();
    super.dispose();
  }
}
