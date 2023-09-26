import 'dart:io';

Socket? socket;
var videoList = [
  'test-video-10.mp4',
  'test-video-6.mp4',
  'test-video-9.mp4',
  'test-video-8.mp4',
  'test-video-7.mp4',
  'test-video-1.mp4',
  'test-video-2.mp4',
  'test-video-3.mp4',
  'test-video-4.mp4',
];

class UserVideo {
  final String url;
  final String image;
  final String? desc;

  UserVideo({
    required this.url,
    required this.image,
    this.desc,
  });

  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = videoList
        .map((e) => UserVideo(
            image: '',
        // url: 'https://www.shihjie.com/video/test-video/$e',
        url: 'https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8',
        desc: '$e'))
        .toList();
    return list;
  }

  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }
}