import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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
        title: Text('🌟 waste diary 🌟', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightGreen,
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('내가 배출한 쓰레기들을 다시 내눈으로 확인하면서 👀', style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('무심코 버리던 쓰레기에 대한 시선을 바꾸기 위한 프로젝트', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 200),
            Divider(),
            Padding(
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
                    shrinkWrap: true,
                    itemCount: posts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                        childAspectRatio: 4/5
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final post = posts[index];
                      return Container(
                        child: InkWell(
                          onTap: (){
                            Get.to(DetailPostPage(post: post));
                          },
                          child: Card(
                            elevation: 1.0,
                            margin: EdgeInsets.all(3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    child: Image.network(
                                      post.imageUrl,
                                       width: MediaQuery.of(context).size.width,
                                        height: 100,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                      child: Text(model.getNickName(), style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                      child: Text(post.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
            SizedBox(height: 200,)
          ],
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
