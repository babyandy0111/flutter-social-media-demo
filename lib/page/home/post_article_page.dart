import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class PostArticlePage extends StatefulWidget {
  const PostArticlePage({Key? key}) : super(key: key);

  @override
  PostArticlePageState createState() => PostArticlePageState();
}

class PostArticlePageState extends State<PostArticlePage> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          QuillToolbar.basic(controller: _controller),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              readOnly: false, // true for view only mode
            ),
          )
        ],
      ),
    );
  }
}
