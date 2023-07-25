import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar_with_white_bg.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Manu/manu.dart';
import 'package:pitch_me_app/View/Profile/Biography/biography.dart';
import 'package:pitch_me_app/View/Profile/Likes/likes_list.dart';
import 'package:pitch_me_app/View/Profile/Pitches/pitches_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/logout.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../utils/sizeConfig/sizeConfig.dart';
import '../../utils/strings/images.dart';
import '../../utils/strings/strings.dart';
import '../../utils/widgets/containers/containers.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int isSelect = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
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
                            .push(context, BiographyPage(type: 'Biography'));
                      }),
                  CustomListBox(
                      title: TextStrings.textKey['likes']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 2,
                      onPressad: () {
                        setState(() {
                          isSelect = 2;
                        });
                        PageNavigateScreen().push(context, LikesListPage());
                      }),
                  CustomListBox(
                      title: TextStrings.textKey['pitches']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 3,
                      onPressad: () {
                        setState(() {
                          isSelect = 3;
                        });
                        PageNavigateScreen().push(
                            context,
                            PitchesListPage(
                              notifyID: '',
                            ));
                      }),
                  CustomListBox(
                      title: TextStrings.textKey['logout']!,
                      singleSelectColor: isSelect,
                      isSingleSelect: 4,
                      onPressad: () {
                        setState(() {
                          isSelect = 4;
                        });
                        showDialog(
                            context: context,
                            builder: (context) => LogoutPopUp());
                      }),
                ],
              ),
            ),
            CustomAppbarWithWhiteBg(
              title: TextStrings.textKey['profile']!,
              onPressad: () {
                PageNavigateScreen().push(
                    context,
                    ManuPage(
                      title: TextStrings.textKey['profile']!,
                      pageIndex: 4,
                      isManu: 'Manu',
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
