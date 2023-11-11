import 'package:app_jms/models/product.dart';

class Supplier extends WithName{
  Supplier({
    required this.name,
  });

  @override
  final String name;
}