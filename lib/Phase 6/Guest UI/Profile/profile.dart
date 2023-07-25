import 'package:flutter/material.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Guest%20limitation%20pages/login_limitation.dart';
import 'package:pitch_me_app/Phase%206/Guest%20UI/Profile/manu.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../../View/Custom header view/appbar_with_white_bg.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';

class GuestProfilePage extends StatefulWidget {
  const GuestProfilePage({super.key});

  @override
  State<GuestProfilePage> createState() => _GuestProfilePageState();
}

class _GuestProfilePageState extends State<GuestProfilePage> {
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.cover,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: DynamicColor.gradientColorChange),
                    height: MediaQuery.of(context).size.height * 0.235,
                  ),
                ),
                whiteBorderContainer(
                    child: Image.asset(Assets.handshakeImage),
                    color: Colors.transparent,
                    height:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    width:
                        SizeConfig.getSizeHeightBy(context: context, by: 0.12),
                    cornerRadius: 25),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomListBox(
                      title: TextStrings.textKey['biography']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 1,
                      onPressad: () {
                        setState(() {
                          isSelect = 1;
                        });
                        PageNavigateScreen()
                            .push(context, LoginLimitationPage());
                      }),
                  CustomListBox(
                      title: TextStrings.textKey['likes']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 2,
                      onPressad: () {
                        setState(() {
                          isSelect = 2;
                        });
                        PageNavigateScreen()
                            .push(context, LoginLimitationPage());
                      }),
                  CustomListBox(
                      title: TextStrings.textKey['pitches']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 3,
                      onPressad: () {
                        setState(() {
                          isSelect = 3;
                        });
                        PageNavigateScreen()
                            .push(context, LoginLimitationPage());
                      }),
                ],
              ),
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['profile']!,
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    GuestManuPage(
                      title: TextStrings.textKey['profile']!,
                      pageIndex: 3,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
