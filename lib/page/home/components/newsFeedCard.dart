import 'package:flutter/material.dart';

import '../../../utils/text_tyle_helper.dart';

class NewsFeedCard extends StatelessWidget {
  const NewsFeedCard({
    Key? key,
    required this.nf,
    required this.index,
    this.color,
  }) : super(key: key);

  final nf;
  final int index;
  final color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Colors.white,
      child: Container(
          // height: 100,
          constraints: BoxConstraints(
            minHeight: 50.0,
            maxHeight: 370.0,
            minWidth: 300,
            maxWidth: 800,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(nf.avatarUrl, width: 100, height: 100,),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nf.owner,
                                  style: myStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600)),
                              Text(nf.date,
                                  style: myStyle(
                                      fontSize: 12.0, color: Colors.grey))
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.more_horiz,
                          size: 30, color: Colors.grey),
                    ]),
                Padding(
                  padding: EdgeInsets.only(left: 55, top: 8),
                  child: Column(
                    children: [
                      Text(nf.content,
                          style: myStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8.0),
                      nf.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(nf.imageUrl, width: 300, height: 150,),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                index != 1
                                    ? const Icon(Icons.favorite_border,
                                        color: Colors.grey)
                                    : Container(width: 25),
                                const SizedBox(width: 8),
                                const Icon(Icons.message, color: Colors.grey)
                              ],
                            ),
                            Text(nf.price,
                                style: myStyle(
                                    color: Colors.black54,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500))
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
