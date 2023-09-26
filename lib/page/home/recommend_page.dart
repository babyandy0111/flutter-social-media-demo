import 'package:flutter/material.dart';
import '../../model/newsfeed.dart';
import 'components/newsFeedCard.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  RecommendPageState createState() => RecommendPageState();
}

class RecommendPageState extends State<RecommendPage> {
  @override
  Widget build(BuildContext context) {
    return const RecommendFeed();
  }
}

class RecommendFeed extends StatelessWidget {
  const RecommendFeed({super.key});

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueGrey[100],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsfeed.length,
                    itemBuilder: (context, index) {
                      var nf = newsfeed[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NewsFeedCard(nf: nf, index: index),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
