import 'package:app_jms/constants.dart';
import 'package:app_jms/src/web/pages/stock/add_product_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/product.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../../../services/controllers/showcase_manager.dart';
import '../../shared/web_default_scaffold.dart';
import 'components/product_grid_tile.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late List<Product> productList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<ShowcaseManager>(context, listen: false).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productList = Provider.of<ShowcaseManager>(context).productList;

    return WebScaffold(
      scaffoldKey: _scaffoldKey,
      endDrawer: const AddProductDrawer(),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPress: () {
          print(_scaffoldKey.currentState);
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: RefreshIndicator(
        backgroundColor: kColorScheme.surface,
        onRefresh: () async {
          Provider.of<ShowcaseManager>(context, listen: false).getProducts();
        },
        child: GridView.builder(
          itemCount: productList.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return ProductGridTile(product: productList[index]);
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            mainAxisExtent: 250,
          ),
        ),
      ),
    );
  }
}
