import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            minHeight: 50.0.h,
            maxHeight: 370.0.h,
            minWidth: 300.w,
            maxWidth: 800.w,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).w,
            child: Wrap(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            nf.avatarUrl,
                            width: 100.w,
                            height: 100.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nf.owner,
                                  style: myStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.black54,
                                    // fontWeight: FontWeight.w600
                                  )),
                              Text(nf.date,
                                  style: myStyle(
                                      fontSize: 12.0.sp, color: Colors.grey))
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.more_horiz,
                          size: 30, color: Colors.grey),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 8).w,
                  child: Column(
                    children: [
                      Text(nf.content,
                          style: myStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400)),
                      SizedBox(height: 8.0.h),
                      nf.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                nf.imageUrl,
                                width: 300.w,
                                height: 150.h,
                              ),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 15.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                index != 1
                                    ? const Icon(Icons.favorite_border,
                                        color: Colors.grey)
                                    : Container(width: 25.w),
                                SizedBox(width: 8.w),
                                const Icon(Icons.message, color: Colors.grey)
                              ],
                            ),
                            Text(nf.price,
                                style: myStyle(
                                  color: Colors.black54,
                                  fontSize: 15.0.sp,
                                  // fontWeight: FontWeight.w500
                                ))
                          ]),
                      SizedBox(
                        height: 10.h,
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
