
import 'package:flutter/material.dart';

import '../../../theme/video_page_theme.dart';

class VideoUserInfo extends StatelessWidget {
  final String? desc;

  const VideoUserInfo({
    Key? key,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        bottom: 16,
      ),
      margin: const EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '@有錢人的枯燥生活語錄',
            style: StandardTextStyle.big,
          ),
          Container(height: 6),
          Text(
            desc ?? '#原創 有錢人的生活就是這麼的樸實無華，且枯燥 #短影音',
            style: StandardTextStyle.normal,
          ),
          Container(height: 6),
          const Row(
            children: <Widget>[
              Icon(
                Icons.music_note,
                size: 14,
                color: Colors.white,
              ),
              Expanded(
                child: Text(
                  'Andy的枯燥生活創作的原聲',
                  maxLines: 9,
                  style: StandardTextStyle.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
