import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_jms/models/product.dart';
import 'package:provider/provider.dart';
import '../components/product_list_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main'; //TODO create other initial route

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> productList =
        Provider.of<ShowcaseManager>(context, listen: true).productList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Janete Semijoias'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Symbols.payments))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ShowcaseManager>(context, listen: false).getCloudProducts();
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(
          Symbols.add,
          size: 35,
        ),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductListTile(product: productList[index]);
        },
      ),
    );
  }
}
