import '../mixins/with_name.dart';

enum Metal implements WithName {
  gold('Ouro'),
  silver('Prata');

  const Metal(this.name);

  @override
  final String name;

  static findItem(String name) {
    return values.firstWhere((element) => element.name == name);
  }
}
