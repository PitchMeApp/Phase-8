import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitch_me_app/View/Custom%20header%20view/new_bottom_bar.dart';
import 'package:pitch_me_app/View/Profile/Pitches/controller.dart';
import 'package:pitch_me_app/View/Profile/Pitches/model.dart';
import 'package:pitch_me_app/View/posts/detail_page.dart';
import 'package:pitch_me_app/View/posts/profile_appbar.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/Alert%20Box/delete_sales_post.dart';
import 'package:pitch_me_app/utils/widgets/Arrow%20Button/back_arrow.dart';

class PitchesListPage extends StatefulWidget {
  const PitchesListPage({super.key});

  @override
  State<PitchesListPage> createState() => _PitchesListPageState();
}

class _PitchesListPageState extends State<PitchesListPage> {
  // late VideoPlayerController _videoPlayerController;

  PitcheController controller = Get.put(PitcheController());

  // Future _initVideoPlayer(List list) async {
  //   //videoViewerControllerList = [];
  //   try {

  //     // _videoPlayerController = VideoPlayerController.network(url);
  //     // await _videoPlayerController.initialize();
  //     // await _videoPlayerController.setLooping(true);
  //     // await _videoPlayerController.pause();
  //   } catch (e) {

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: NewCustomBottomBar(
        index: 4,
        isBack: true,
      ),
      body: Stack(
        children: [_buildBodyView(), BackArrow()],
      ),
    );
  }

  Widget _buildBodyView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            ProfilePostHeader(
              title: 'Pitches',
            ),
            const SizedBox(height: 30),
            _postListWidget(),
          ],
        ),
      ),
    );
  }

  Widget _postListWidget() {
    return Expanded(
      child: FutureBuilder<SavedListModel>(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                  color: DynamicColor.blue,
                ));
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('No pitches available'));
                } else if (snapshot.data!.result.isEmpty) {
                  return const Center(child: Text('No pitches available'));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.result.length,
                      itemBuilder: (context, index) {
                        SavedResult data = snapshot.data!.result[index];
                        //log(snapshot.data!.result.length.toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => PostDetailPage(
                                    data: data,
                                  ));
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                _leadImgeAndTitle(data, index),
                                _removeButton(index, data.id)
                              ],
                            ),
                          ),
                        );
                      });
                }
            }
          }),
    );
  }

  Widget _leadImgeAndTitle(SavedResult data, int index) {
    return Container(
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: DynamicColor.blue, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  //  data.vid1.isNotEmpty
                  //     ?
                  Container(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.img1,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                        color: DynamicColor.white,
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/image_not.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // VideoViewer(
                //   controller: VideoViewerController(),
                //   autoPlay: false,
                //   enableHorizontalSwapingGesture: false,
                //   enableVerticalSwapingGesture: false,
                //   volumeManager: VideoViewerVolumeManager.device,
                //   onFullscreenFixLandscape: false,
                //   forwardAmount: 5,
                //   defaultAspectRatio: 9 / 16,
                //   rewindAmount: -5,
                //   looping: true,
                //   enableShowReplayIconAtVideoEnd: false,
                //   source: {
                //     "Source": VideoSource(
                //       video: VideoPlayerController.network(data.vid1),
                //     )
                //   },
                // ),
                //VideoPlayer(_videoPlayerController),
              )
              // : Image.asset(
              //     'assets/images/not_video.jpg',
              //     height: 100,
              //     width: 100,
              //     fit: BoxFit.cover,
              //   ),
              ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                title: Text(
                  data.title,
                  style: white15TextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      data.status == 1 ? 'Pending' : 'Approved',
                      style: darkBlue12,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.comment,
                      style: white15TextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _removeButton(int index, id) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => DeleteSalesPostPopUp(
                  id: id,
                  type: 'Pitches',
                )).then((value) {
          setState(() {});
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: DynamicColor.white,
                borderRadius: BorderRadius.circular(20)),
            child: Image.asset(
              "assets/images/ic_add_24px.png",
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
