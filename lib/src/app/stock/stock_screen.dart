import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/stock/product.dart';
import 'package:provider/provider.dart';
import '../../../services/controllers/showcase_manager.dart';
import 'components/product_list_tile.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> productList =
        Provider.of<ShowcaseManager>(context, listen: true).productList;

    if (productList.isEmpty) {
      Provider.of<ShowcaseManager>(context).getProducts();
    }

    return RefreshIndicator(
      backgroundColor: kColorScheme.surface,
      onRefresh: () async {
        // Provider.of<ShowcaseManager>(context, listen: false).getProducts();
      },
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 30),
        itemCount: productList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return ProductListTile(product: productList[index]);
        },
      ),
    );
  }
}
