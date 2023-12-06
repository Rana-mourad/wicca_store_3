import 'package:flutter/material.dart';
import 'package:wicca_store_3/views/product_details_page.dart';

class ProductWidget extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  ProductWidget({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              name: name,
              price: price,
              description: description,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        // Your product widget UI here
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 175, 94, 76),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
