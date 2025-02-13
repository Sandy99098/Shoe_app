import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (BuildContext context, int index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              // child: Image.asset("${cartItem['imageUrl']}"),
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  // barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        "Are you sure , you want to remove the product from your cart ?",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size(55, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context
                                .read<CartProvider>()
                                .removeProduct(cartItem);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(8),
                            minimumSize: const Size(55, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              " ${cartItem['title'].toString()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              "Sizes : ${cartItem['sizes']}",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
        },
      ),
    );
  }
}
