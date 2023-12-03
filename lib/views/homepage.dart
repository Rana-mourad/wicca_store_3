import 'package:flutter/material.dart';
import 'package:wicca_store_3/seeder/data.seeder.dart';
import 'package:wicca_store_3/widgets/headline.dart';
import 'package:wicca_store_3/widgets/home/ads.dart';
import 'package:wicca_store_3/widgets/home/categories_row.home.widget.dart';
import 'package:wicca_store_3/widgets/carousel_slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await DataSeeder.loadData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeadlineWidget(title: 'Categories'),
          CategoriesRowHome(),
          if (_isLoading)
            CircularProgressIndicator()
          else
            _buildHomePageContent(),
        ],
      ),
    );
  }

  Widget _buildHomePageContent() {
    return Column(
      children: [
        //CarouselSliderEx(
        // items: [
        //  'first Ad',
        //  'second Ad',
        //   'third Ad',
        //   'forth Ad',
      ],
      //  ),
      // SizedBox(height: 16), // Adjust the spacing as needed
      // _buildAdsSection(),
      // ],
    );
  }

  Widget _buildAdsSection() {
    return Column(
      children: DataSeeder.ads.map((ad) => AdsPage(ad: ad)).toList(),
    );
  }
}
