import 'package:flutter/material.dart';
import 'package:pitch_me_app/screens/businessIdeas/home%20biography/chat.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/banner.dart';

class ConfirmationChat extends StatefulWidget {
  ConfirmationChat({
    super.key,
  });

  @override
  State<ConfirmationChat> createState() => _ConfirmationChatState();
}

class _ConfirmationChatState extends State<ConfirmationChat> {
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BannerWidget(
          onPressad: () {},
        ),
        body: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/17580.png',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02, top: 50),
                      child: Center(
                        child: Image.asset(
                          "assets/image/Group 12262.png",
                          height: sizeH * 0.08,
                        ),
                      ),
                    )),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.02, right: sizeW * 0.02),
                      child: Image.asset(
                        "assets/image/Group 12261.png",
                        height: sizeH * 0.20,
                      ),
                    )),
                  ],
                ),
                // SizedBox(
                //   height: sizeH * 0.15,
                // ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'start communication with',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'this Person?',
                        style: TextStyle(
                          fontSize: sizeH * 0.025,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.6,
                          color: Color(0xff377EB4),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: sizeH * 0.30,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icons.arrow_back_ios),
                BackArrow(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      PageNavigateScreen().push(context, ChatPage());
                    },
                    icon: Icons.arrow_forward_ios),
              ],
            ),
          ],
        ));
  }
}
