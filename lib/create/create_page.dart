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
        title: Text('Add Waste'),
        actions: [
          IconButton(
              onPressed: () async {
                if (_image != null && _titleTextController.text.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  await model.uploadPost(_titleTextController.text, _image!);
                  setState(() {
                    isLoading = false;
                  });
                  if (mounted) {
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Text(
                  '🍀 쓰레기 일기 규칙 🍀',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. 하루동안 내가 배출한 모든 쓰레기 솔직하게 기록하기'),
                  SizedBox(height: 3),
                  Text('2. 하루 일정이 끝난 뒤 모든 쓰레기를 모아서 사진 찍은 후 '),
                  Text('쓰레기 일기 작성하기'),
                  SizedBox(height: 3),
                  Text('3. 일주일 뒤 단톡방에 쓰레기 일기 캡쳐, 느낀점 공유하기'),
                  Text('* 화장실에서 사용한 휴지는 제외😉'),
                ],
              ),
              if (isLoading) CircularProgressIndicator(),
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
      ],
    );
  }
}
