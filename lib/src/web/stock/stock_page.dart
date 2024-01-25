import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/product.dart';
import 'package:provider/provider.dart';
import '../../../services/controllers/showcase_manager.dart';
import '../../web/stock/components/product_grid_tile.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late List<Product> productList;

  @override
  void initState() {
    Provider.of<ShowcaseManager>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productList = Provider.of<ShowcaseManager>(context).productList;

    return RefreshIndicator(
      backgroundColor: kColorScheme.surface,
      onRefresh: () async {
        Provider.of<ShowcaseManager>(context, listen: false).getProducts();
      },
      child: GridView.builder(
        itemCount: productList.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return ProductGridTile(product: productList[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisExtent: 250,
        ),
      ),
    );
  }
}
