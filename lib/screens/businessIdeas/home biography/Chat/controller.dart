import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitch_me_app/main.dart';
import 'package:pitch_me_app/utils/firebase%20storage/firbase_storage.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  File imagePath = File('');
  // IO.Socket socket = IO.io('https://api.salespitchapp.com/',
  //     IO.OptionBuilder().setTransports(['websocket']).build());

  // Rx<StreamController<List<RoomMessage>>> streamController =
  //     StreamController<List<RoomMessage>>().obs;

  TextEditingController messageController = TextEditingController();
  dynamic userData;

  RxString filepath = "".obs;
  RxString audioPath = ''.obs;
  RxString downloadFirebaseUrl = ''.obs;
  RxString senderID = ''.obs;
  RxString chatID = ''.obs;
  RxString recieverid = ''.obs;

  RxBool readOnly = false.obs;
  RxBool isloading = false.obs;
  RxBool isKeyboardOpen = false.obs;
  RxBool showPlayer = false.obs;
  RxBool isRecorder = false.obs;

  RxInt recordDuration = 0.obs;
  Rx<Timer> timer = Timer(Duration(seconds: 0), () {}).obs;
  final audioRecorder = Record().obs;
  StreamSubscription<RecordState>? recordSub;
  RecordState recordState = RecordState.stop;
  StreamSubscription<Amplitude>? amplitudeSub;
  Amplitude? amplitude;

  late UploadTask task;

  void userID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senderID.value = prefs.get('user_id').toString();
  }

  Future<void> selectImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      imagePath = File(image!.path);
      downloadUrl(imagePath);
      update();
    } on PlatformException catch (e) {}
  }

  void downloadUrl(File path) async {
    log(path.path);
    isloading.value = true;

    final destination = 'file/${path.path}';
    task = FirebaseApi.uploadFile(destination, path)!;
    if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    var downloadUrls = await snapshot.ref.getDownloadURL().then((value) {
      downloadFirebaseUrl.value = value;

      sendMessage();
    }).catchError((e) {
      isloading.value = false;
    });
    isloading.value = false;
  }

  void downloadAudioUrl(File path) async {
    isloading.value = true;

    final destination = 'file/${path.path}';
    task = FirebaseApi.uploadFile(destination, path)!;
    if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    var downloadUrls = await snapshot.ref.getDownloadURL().then((value) {
      audioPath.value = value;
      log('url = ' + audioPath.value);
      sendMessage();
    }).catchError((e) {
      isloading.value = false;
    });
    isloading.value = false;
  }

  // voiceMsg
  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void startTimer() {
    timer.value.cancel();

    timer.value = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration.value++;
      update();
    });
  }

  Future<void> start() async {
    try {
      if (await audioRecorder.value.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await audioRecorder.value.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await audioRecorder.listInputDevices();
        // final isRecording = await audioRecorder.isRecording();

        await audioRecorder.value.start();
        recordDuration.value = 0;

        startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> stop() async {
    timer.value.cancel();
    recordDuration.value = 0;

    final path = await audioRecorder.value.stop();

    if (path != null) {
      audioPath.value = path;
      //streamController.add(audioPath.value);
      downloadAudioUrl(File(audioPath.value));
      update();
    }
  }

  Future<void> pause() async {
    timer.value.cancel();
    await audioRecorder.value.pause();
  }

  Future<void> resume() async {
    startTimer();
    await audioRecorder.value.resume();
  }

  void sendMessage() {
    String messageText = messageController.text.trim();

    if (messageText != '' ||
        downloadFirebaseUrl.value != '' ||
        audioPath.value != '' ||
        senderID.value != '') {
      var messagePost = {
        'message': messageText,
        'image': downloadFirebaseUrl.value,
        'voice': audioPath.value,
        'video': '',
        'sendorid': senderID.value,
        'chatid': chatID.value,
        'recieverid': recieverid.value,
      };
      log(messagePost.toString());
      socket.emit('sendmessage', messagePost);
    } else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Please enter message')));
    }

    downloadFirebaseUrl.value = '';
    messageController.clear();
    audioPath.value = '';
  }
}
