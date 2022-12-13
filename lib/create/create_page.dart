import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:youth_ecoapp/create/create_model.dart';
import 'package:dotted_border/dotted_border.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel();
  File? _image;
  bool isLoading = false;

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
              onPressed: () async{
                if (_image != null && _titleTextController.text.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  await model.uploadPost(_titleTextController.text, _image!);
                  setState(() {
                    isLoading = false;
                  });
                  if(mounted){
                    Navigator.pop(context);
                  }
                }
              },
              icon: Icon(Icons.add_box_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(isLoading) CircularProgressIndicator(),
              SizedBox(height: 20),
              ImagePicField(),
              writeTextField(),
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
  Widget ImagePicField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        _image != null
            ? DottedBorder(
                color: Colors.green,
                strokeWidth: 1.4,
                dashPattern: [10, 6],
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                child: Container(
                  height: 100,
                  width: 100,
                  child: IconButton(
                    onPressed: () async {
                      _image = await model.getImage();
                      setState(() {});
                    },
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : DottedBorder(
                color: Colors.green,
                strokeWidth: 1.4,
                dashPattern: [10, 6],
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                child: Container(
                  height: 100,
                  width: 100,
                  child: IconButton(
                    onPressed: () async {
                      _image = await model.getImage();
                      setState(() {});
                    },
                    icon: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle),
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
        SizedBox(width: 10),
        if (_image != null) Container(child: Text('내용을 입력 해주세요'))
      ],
    );
  }
}
