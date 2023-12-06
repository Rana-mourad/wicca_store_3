import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wicca_store_3/seeder/data.seeder.dart';
import 'package:wicca_store_3/views/productview.dart';
import 'package:wicca_store_3/widgets/headline.dart';
import 'package:wicca_store_3/widgets/home/categories_row.home.widget.dart';
import 'package:wicca_store_3/widgets/carousel_slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  ValueNotifier<List<int>> listNotifier = ValueNotifier<List<int>>([]);

  void addValueToList() {
    listNotifier.value.add(Random().nextInt(100));
    listNotifier.notifyListeners();
  }

  @override
  void dispose() {
    listNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await DataSeeder.loadData();
    setState(() {});
    _isLoading = false;
  }

  ValueNotifier<int> indexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeadlineWidget(title: 'Categories'),
          CategoriesRowHome(),
          ValueListenableBuilder<int>(
            valueListenable: indexNotifier,
            builder: (context, value, _) {
              return CarouselSliderEx(
                imageUrls: [
                  "https://m.media-amazon.com/images/I/81S-ekaE+vS._AC_UL320_.jpg",
                  "https://m.media-amazon.com/images/I/61hMQOHmEIL._AC_UL320_.jpg",
                  "https://m.media-amazon.com/images/I/81b9Eh286BL._AC_UL320_.jpg",
                  "https://m.media-amazon.com/images/I/61U-R3-znNL._AC_UL320_.jpg",
                ],
                onBtnPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsScreen(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
