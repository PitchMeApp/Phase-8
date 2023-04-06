import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/appbar.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:sizer/sizer.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicColor.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: CustomAppbar(title: TextStrings.textKey['deals']!),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomAppbar(title: TextStrings.textKey['deals']!),
            CustomListBox(
                icon: 'assets/images/ic_message_24px@4x.png',
                title: TextStrings.textKey['chat']!,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/ic_import_contacts_24px@4x.png',
                title: TextStrings.textKey['contract']!,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/ic_local_atm_24-mdpi (1).png',
                title: TextStrings.textKey['investment']!,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/pie-chart.png',
                title: TextStrings.textKey['share']!,
                imageHight: 40.0,
                onPressad: () {}),
            CustomListBox(
                icon: 'assets/images/ic_compare_arrows_24px@4x.png',
                title: TextStrings.textKey['update']!,
                onPressad: () {}),
          ],
        ),
      ),
    );
  }
}

class CustomListBox extends StatefulWidget {
  String icon;
  String title;
  VoidCallback onPressad;
  dynamic imageHight;
  CustomListBox({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressad,
    this.imageHight,
  });

  @override
  State<CustomListBox> createState() => _CustomListBoxState();
}

class _CustomListBoxState extends State<CustomListBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressad,
      child: Container(
        height: 6.h,
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.only(bottom: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: DynamicColor.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                widget.icon,
                height: (widget.imageHight == null) ? 25 : widget.imageHight,
              ),
            ),
            Text(
              widget.title.toUpperCase(),
              style: white17wBold,
            ),
            Container(
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
