import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wicca_store_3/models/product.model.dart';
import 'package:wicca_store_3/provider/CartProvider.dart';
import 'package:wicca_store_3/provider/FavouriteProvider.dart';
import 'package:wicca_store_3/provider/ProductProvider.dart';
import 'dart:math';
import 'package:wicca_store_3/seeder/data.seeder.dart';
import 'package:wicca_store_3/views/All_product.dart';
import 'package:wicca_store_3/widgets/catogeryitems.dart';
import 'package:wicca_store_3/widgets/headline.dart';
import 'package:wicca_store_3/widgets/home/categories_row.home.widget.dart';
import 'package:wicca_store_3/widgets/carousel_slider_widget.dart';
import 'package:wicca_store_3/widgets/home/product_widget.dart';
import 'package:wicca_store_3/widgets/masterWidget.dart';

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
    Provider.of<CartProvider>(context, listen: false).getCartProducts();
    Provider.of<FavouriteProvider>(context, listen: false)
        .getFavoriteProducts();
    Provider.of<ProductProvider>(context, listen: false).getCategories();
    Provider.of<ProductProvider>(context, listen: false).getProducts();

    return MasterWidget(
      bottomNavIndex: 0,
      body: SingleChildScrollView(
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
                  onPageChanged: (index, reason) {
                    indexNotifier.value = index;
                  },
                  onBtnPressed: () {},
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AllProductsPage()),
                  ),
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 71, 71),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            getCategoriesWidget(),
            const SizedBox(height: 20),
            getProductsWidget(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget getProductsWidget() {
    if (Provider.of<ProductProvider>(context).products?.isEmpty ?? false) {
      return const Text('No Products Found');
    } else {
      return Skeletonizer(
        enabled: Provider.of<ProductProvider>(context).products == null
            ? true
            : false,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: .7,
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: Provider.of<ProductProvider>(context)
                  .products
                  ?.map((e) => ProductWidget(product: e))
                  .toList() ??
              List.generate(6, (index) => ProductWidget(product: Product())),
        ),
      );
    }
  }

  Widget getCategoriesWidget() {
    if (Provider.of<ProductProvider>(context).categories?.isEmpty ?? false) {
      return const Text('No Categories Found');
    } else {
      return SizedBox(
        height: 65,
        child: Skeletonizer(
          enabled: Provider.of<ProductProvider>(context).categories == null
              ? true
              : false,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: Provider.of<ProductProvider>(context)
                    .categories
                    ?.map((e) => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CategoryItem(
                            categoryName: e,
                          ),
                        ))
                    .toList() ??
                List.generate(
                    4,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CategoryItem(
                            categoryName: '',
                          ),
                        )),
          ),
        ),
      );
    }
  }
}
