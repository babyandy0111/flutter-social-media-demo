import 'dart:io';

Socket? socket;

var videoList = [
  'https://www.shihjie.com/video/test-video/test-video-10.mp4',
  'https://www.shihjie.com/video/test-video/test-video-6.mp4',
  'https://www.shihjie.com/video/test-video/test-video-9.mp4',
  'https://www.shihjie.com/video/test-video/test-video-8.mp4',
  'https://www.shihjie.com/video/test-video/test-video-7.mp4',
  'https://www.shihjie.com/video/test-video/test-video-1.mp4',
  'https://www.shihjie.com/video/test-video/test-video-2.mp4',
  'https://www.shihjie.com/video/test-video/test-video-3.mp4',
  'https://www.shihjie.com/video/test-video/test-video-4.mp4',
  'https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8',
  'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
  'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.mp4/.m3u8',
  'https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8',
  'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
  'http://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8',
  'http://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multichannel_subs.m3u8',
  'http://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_multi_language_subs.m3u8',
  'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
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
    List<UserVideo> list =
        videoList.map((e) => UserVideo(image: '', url: e, desc: e)).toList();
    return list;
  }

  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }
}
