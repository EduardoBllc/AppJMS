import 'package:app_jms/constants.dart';
import 'package:app_jms/src/web/pages/stock/add_product_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/models/stock/stock_models.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../../../../services/controllers/showcase_manager.dart';
import '../../shared/web_default_scaffold.dart';
import 'components/filter_dropdown.dart';
import 'components/product_grid_tile.dart';
import '../../../../models/utils/stock_enums.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  static String id = '/estoque';

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late List<Product> productsList;
  late List<Supplier> suppliersList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Category filterCategory = Category.none;
  Modality filterModality = Modality.none;
  Metal filterMetal = Metal.none;
  String filterDescription = '';
  Supplier? filterSupplier;

  @override
  Widget build(BuildContext context) {
    suppliersList = Provider.of<ShowcaseManager>(context).supplierList;
    productsList = Provider.of<ShowcaseManager>(context).productList;

    StockFilter filter = StockFilter(
      productsList,
      category: filterCategory,
      modality: filterModality,
      metal: filterMetal,
      description: filterDescription,
      supplier: filterSupplier,
    );
    List<Product> filteredProducts = filter.filterItems;

    return WebScaffold(
      scaffoldKey: _scaffoldKey,
      endDrawer: const AddProductDrawer(),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPress: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: kCreamColor,
              boxShadow: const [
                BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 2),
                    blurRadius: 2),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Pesquisar produtos',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                      ),
                    ),
                    onChanged: (description) {
                      setState(() {
                        filterDescription = description;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                FilterDropdown<Category>(
                  label: 'Categoria',
                  icon: const Icon(Icons.category_outlined),
                  items: Category.values
                      .map<DropdownMenuItem<Category>>(
                        (category) => DropdownMenuItem<Category>(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (category) {
                    setState(() {
                      filterCategory = category ?? Category.none;
                    });
                  },
                ),
                const SizedBox(width: 20),
                FilterDropdown<Metal>(
                  icon: const Icon(Icons.texture_outlined),
                  label: 'Metal',
                  items: Metal.values
                      .map<DropdownMenuItem<Metal>>(
                        (metal) => DropdownMenuItem<Metal>(
                          value: metal,
                          child: Text(metal.name),
                        ),
                      )
                      .toList(),
                  onChanged: (metal) {
                    setState(() {
                      filterMetal = metal ?? Metal.none;
                    });
                  },
                ),
                const SizedBox(width: 20),
                FilterDropdown(
                  width: 170,
                  icon: const Icon(Icons.family_restroom_outlined),
                  label: 'Modalidade',
                  items: Modality.values
                      .map<DropdownMenuItem<Modality>>(
                        (modality) => DropdownMenuItem<Modality>(
                          value: modality,
                          child: Text(modality.name),
                        ),
                      )
                      .toList(),
                  onChanged: (modality) {
                    setState(() {
                      filterModality = modality ?? Modality.none;
                    });
                  },
                ),
                const SizedBox(width: 20),
                FilterDropdown<Supplier>(
                  label: 'Fábrica',
                  icon: const Icon(Icons.category_outlined),
                  items: Provider.of<ShowcaseManager>(context, listen: false)
                      .supplierList
                      .map<DropdownMenuItem<Supplier>>(
                        (category) => DropdownMenuItem<Supplier>(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (supplier) {
                    setState(() {
                      if (supplier == suppliersList[0]) {
                        filterSupplier = null;
                      } else {
                        filterSupplier = supplier;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredProducts.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return ProductGridTile(product: filteredProducts[index]);
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisExtent: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
