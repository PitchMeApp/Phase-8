import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/selected_data_view/selected_page.dart';
import 'package:pitch_me_app/View/video%20page/Controller/controller.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/images.dart';
import '../../utils/styles/styles.dart';
import '../../utils/widgets/extras/backgroundWidget.dart';
import '../Custom header view/custom_header_view.dart';
import '../Custom header view/new_bottom_bar.dart';
import 'camera_page.dart';

class VideoPageMain extends StatefulWidget {
  const VideoPageMain({super.key});

  @override
  State<VideoPageMain> createState() => _VideoPageMainState();
}

class _VideoPageMainState extends State<VideoPageMain> {
  final VideoFirstPageController _videoFirstPageController =
      Get.put(VideoFirstPageController());
  final _controller = PageController();

  int selectIndex = 2;
  int nextPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DynamicColor.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  nextPage = value;
                });
              },
              children: [
                BackGroundWidget(
                  backgroundImage: Assets.backgroundImage,
                  fit: BoxFit.fill,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: SizeConfig.getSize100(context: context) +
                                SizeConfig.getSize55(context: context),
                          ),

                          //const SizedBox(height: 120),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextFormField(
                                  controller: _videoFirstPageController
                                      .editingController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: DynamicColor.gredient1,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                  maxLength: 15,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: "Enter Title",
                                      hintStyle: TextStyle(
                                          fontSize: 25,
                                          color: DynamicColor.lightGrey,
                                          fontWeight: FontWeight.w700)),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              //const SizedBox(height: 20),
                              InkWell(
                                  onTap: () {
                                    if (_videoFirstPageController
                                        .editingController.text.isNotEmpty) {
                                      Get.to(() => const CameraPage(),
                                          arguments: _videoFirstPageController
                                              .editingController.text
                                              .toString());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter title',
                                          gravity: ToastGravity.CENTER);
                                    }
                                  },
                                  child: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: const [
                                          DynamicColor.gredient1,
                                          DynamicColor.gredient2
                                        ],
                                      ).createShader(bounds);
                                    },
                                    child: Icon(
                                      Icons.videocam,
                                      color: Colors.white,
                                      size: 80.0,
                                    ),
                                  )),
                            ],
                          ),

                          const SizedBox(height: 80),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Text('Pitch details', style: gredient116bold),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: SizeConfig.getSize60(
                                            context: context) +
                                        SizeConfig.getSize15(context: context),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.nextPage(
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.linear);
                                    },
                                    child: RotatedBox(
                                        quarterTurns: 4,
                                        child: Image.asset(
                                          "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                          height: SizeConfig.getSize35(
                                              context: context),
                                          width: SizeConfig.getSize35(
                                              context: context),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomHeaderView(
                        progressPersent: 0.8,
                        nextOnTap: () {},
                      ),
                    ],
                  ),
                ),
                SelectedPage(
                  showIcon: nextPage,
                  pageController: _controller,
                )
              ],
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ));
  }
}
