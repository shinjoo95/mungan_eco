
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/post.dart';


//게시글 불러오기
class SearchModel{
  //포스트에 있는 전체 데이터 정보를 가지고 온다.
  final Stream<QuerySnapshot<Post>> postsStream  =
      FirebaseFirestore.instance.collection('posts')
          .withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson())
          .snapshots();
}