import 'dart:developer';

import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/model.dart';
import 'package:pitch_me_app/core/urls.dart';
import 'package:pitch_me_app/models/post/postModel.dart';
import 'package:pitch_me_app/models/statisticsModel/statisticsModel.dart';

class BusinessIdeasApi extends GetConnect {
  Future<PostModel?> getPost() async {
    try {
      var res = await get(GET_POST_DATA_URL);
      // log("Res is at getPost ${res.body}");
      if (res.statusCode == 200) {
        return PostModel.fromJson(res.body);
      }
    } catch (e) {
      log('error = ' + e.toString());
      return null;
    }

    return null;
  }

  Future<SalesPitchListModel?> getPost2(int pageCount) async {
    var res = await get('${BASE_URL}salespitch?type=2');
    log("Res is at getPost ${res.body}");
    if (res.statusCode == 200) {
      return SalesPitchListModel.fromJson(res.body);
    }
    return null;
  }

  Future<StatisticsModel?> getStatistics() async {
    var res = await get(GET_STASTICS_URL);
    //log("Res is at getStatistics ${res.body}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      return StatisticsModel.fromJson(res.body);
    }
    return null;
  }
}
