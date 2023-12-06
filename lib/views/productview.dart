import 'package:flutter/material.dart';
import 'package:wicca_store_3/widgets/home/product_widget.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView(
        children: [
          ProductWidget(
            name: 'shoes For Men',
            price: 19.99,
            description: 'shoes For Men with trendy design.',
            imageUrl:
                'https://m.media-amazon.com/images/I/81S-ekaE+vS._AC_UL320_.jpg',
          ),
          ProductWidget(
            name: 'shoes 2023',
            price: 29.99,
            description: 'The Coolest shoes Of 2023 - Black.',
            imageUrl:
                'https://m.media-amazon.com/images/I/61U-R3-znNL._AC_UL320_.jpg',
          ),
        ],
      ),
    );
  }
}
