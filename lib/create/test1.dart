import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth_ecoapp/create/create_page.dart';
import 'package:youth_ecoapp/detail_post/detail_post_page.dart';
import 'package:youth_ecoapp/tab/search/search_model.dart';
import '../../domain/post.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final List<String> _urls = [
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmakemakeway.tistory.com%2F24&psig=AOvVaw35V4Xy0i_7tsRApP-cewNr&ust=1671009039608000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKC-wPOf9vsCFQAAAAAdAAAAABAI',
    'assets/joobong2.jpeg',
    'assets/joobong3.jpeg',
    'assets/youth1.png'
  ];
  @override
  Widget build(BuildContext context) {
    final model = SearchModel();
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 쓰레기 🗑️', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: StreamBuilder<QuerySnapshot<Post>>(
            initialData: null,
            stream: model.postsStream,
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text('알 수 없는 에러');
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              List<Post> posts = snapshot.data!.docs.map((e) => e.data() ).toList();

              return GridView.builder(
                itemCount: posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //열
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index];
                  return InkWell(
                    onTap: (){
                      Get.to(DetailPostPage(post: post));
                    },
                    child: Hero(
                      tag: post.id,
                      child: Image.network(
                        post.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreatePage());
        },
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.create_outlined,),
      ),
    );
  }
}
