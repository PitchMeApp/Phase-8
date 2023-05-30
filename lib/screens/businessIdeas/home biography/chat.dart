import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:pitch_me_app/utils/colors/colors.dart';
import 'package:pitch_me_app/utils/sizeConfig/sizeConfig.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:pitch_me_app/utils/widgets/containers/containers.dart';

class ChatPage extends StatefulWidget {
  final id;

  ChatPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //LocalStorage storage = LocalStorage('user');
  TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController controller = ScrollController();

  // IO.Socket socket = IO.io('https://meghlar.herokuapp.com/messaging',
  //     IO.OptionBuilder().setTransports(['websocket']).build());

  List messages = [];
  dynamic userData;
  StreamSocket streamSocket = StreamSocket();
  bool isloading = false;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    // userData = storage.getItem('data');
    //print(userData);
    //connectAndListen();
    super.initState();
  }

  // connectAndListen() {
  //   socket.onConnect((_) {
  //     print('connect');
  //     socket.emit('room.join', widget.id);
  //     socket.emit('room.getoldmsg', widget.id);

  //     socket.on('message.emit.oldmsgs', (message) {
  //       setState(() {
  //         messages = message;
  //       });
  //       setState(() {
  //         isloading = false;
  //       });
  //     });
  //     socket.on('message.emit.client', (message)
  //         //=> streamSocket.addResponse);
  //         {
  //       setState(() {
  //         messages.add(message);
  //         print('qfh' + messages.length.toString());
  //       });
  //     });
  //     socket.on('message.emit.clientold', (message) {
  //       print('iru' + message.toString());
  //     });
  //   });
  // }

  // void _sendMessage() {
  //   String messageText = _messageController.text.trim();
  //   // _messageController.text = '';

  //   if (messageText != '') {
  //     var messagePost = {
  //       'message': messageText,
  //       'image': null,
  //       'audio': null,
  //       'video': null,
  //       'senderid': {
  //         'user_id': userData['user_id'],
  //         'email': userData['user']['email'],
  //         'photo': userData['user']['photo'],
  //       },
  //       'roomId': widget.id,
  //       'time': DateTime.now().toString(),
  //       'date': DateTime.now().toString(),
  //     };

  //     socket.emit('message.emit.server', messagePost);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please enter some text')));
  //   }

  //   setState(() {
  //     _messageController.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: Stack(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/images/17580.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  color: DynamicColor.blue,
                  height: MediaQuery.of(context).size.height * 0.235,
                  child: Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: DynamicColor.white,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.getSize60(context: context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Chat',
                                style: white17wBold,
                              ),
                              Image.asset(
                                "assets/image/handshake.png",
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/17580.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                    child: isloading == false
                        ? StreamBuilder(
                            stream: streamSocket.getResponse,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return listData();
                            })
                        : Center(
                            child: Text(
                            'Coming soon',
                            style: blue28,
                          )
                            // CircularProgressIndicator(
                            //     color: DynamicColor.blue)
                            )),

                // inputBox()

                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _messageController,
                            focusNode: focusNode,
                            textCapitalization: TextCapitalization.sentences,
                            autocorrect: true,
                            enableSuggestions: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              labelText: 'Type new message',
                              labelStyle: TextStyle(color: DynamicColor.blue),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 0),
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: DynamicColor.blue),
                                gapPadding: 0,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onTap: () {
                              if (focusNode.canRequestFocus == true) {
                                Timer(const Duration(milliseconds: 500), () {
                                  controller.animateTo(
                                    controller.position.maxScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          // _sendMessage();
                          Timer(const Duration(seconds: 2), () {
                            controller.animateTo(
                              controller.position.maxScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: DynamicColor.darkBlue,
                          ),
                          child: const Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget listData() {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      //reverse: true,

      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        var message = messages[index];

        return (message['__senderid__']['user_id'] == userData['user_id'])
            ? ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                backGroundColor: DynamicColor.lightGrey,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${message['message']}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16)),
                      Text('${message['time']}',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
              )
            : ChatBubble(
                clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                backGroundColor: DynamicColor.blue,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${message['message']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      Text('${message['time']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              );
      },
    );
  }

  // Widget inputBox() {
  //   return ChatComposer(
  //     controller: _messageController,
  //     onReceiveText: (str) {
  //       _sendMessage();
  //       Timer(const Duration(seconds: 2), () {
  //         controller.animateTo(
  //           controller.position.maxScrollExtent,
  //           curve: Curves.easeOut,
  //           duration: const Duration(milliseconds: 300),
  //         );
  //       });
  //     },
  //     onRecordEnd: (path) {
  //       setState(() {
  //         print(path);
  //         // list.add('AUDIO PATH : ${path!}');
  //       });
  //     },
  //     textPadding: EdgeInsets.zero,
  //     leading: CupertinoButton(
  //       padding: EdgeInsets.zero,
  //       child: const Icon(
  //         Icons.insert_emoticon_outlined,
  //         size: 25,
  //         color: Colors.grey,
  //       ),
  //       onPressed: () {},
  //     ),
  //     actions: [
  //       CupertinoButton(
  //         padding: EdgeInsets.zero,
  //         child: const Icon(
  //           Icons.attach_file_rounded,
  //           size: 25,
  //           color: Colors.grey,
  //         ),
  //         onPressed: () {},
  //       ),
  //       CupertinoButton(
  //         padding: EdgeInsets.zero,
  //         child: const Icon(
  //           Icons.camera_alt_rounded,
  //           size: 25,
  //           color: Colors.grey,
  //         ),
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }

  @override
  void dispose() {
    _messageController.dispose();
    // socket.disconnect();
    super.dispose();
  }
}

class StreamSocket {
  final _socketResponse = StreamController<String>();
  void Function(String) get addResponse => _socketResponse.sink.add;
  Stream<String> get getResponse => _socketResponse.stream;
  void dispose() {
    _socketResponse.close();
  }
}
