import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/cart_provider.dart';

class ProductsDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductsDetailsPage({super.key, required this.product});

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  int selectedSize = 0;
  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'sizes': selectedSize,
          'company': widget.product['company'],
          'imageUrl': widget.product['imageUrl'],
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product has been sucessfully Added to the cart"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Select the size !"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                height: 250,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Container(
              height: 250, // Fixed height to ensure valid constraints
              width: double.infinity, // Use full available width
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 247, 249, 1), // Chip color
// Background color
                borderRadius: BorderRadius.circular(40), // Rounded corners
              ),
              child: Column(
                children: [
                  Text(
                    "\$${widget.product['price']}", // Display the price
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                      height: 10), // Spacing between text and ListView

                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (BuildContext context, int index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              label: Text(size.toString()),
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        onTap();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: const Size(350, 50),
                        minimumSize: const Size(267, 50),
                        elevation: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              color: Colors.black),
                          const SizedBox(width: 10),
                          Text(
                            "Add To Cart",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
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
