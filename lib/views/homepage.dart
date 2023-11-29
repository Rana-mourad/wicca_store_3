import 'package:flutter/material.dart';
import 'package:wicca_store_3/widgets/carousel_slider_widget.dart';
import 'package:wicca_store_3/widgets/headline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        HeadlineWidget(title: 'Categories'),
        CarouselSliderEx(
          items: [
            'first Ad',
            'second Ad',
            'third Ad',
            'forth Ad',
          ],
        )
      ],
    );
  }
}
