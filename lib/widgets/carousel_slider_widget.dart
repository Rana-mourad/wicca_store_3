import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:wicca_store_3/models/ads.model.dart';
import 'package:wicca_store_3/widgets/home/ads.dart';

class CarouselSliderEx extends StatefulWidget {
  final List<Ad> ads;
  const CarouselSliderEx({required this.ads, Key? key}) : super(key: key);

  @override
  State<CarouselSliderEx> createState() => _CarouselSliderExState();
}

class _CarouselSliderExState extends State<CarouselSliderEx> {
  int currentPosition = 0;

  CarouselOptions get options => CarouselOptions(
        onPageChanged: (index, _) {
          currentPosition = index;
          setState(() {});
        },
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
          options: options,
          items: widget.ads.map((ad) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to AdsPage when the carousel item is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdsPage(ad: ad),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 90, 7),
                    ),
                    child: Text(
                      ad.title ?? 'No Title',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: widget.ads.length,
          position: currentPosition,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        )
      ],
    );
  }
}
