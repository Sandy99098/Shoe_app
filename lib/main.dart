import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/cart_provider.dart';
import 'package:shoe_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FOR RETURNING MULTIPLE PROVIDERS WE CAN USE MULTIPROVIDER
    //WITH THE LIST OF THE PROVIDERS

    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        home: const HomePage(),
        // home: ProductsDetailsPage(
        //   product: products[0],
        // ),
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(245, 247, 249, 1),
            primary: const Color.fromARGB(255, 242, 255, 61),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromRGBO(245, 247, 249, 1),
            ),
            prefixIconColor: const Color.fromARGB(119, 119, 119, 1),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
            titleSmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
