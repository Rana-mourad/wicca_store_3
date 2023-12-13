import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicca_store_3/models/product.model.dart';
import 'package:wicca_store_3/provider/CartProvider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _MergedProductDetailsPageState();
}

class _MergedProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false)
          .getItemQuantity(widget.product.id ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<CartProvider>(
          builder:
              (BuildContext context, CartProvider cartProvider, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0XffF1F1F1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(170),
                          bottomLeft: Radius.circular(170),
                        ),
                      ),
                      height: 300,
                      child: Center(
                        child: CachedNetworkImage(
                          height: 230,
                          width: 260,
                          imageUrl: widget.product.image ?? '',
                          placeholder: (context, url) => const SizedBox(
                            height: 15,
                            width: 15,
                            child: FittedBox(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 7,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.title ?? 'No Title',
                              style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            if ((widget.product.rating!.rate! - (index + 1)) >=
                                0) {
                              return const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 255, 62, 59),
                              );
                            } else {
                              if ((widget.product.rating!.rate! - (index + 1)) <
                                  -1) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                );
                              } else {
                                if ((widget.product.rating!.rate! -
                                        (index + 1)) <
                                    -.5) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.star_half_sharp,
                                    color: Color.fromARGB(255, 255, 62, 59),
                                  );
                                }
                              }
                            }
                          }),
                          Text('(${widget.product.rating?.count})'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.product.price}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 223, 225, 225),
                                child: IconButton(
                                  onPressed: () =>
                                      cartProvider.onChangeItemQuantity(
                                    widget.product.id ?? 0,
                                  ),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 255, 62, 59),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text('${cartProvider.itemQuantity}'),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 246, 244, 243),
                                child: IconButton(
                                  onPressed: () =>
                                      cartProvider.onChangeItemQuantity(
                                    widget.product.id ?? 0,
                                    decrease: true,
                                  ),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Color.fromARGB(255, 255, 62, 59),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.product.description ?? 'No Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: cartProvider
                                      .checkItemInCart(widget.product.id ?? 0)
                                  ? null
                                  : () => addItemToCart(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 237, 233, 231),
                                foregroundColor:
                                    const Color.fromARGB(255, 7, 7, 7),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: cartProvider
                                        .checkItemInCart(widget.product.id ?? 0)
                                    ? Text('Item In Cart')
                                    : Text('Add To Cart'),
                              ),
                            ),
                          ),
                          if (cartProvider
                              .checkItemInCart(widget.product.id ?? 0))
                            IconButton(
                              onPressed: () => cartProvider
                                  .removeItemFromCart(widget.product.id ?? 0),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void addItemToCart() {
    Provider.of<CartProvider>(context, listen: false)
        .addProductToCart(widget.product);
  }
}
