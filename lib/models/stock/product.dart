import 'package:app_jms/models/stock/supplier.dart';
import '../utils/enums/category.dart';
import '../utils/enums/metal.dart';
import '../utils/enums/modality.dart';
import '../utils/mixins/registerable.dart';

class Product implements Registerable {
  Product(
      {required this.id,
      required this.supplier,
      required this.supplierCode,
      this.modality = Modality.adult,
      required this.category,
      this.metal = Metal.gold,
      required this.description,
      required this.cost,
      required this.aVista,
      required this.aPrazo,
      required this.boughtDate});
  final Supplier supplier;
  final String supplierCode;
  final int id;
  final Modality modality;
  final Category category;
  final Metal metal;
  final String description;
  final double cost;
  final double aVista;
  final double aPrazo;
  final DateTime boughtDate;

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'data_compra': boughtDate,
        'descricao': description,
        'caracteristicas': {
          'categoria': category.name,
          'metal': metal.name,
          'modalidade': modality.name,
        },
        'dados_fabrica': {
          'codigo': supplierCode,
          'nome': supplier.name,
        },
        'precos': {
          'custo': cost,
          'vista': aVista,
          'prazo': aPrazo,
        },
      };

  @override
  String get log => 'ID:$id, $description';
}
