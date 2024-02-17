import '../mixins/with_name.dart';

enum Modality implements WithName {
  child('Infantil'),
  adult('Adulto'),
  none('Nenhum');

  const Modality(this.name);

  @override
  final String name;

  static findItem(String name) {
    return values.firstWhere((element) => element.name == name);
  }
}
