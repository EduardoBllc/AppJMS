import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/product.dart';
import 'package:provider/provider.dart';
import '../../services/controllers/showcase_manager.dart';
import 'components/product_grid_tile.dart';
import 'components/product_list_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    Provider.of<ShowcaseManager>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> productList =
        Provider.of<ShowcaseManager>(context, listen: true).productList;

    return RefreshIndicator(
      backgroundColor: kColorScheme.surface,
      onRefresh: () async {
        Provider.of<ShowcaseManager>(context, listen: false).getProducts();
      },
      child: kIsWeb
          ? GridView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductGridTile(product: productList[index]);
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisExtent: 250,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 30),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductListTile(product: productList[index]);
              },
            ),
    );
  }
}
