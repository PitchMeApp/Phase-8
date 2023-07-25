import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Location%20Page/location_page.dart';
import 'package:pitch_me_app/View/Select%20industry/industry_controller.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/strings/images.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:pitch_me_app/utils/widgets/extras/backgroundWidget.dart';

import '../../utils/colors/colors.dart';
import '../../utils/strings/strings.dart';
import '../../utils/styles/styles.dart';
import '../Custom header view/custom_header_view.dart';

class SelectIndustryPage extends StatefulWidget {
  const SelectIndustryPage({super.key});

  @override
  State<SelectIndustryPage> createState() => _SelectIndustryPageState();
}

class _SelectIndustryPageState extends State<SelectIndustryPage> {
  final scrollController = FixedExtentScrollController(initialItem: 5);

  final InsdustryController insdustryController =
      Get.put(InsdustryController());
  final NavigationController _navigationController =
      Get.put(NavigationController());

  GlobalKey<FormState> _abcKey = GlobalKey<FormState>();

  int chengeIndexColor = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.getSize100(context: context) +
                      SizeConfig.getSize55(context: context),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: DynamicColor.black))),
                  child: Text(
                    TextStrings.textKey['industry']!,
                    style: textColor22,
                  ),
                ),
                Expanded(child: Obx(() {
                  return insdustryController.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                              color: DynamicColor.gredient1),
                        )
                      : insdustryController.industryList.result.docs.isEmpty
                          ? Center(
                              child: Text('No Industry Available'),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 80),
                              child: ClickableListWheelScrollView(
                                scrollController: scrollController,
                                itemHeight: 10,
                                loop: true,
                                itemCount: insdustryController
                                    .industryList.result.docs.length,
                                onItemTapCallback: (index) {
                                  setState(() {});
                                  // log("onItemTapCallback index: $index");
                                  // PageNavigateScreen().push(context, const LocationPage());
                                },
                                child: ListWheelScrollView.useDelegate(
                                  controller: scrollController,
                                  diameterRatio: 1.5,
                                  itemExtent: 30,
                                  physics: const FixedExtentScrollPhysics(),
                                  overAndUnderCenterOpacity: 0.8,
                                  perspective: 0.004,
                                  offAxisFraction: 0,
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      chengeIndexColor = index;
                                      insdustryController
                                              .selectedIndustry.value =
                                          insdustryController.industryList
                                              .result.docs[index].name;
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: insdustryController
                                        .industryList.result.docs.length,
                                    builder: (context, index) {
                                      if (chengeIndexColor == 5) {
                                        insdustryController
                                                .selectedIndustry.value =
                                            insdustryController.industryList
                                                .result.docs[5].name;
                                      }

                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: chengeIndexColor == index
                                                  ? Border(
                                                      top: BorderSide(
                                                          color: DynamicColor
                                                              .gredient1),
                                                      bottom: BorderSide(
                                                          color: DynamicColor
                                                              .gredient1))
                                                  : null),
                                          child: Text(
                                            insdustryController.industryList
                                                .result.docs[index].name,
                                            style: chengeIndexColor == index
                                                ? gredient122bold
                                                : textColor15,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                })),
              ],
            ),
            CustomHeaderView(
              progressPersent: 0.1,
              checkNext: 'next',
              nextOnTap: () {
                if (insdustryController.industryList.result.docs.isNotEmpty) {
                  if (_navigationController.navigationType.value == 'Post') {
                    PageNavigateScreen().push(
                        context,
                        LocationPage(
                          key: _abcKey,
                        ));
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
            NewCustomBottomBar(
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
