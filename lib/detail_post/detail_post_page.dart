import 'package:flutter/material.dart';
import 'package:youth_ecoapp/detail_post/detail_post_model.dart';
import 'package:youth_ecoapp/domain/post.dart';

class DetailPostPage extends StatelessWidget {
  final Post post;
  const DetailPostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = DetailPostModel();
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.getNickName()}님 게시글"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.getProfileImageUrl()),
                    ),
                    SizedBox(width: 15),
                    Text(
                      model.getNickName(),
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: post.id,
                  child: Image.network(
                    post.imageUrl,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(post.title),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
