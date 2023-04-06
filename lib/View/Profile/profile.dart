import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/View/Deals%20Page/deals_page.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

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
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/ic_toc_24px@4x.png',
                title: TextStrings.textKey['pitches']!,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/Group 12260@4x.png',
                title: TextStrings.textKey['logout']!,
                onPressad: () {}),
          ],
        ),
      ),
    );
  }
}
