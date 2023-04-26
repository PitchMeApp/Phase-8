import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/controller/auth/loginController.dart';
import 'package:pitch_me_app/controller/selectionController.dart';
import 'package:pitch_me_app/core/extras.dart';
import 'package:pitch_me_app/screens/auth/loginScreen.dart';
import 'package:pitch_me_app/screens/businessIdeas/BottomNavigation.dart';
import 'package:pitch_me_app/screens/selectionScreen.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/strings/keys.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userType = '';
  @override
  void initState() {
    chackAuth();
    super.initState();
  }

  void chackAuth() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    userType = preferencesData.getString('log_type').toString();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (pref.hasData(Keys.TOKEN)) {
          if (userType.isEmpty || userType == '0') {
            Get.offAll(() => SelectionScreen(), binding: SelectionBinding());
          } else {
            Get.offAll(() => Floatbar(0));
          }
        } else {
          Get.offAll(() => LoginScreen(), binding: LoginBinding());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        bannerRequired: false,
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Center(child: appLogoImage()),
      ),
    );
  }
}
