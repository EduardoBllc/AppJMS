import 'package:app_jms/models/stock/stock_models.dart';
import 'package:app_jms/models/utils/stock_enums.dart';

import 'filter.dart';

class StockFilter extends Filter<Product> {
  StockFilter(
    super.itemsList, {
    this.modality = Modality.none,
    this.category = Category.none,
    this.metal = Metal.none,
    this.description = '',
    this.supplier,
  });

  Supplier? supplier;
  Modality modality;
  Category category;
  Metal metal;
  String description;

  @override
  List<Product> get filterItems => itemsList.where((product) {
        return (product.description.contains(description) ||
                description == '') &&
            (product.supplier == supplier || supplier == null) &&
            (product.metal == metal || metal == Metal.none) &&
            (product.modality == modality || modality == Modality.none) &&
            (product.category == category || category == Category.none);
      }).toList();
}
