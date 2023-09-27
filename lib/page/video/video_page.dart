import 'package:dcard/page/video/components/bottom_sheet.dart'
    as CustomBottomSheet;
import 'package:dcard/page/video/comment_bottom_sheet.dart';
import 'package:dcard/page/video/components/video_user_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../model/video_model.dart';
import '../../theme/video_page_theme.dart';
import '../../utils/components/my_avatar.dart';
import '../../utils/components/my_icon_button.dart';
import 'camera_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  VideoPageViewState createState() => VideoPageViewState();
}

class VideoPageViewState extends State<VideoPage> with WidgetsBindingObserver {
  List<UserVideo> videoDataList = [];
  late VideoPlayerController videoPlayerController;

  late VideoPlayerController element;
  late int currentIndex = 0;
  List<VideoPlayerController> playerList = [];
  List<Future> videoPlayListFuture = [];

  Future<PermissionStatus> getPermissions() async {
    PermissionStatus permissionStatus = PermissionStatus.granted;
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      // Permission.storage,
      Permission.microphone
    ].request();

    List<PermissionStatus> statusList = [];
    if (status[Permission.camera] != null) {
      statusList.add(status[Permission.camera]!);
    }
    // if (status[Permission.storage] != null) {
    //   statusList.add(status[Permission.storage]!);
    // }
    if (status[Permission.microphone] != null) {
      statusList.add(status[Permission.microphone]!);
    }
    for (var element in statusList) {
      if (element.isGranted) {
        print("同意");
      } else if (element.isPermanentlyDenied) {
        print("拒絕且不再提醒");
        permissionStatus = PermissionStatus.permanentlyDenied;
      } else {
        print("拒絕");
        if (permissionStatus == PermissionStatus.granted) {
          permissionStatus = PermissionStatus.denied;
        }
      }
    }

    return permissionStatus;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    videoDataList = UserVideo.fetchVideo();

    videoDataList
        .map((data) => playerList
            .add(VideoPlayerController.networkUrl(Uri.parse(data.url))))
        .toList();

    for (var element in playerList) {
      videoPlayListFuture.add(element.initialize());
      element.addListener(() {
        setState(() {});
      });
    }
    print('目前$currentIndex');
    playerList[currentIndex].play();
    playerList[currentIndex].setLooping(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('resumed 暫停播放 $currentIndex');
      playerList[currentIndex].pause();
    }
  }

  @override
  void dispose() {
    for (var player in playerList) {
      player.dispose();
      player.removeListener(() {
        setState(() {});
      });
    }
    playerList = [];
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget buildVideoWidget() {
    return FutureBuilder(
      future: videoPlayListFuture[currentIndex],
      builder: (BuildContext contex, value) {
        if (value.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              GestureDetector(
                  onTap: () {
                    if (playerList[currentIndex].value.isInitialized) {
                      /// 视频已初始化
                      if (playerList[currentIndex].value.isPlaying) {
                        print('點擊暂停$currentIndex');
                        playerList[currentIndex].pause();
                      } else {
                        print('點擊播放$currentIndex');
                        playerList[currentIndex].play();
                      }
                      setState(() {});
                    } else {
                      print('未初始化$currentIndex');
                      playerList[currentIndex] =
                          VideoPlayerController.networkUrl(
                              Uri.parse(videoDataList[currentIndex].url));
                      videoPlayListFuture[currentIndex] =
                          playerList[currentIndex].initialize();
                      playerList[currentIndex].play();
                    }
                  },
                  child: SizedBox.expand(
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio:
                                playerList[currentIndex].value.aspectRatio,
                            child: VideoPlayer(playerList[currentIndex]),
                          )))),
              Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: Container(
                  width: SysSize.avatar,
                  margin: const EdgeInsets.only(
                    right: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('MyAvatar');
                        },
                        child: const MyAvatar(),
                      ),
                      GestureDetector(
                          onTap: () {
                            print('FavoriteIcon');
                          },
                          child: const FavoriteIcon(
                            isFavorite: true,
                          )),
                      GestureDetector(
                        onTap: () {
                          CustomBottomSheet.showModalBottomSheet(
                            backgroundColor: Colors.white.withOpacity(0),
                            context: context,
                            builder: (BuildContext context) =>
                                const CommentBottomSheet(),
                          );
                        },
                        child: const MyIconButton(
                          icon: IconToText(Icons.mode_comment,
                              size: SysSize.iconBig - 4),
                          text: '4213',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('share');
                        },
                        child: const MyIconButton(
                          icon: IconToText(Icons.share, size: SysSize.iconBig),
                          text: '346',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          playerList[currentIndex].pause();
                          getPermissions().then((value) {
                            if (value.isGranted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CameraPage()));
                            } else {
                              Fluttertoast.showToast(
                                msg: "權限取得失敗",
                              );
                            }
                          });
                        },
                        child: const MyIconButton(
                          icon: IconToText(Icons.add_circle_outline,
                              size: SysSize.iconBig),
                          text: '',
                        ),
                      ),
                      Container(
                        width: SysSize.avatar,
                        height: SysSize.avatar,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SysSize.avatar / 2.0),
                          // color: Colors.black.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                child: const VideoUserInfo(),
              ),
            ],
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      allowImplicitScrolling: true,
      scrollDirection: Axis.vertical,
      controller: PageController(),
      onPageChanged: (int index) {
        print("onPageChanged:$index,total: ${videoDataList.length} ");
        currentIndex = index;
        if (index == 0) {
          playerList[index + 1].pause();
          playerList[index + 1].seekTo(Duration.zero);
        } else if (videoDataList.length - 1 == index) {
          playerList[index - 1].pause();
          playerList[index - 1].seekTo(Duration.zero);
        } else {
          playerList[index + 1].pause();
          playerList[index - 1].pause();
          playerList[index + 1].seekTo(Duration.zero);
          playerList[index - 1].seekTo(Duration.zero);
        }
        playerList[index].setLooping(true);
        playerList[index].play();
      },
      physics: const QuickerScrollPhysics(),
      itemCount: videoDataList.length,
      itemBuilder: (context, index) {
        return buildVideoWidget();
      },
    );
  }
}
