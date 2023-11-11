import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:app_jms/controllers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_jms/models/product.dart';
import 'package:provider/provider.dart';
import '../components/product_list_tile.dart';
import '../components/show_snack_bar.dart';
import '../constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> productList =
        Provider.of<ShowcaseManager>(context, listen: true).productList;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JM Semijoias',
          style: kBrandTextStyle(25, color: Colors.amber.shade200),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<ShowcaseManager>(context, listen: false)
                    .refreshFromCloud();
              });

              showSnackBar(context: context, message: 'Produtos atualizados');
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<UserProvider>(context, listen: false).signOutUser();
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
