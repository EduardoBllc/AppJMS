import '../utils/mixins/with_name.dart';

class Supplier extends WithName {
  Supplier({
    required this.name,
  });

  @override
  final String name;
}
