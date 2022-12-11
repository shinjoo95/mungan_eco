import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<String> _slideImages = [
    'assets/pic1.jpeg',
    'assets/pic2.jpeg',
    'assets/pic3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   leading: Image.asset('assets/youth2.png',),
      //   ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1, right: 1),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/youth1.png',
                            width: 100,
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          child: Image.asset(
                            'assets/logo.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 200, child: slidePictures()),
                      Divider(),
                      contactButton(),
                      SizedBox(height: 10),
                      Support(context),
                      SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slidePictures() {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
      items: _slideImages.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
  Widget contactButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            onPressed: () async {
              final url =
                  Uri.parse('https://www.instagram.com/youthmungan_eco/');
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              } else {
                print('Cannot launch $url');
              }
            },
            child: Image.asset(
              'assets/instagram.png',
              height: 30,
              width: 30,
            )),
        SizedBox(
          height: 35,
          child: VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            onPressed: () async {
              final url = Uri.parse('https://m.youtube.com/@user-fr1wt2oo3u');
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              } else {
                print('Cannot launch $url');
              }
            },
            child: Image.asset(
              'assets/youtube.png',
              height: 60,
              width: 60,
            )),
        SizedBox(
          height: 35,
          child: VerticalDivider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            onPressed: () async {
              final url = Uri.parse('https://youthmungan.com/59');
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              } else {
                print('Cannot launch $url');
              }
            },
            child: Image.asset(
              'assets/home.png',
              height: 30,
              width: 30,
            )),
      ],
    );
  }
  Widget Support(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width ,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
            elevation: 0.0,
          ),
            onPressed: () async {
              final url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSedNMPQIYqNBli_3HyDjocScwTaySB9f7vP9ljFtjq0LJnHAw/viewform');
              if (await canLaunchUrl(url)) {
                launchUrl(url);
              } else {
                print('Cannot launch $url');
              }
            },
            child:Row(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/youth2.png',
                      width: 100,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '서포터즈 활동이 궁금하다면?',
                          style: TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        Text('참여 하러가기',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(width:30),
                    Icon(
                      CupertinoIcons.arrow_right_square,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
            )
      ),
    );
  }
}
