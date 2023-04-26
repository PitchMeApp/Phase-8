import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Fund%20Page/fund_neccessar_controller.dart';
import 'package:pitch_me_app/View/Need%20page/need_page_edit.dart';
import 'package:pitch_me_app/View/navigation_controller.dart';
import 'package:pitch_me_app/View/what%20need/who_need_page_controller.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/strings/strings.dart';
import 'package:pitch_me_app/utils/widgets/Navigation/custom_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/styles.dart';
import '../../utils/widgets/Arrow Button/arrow_button.dart';
import '../Custom header view/custom_header_view.dart';

class FundsPageEdit extends StatefulWidget {
  bool isCheck;
  List length;
  FundsPageEdit({super.key, required this.isCheck, required this.length});

  @override
  State<FundsPageEdit> createState() => _FundsPageEditState();
}

class _FundsPageEditState extends State<FundsPageEdit> {
  final FundNacessaryController _fundNacessaryController =
      Get.put(FundNacessaryController());
  final NavigationController _navigationController =
      Get.put(NavigationController());
  final WhoNeedController _whoNeedController = Get.put(WhoNeedController());
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();

  int isIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _fundNacessaryController.getValueList.value.isEmpty
              ? Container()
              : ArrowButton(onPressed: () {
                  if (_whoNeedController.checkType.value == 'Investor') {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else {
                    if (widget.length.length > 1) {
                      PageNavigateScreen().push(
                          context,
                          NeedPageEdit(
                            key: abcKey,
                            isCheck: true,
                            length: widget.length,
                          ));
                    } else {
                      if (widget.isCheck == true) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                  }
                }),
          NewCustomBottomBar(
            index: 2,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomHeaderView(
              title: TextStrings.textKey['funds']!,
              icon: 'assets/images/doller sign.png',
              subTitle: TextStrings.textKey['syb_funds']!,
              progressPersent: 0.4,
              padding: 0,
            ),
            const SizedBox(height: 10),
            GridView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 9.0,
                  mainAxisExtent: 40),
              children:
                  List.generate(_fundNacessaryController.data.length, (index) {
                return customBox(
                    10.0,
                    10.0,
                    10.0,
                    10.0,
                    _fundNacessaryController.data[index]['value'],
                    _fundNacessaryController.data[index]['isSelected'],
                    onPressad: () => setState(() {
                          isIndex = index;
                          _fundNacessaryController.onselectAmount(
                              _fundNacessaryController.data[index], index);
                        }));
              }),
            ),
            _amountList(),
          ],
        ),
      ),
    );
  }

  Widget _amountList() {
    return Obx(() {
      return _fundNacessaryController.getValueList.value.isEmpty
          ? Container()
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ClickableListWheelScrollView(
                scrollController: _fundNacessaryController.scrollController,
                itemHeight: 10,
                itemCount: _fundNacessaryController.getValueList.value.length,
                child: ListWheelScrollView.useDelegate(
                  controller: _fundNacessaryController.scrollController,
                  itemExtent: 50,
                  physics: const FixedExtentScrollPhysics(),
                  overAndUnderCenterOpacity: 0.8,
                  perspective: 0.004,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _fundNacessaryController.chengeIndexColor.value = index;
                      _fundNacessaryController.selectedValue.value =
                          _fundNacessaryController.getValueList.value[index]
                              .toString();
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount:
                        _fundNacessaryController.getValueList.value.length,
                    builder: (context, index) {
                      if (_fundNacessaryController.chengeIndexColor.value ==
                          0) {
                        _fundNacessaryController.selectedValue.value =
                            _fundNacessaryController.getValueList[0].toString();
                      }

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _fundNacessaryController
                                        .chengeIndexColor.value ==
                                    index
                                ? DynamicColor.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          '${_fundNacessaryController.getValueList.value[index]}',
                          style:
                              _fundNacessaryController.chengeIndexColor.value ==
                                      index
                                  ? white17wBold
                                  : blue17,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
    });
  }

  Widget customBox(topLeft, bottomLeft, topRight, bottomRight, String string, i,
      {required VoidCallback onPressad}) {
    return InkWell(
      onTap: onPressad,
      child: Container(
        height: 30.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: DynamicColor.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              bottomLeft: Radius.circular(bottomLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/mony.png',
              width: 15,
            ),
            const SizedBox(width: 3),
            Text(
              string,
              style: TextStyle(
                fontSize: 15.0,
                color: i ? DynamicColor.darkBlue : DynamicColor.white,
                fontWeight: FontWeight.bold,
                //fontFamily: poppies,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
