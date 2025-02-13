import 'package:flutter/material.dart';
import 'package:shoe_app/global_variables.dart';
import 'package:shoe_app/widgets/product_card.dart';
import 'package:shoe_app/pages/products_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Goldstar',
    'Puma',
  ];

  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0]; // Default filter
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context); // or can use  . devicePixelRatioOf(context)

    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Products\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter; // Update filter and rebuild UI
                      });
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 240, 250, 255),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromARGB(255, 240, 250, 250),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.75,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductsDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundcolor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      // print(product);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductsDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundcolor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
