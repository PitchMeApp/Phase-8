import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/show_image_popup.dart';
import 'package:url_launcher/url_launcher.dart';

class StatisticsPage_Two extends StatefulWidget {
  const StatisticsPage_Two(
      {Key? key, required this.pagecont, required this.salesDoc})
      : super(key: key);
  final PageController pagecont;
  final SalesDoc salesDoc;

  @override
  State<StatisticsPage_Two> createState() => _StatisticsPage_TwoState();
}

class _StatisticsPage_TwoState extends State<StatisticsPage_Two> {
  List typeList = [];
  List serviceList = [];
  List serviceDetailList = [];
  late SalesDoc salesDoc;
  @override
  void initState() {
    salesDoc = widget.salesDoc;
    var type = salesDoc.type.replaceAll('[', '').replaceAll(']', '');
    typeList = type.split(',');

    var service = salesDoc.services.replaceAll('[', '').replaceAll(']', '');
    if (service.isNotEmpty) {
      serviceList = service.split(', ');
    }
    var serviceDetail =
        salesDoc.servicesDetail.replaceAll('[', '').replaceAll(']', '');
    if (serviceDetail.isNotEmpty) {
      serviceDetailList = serviceDetail.split(', ');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Stack(
          children: [
            Column(
              children: [
                spaceHeight(SizeConfig.getSize60(context: context)),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.pagecont.previousPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10, right: 7),
                                child: /* SvgPicture.asset(Assets.tiktokPreviousIco),*/
                                    RotatedBox(
                                  quarterTurns: 6,
                                  child: Image.asset(
                                    "assets/Phase 2 icons/ic_keyboard_arrow_down_24px.png",
                                    color: Color(0xff377EB4),
                                    height:
                                        SizeConfig.getSize35(context: context),
                                    width:
                                        SizeConfig.getSize35(context: context),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Expanded(child: appStatistics(context: context)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appStatistics({required BuildContext context}) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: sizeH * 0.015),
            width: sizeW * 0.85,
            height: sizeH * 0.068,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff377EB4),
            ),
            child: ListTile(
                leading: Image.asset("assets/Phase 2 icons/industry.png",
                    height: sizeH * 0.04),
                title: Text(
                  widget.salesDoc.industry,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: sizeH * 0.015),
            width: sizeW * 0.85,
            height: sizeH * 0.068,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff377EB4),
            ),
            child: ListTile(
                leading: Image.asset("assets/Phase 2 icons/place.png",
                    height: sizeH * 0.04),
                title: Text(
                  widget.salesDoc.location,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          typeList.length > 0
              ? Container(
                  margin: EdgeInsets.only(bottom: sizeH * 0.015),
                  width: sizeW * 0.85,
                  height: sizeH * 0.068,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff377EB4),
                  ),
                  child: ListTile(
                      leading: Image.asset("assets/Phase 2 icons/local atm.png",
                          height: sizeH * 0.04),
                      title: Text(
                        typeList[0].replaceAll(',', ''),
                        style: TextStyle(color: Colors.white),
                      )),
                )
              : Container(),
          salesDoc.valueamount.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(bottom: sizeH * 0.015),
                  width: sizeW * 0.85,
                  height: sizeH * 0.068,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff377EB4),
                  ),
                  child: ListTile(
                      leading: Image.asset(
                          "assets/Phase 2 icons/monetization.png",
                          height: sizeH * 0.04),
                      title: Text(
                        salesDoc.valueamount,
                        style: TextStyle(color: Colors.white),
                      )),
                )
              : Container(),
          typeList.length > 1 && typeList[1].isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(bottom: sizeH * 0.015),
                  width: sizeW * 0.85,
                  height: sizeH * 0.068,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff377EB4),
                  ),
                  child: ListTile(
                      leading: Image.asset("assets/Phase 2 icons/Group.png",
                          height: sizeH * 0.04),
                      title: Text(
                        typeList[1],
                        style: TextStyle(color: Colors.white),
                      )),
                )
              : Container(),
          serviceList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: sizeH * 0.015),
                      width: sizeW * 0.85,
                      height: sizeH * 0.068,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff377EB4),
                      ),
                      child: ListTile(
                          leading: Image.asset(
                              "assets/Phase 2 icons/content paste.png",
                              height: sizeH * 0.04),
                          title: Text(
                            serviceList[index],
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  })
              : Container(),
          serviceDetailList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: serviceDetailList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: sizeH * 0.015),
                      width: sizeW * 0.85,
                      height: sizeH * 0.068,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff377EB4),
                      ),
                      child: ListTile(
                          leading: Image.asset(
                              "assets/Phase 2 icons/check circle.png",
                              height: sizeH * 0.04),
                          title: Text(
                            serviceDetailList[index],
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  })
              : Container(),
          Container(
            margin: EdgeInsets.only(bottom: sizeH * 0.015),
            width: sizeW * 0.85,
            height: sizeH * 0.068,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff377EB4),
            ),
            child: ListTile(
                leading: Text(""),
                title: AutoSizeText(
                  widget.salesDoc.description,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Wrap(
                runSpacing: 10,
                children: [
                  salesDoc.img1.isNotEmpty
                      ? imageWidget(salesDoc.img1)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img2.isNotEmpty
                      ? imageWidget(salesDoc.img2)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img3.isNotEmpty
                      ? imageWidget(salesDoc.img3)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.img4.isNotEmpty
                      ? imageWidget(salesDoc.img4)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  salesDoc.file.isNotEmpty
                      ? pdfWidget(salesDoc.file)
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget imageWidget(url) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ShowFullImagePopup(image_url: url));
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Image.network(
          url,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget pdfWidget(url) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
      child: Container(
        height: 120,
        width: 90,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.only(bottom: 10),
        child: Image.asset(
          'assets/images/pdf.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
