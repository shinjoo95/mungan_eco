import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youth_ecoapp/create/create_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel();
  File? _image;
  final _titleTextController = TextEditingController();

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('쓰레기 추가하기'),
        actions: [
          IconButton(
              onPressed: () {
                if (_image != null && _titleTextController.text.isNotEmpty) {
                  model.uploadPost(
                      _titleTextController.text,
                      _image!);
                }
              },
              icon: Icon(CupertinoIcons.archivebox)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              if (_image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 300,
                    height: 400,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              writeTextField(),
              ElevatedButton(
                  onPressed: () async {
                    _image = await model.getImage();
                    setState(() {
                      //화면 갱신
                      //await 쓰려면 async를 써야되서 _image는 못넣음 에러남;
                    });
                  },
                  child: Text('이미지 선택')),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget writeTextField() {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextField(
        controller: _titleTextController,
        style: TextStyle(fontSize: 20),
        maxLines: null,
        minLines: 5,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.green, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.green, width: 2)),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          hintText: '오늘의 쓰레기 일지를 입력하세요 :)',
          fillColor: Colors.white70,
        ),
      ),
    );
  }
}
