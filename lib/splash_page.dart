import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  CarouselController controller = CarouselController();
  @override
  void initState() {
    super.initState();
    initialization();
  }

  List imageList = [
    'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821_1280.jpg',
  ];
  int current = 0;
  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                reverse: true,
                enlargeCenterPage: true,
                initialPage: 2,
                onPageChanged: (i, j) {
                  setState(() {
                    current = i;
                  });
                  print('scroller event :$i : $j');
                  print('scroller current :$current');
                }),
            items: imageList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(i);
                  // Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //     decoration: BoxDecoration(color: Colors.orange),
                  //     child: i);
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    controller.previousPage();
                  },
                  icon: Icon(Icons.arrow_back)),
              IconButton(
                  onPressed: () {
                    controller.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                          .withOpacity(current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
