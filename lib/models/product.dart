import 'package:app_jms/models/supplier.dart';

class Product {

  Product({
    this.code,
    required this.supplier,
    required this.supplierCode,
    this.modality = Modality.adult,
    required this.category,
    this.metal = Metal.gold,
    required this.description,
    required this.cost,
    required this.aVista,
    required this.aPrazo,
    required this.boughtDate
  });
  final Supplier supplier;
  final String supplierCode;
  final String? code;
  final Modality modality;
  final Category category;
  final Metal metal;
  final String description;
  final double cost;
  final double aVista;
  final double aPrazo;
  final DateTime boughtDate;
}


abstract class WithName {
  String get name;
}

enum Modality implements WithName{
  child('Infantil'),
  adult('Adulto');

  const Modality(this.name);

  @override
  final String name;
}

enum Category implements WithName{
  ring('Anél','assets/images/anel.png'),
  earring('Brinco','assets/images/brincos.png'),
  necklace('Colar','assets/images/colar.png'),
  bracelet('Bracelete','assets/images/pulseira.png'),
  pendant('Pingente','assets/images/pingente.png');

  const Category(this.name,this.path);

  @override
  final String name;
  final String path;
}

enum Metal implements WithName{
  gold('Ouro'),
  silver('Prata');

  const Metal(this.name);

  @override
  final String name;
}
