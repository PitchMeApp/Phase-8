import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/View/Profile/Likes/likes_list.dart';
import 'package:pitch_me_app/View/Profile/Pitches/pitches_list.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/logout.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';

import '../../utils/strings/strings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton:
          CustomAppbar(title: TextStrings.textKey['profile']!),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomListBox(
                icon: 'assets/images/ic_account_circle_24px@4x.png',
                title: TextStrings.textKey['biography']!,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/ic_favorite_24px@4x.png',
                title: TextStrings.textKey['likes']!,
                onPressad: () {
                  PageNavigateScreen().push(context, LikesListPage());
                }),
            CustomListBox(
                icon: 'assets/images/ic_toc_24px@4x.png',
                title: TextStrings.textKey['pitches']!,
                onPressad: () {
                  PageNavigateScreen().push(context, PitchesListPage());
                }),
            CustomListBox(
                icon: 'assets/images/Group 12260@4x.png',
                title: TextStrings.textKey['logout']!,
                onPressad: () {
                  showDialog(
                      context: context, builder: (context) => LogoutPopUp());
                }),
          ],
        ),
      ),
    );
  }
}
