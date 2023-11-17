import 'package:app_jms/constants.dart';
import 'package:app_jms/controllers/showcase_manager.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/product.dart';
import 'package:provider/provider.dart';
import '../components/product_list_tile.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    Provider.of<ShowcaseManager>(context, listen: false).refreshFromCloud();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> productList =
        Provider.of<ShowcaseManager>(context, listen: true).productList;

    return RefreshIndicator(
      backgroundColor: kColorScheme.surface,
      onRefresh: () async {
        setState(() {
          Provider.of<ShowcaseManager>(context, listen: false)
              .refreshFromCloud();
        });
      },
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ProductListTile(product: productList[index]);
        },
      ),
    );
  }
}
