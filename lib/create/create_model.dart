import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youth_ecoapp/domain/post.dart';

class CreateModel {
  final _picker = ImagePicker();
  Future<File?> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<void> uploadPost(String title, File imageFile) async {
    //이미지 업로드
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}.png'); //파일명
    //이미지 url 을 얻고
    await imageRef.putFile(imageFile);
    final downloadUrl = await imageRef.getDownloadURL();
    //게시물 업로드
    final postsRef = FirebaseFirestore.instance
        .collection('posts')
        .withConverter<Post>(
            fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
            toFirestore: (post, _) => post.toJson());

    final newPostRef = postsRef.doc();
    newPostRef.set(Post(
      id: newPostRef.id,
      userId: FirebaseAuth.instance.currentUser?.uid ?? '닉네임',
      title: title,
      imageUrl: downloadUrl,
    ));
  }
}
