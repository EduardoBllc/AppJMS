class Product {
  static int actualCode = 0;

  Product({
    required this.supplier,
    required this.supplierCode,
    this.modality = Modality.adult,
    required this.category,
    this.metal = Metal.gold,
    required this.description,
    required this.cost,
    required this.upfrontValue,
    required this.deferredValue,
    required this.boughtDate
  }) {
    actualCode++;
  }
  final String supplier;
  final int supplierCode;
  final int code = actualCode;
  final Modality modality;
  final Category category;
  final Metal metal;
  final String description;
  final double cost;
  final double upfrontValue;
  final double deferredValue;
  final DateTime boughtDate;
}

enum Modality {
  child('Infantil'),
  adult('Adulto');

  const Modality(this.name);

  final String name;
}

enum Category {
  ring('Anél'),
  earring('Brinco'),
  necklace('Colar'),
  bracelet('Bracelete'),
  pendant('Pingente');

  const Category(this.name);

  final String name;
}

enum Metal {
  gold('Ouro'),
  silver('Prata');

  const Metal(this.name);

  final String name;
}
