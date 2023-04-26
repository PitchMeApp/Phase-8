import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: DynamicColor.blue,
          ),
        ),
      ),
    );
  }
}
