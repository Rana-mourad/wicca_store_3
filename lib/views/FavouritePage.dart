import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicca_store_3/provider/FavouriteProvider.dart';
import 'package:wicca_store_3/widgets/home/product_widget.dart';
import 'package:wicca_store_3/widgets/masterWidget.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      bottomNavIndex: 1,
      body:
          (Provider.of<FavouriteProvider>(context).favouriteProducts == null ||
                  (Provider.of<FavouriteProvider>(context)
                          .favouriteProducts
                          ?.isEmpty ??
                      false))
              ? const Center(
                  child: Text('No Favourite Products'),
                )
              : GridView.count(
                  childAspectRatio: .7,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: Provider.of<FavouriteProvider>(context)
                          .favouriteProducts
                          ?.map((e) => ProductWidget(product: e))
                          .toList() ??
                      [],
                ),
    );
  }
}
