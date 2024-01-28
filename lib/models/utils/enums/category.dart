import '../mixins/with_name.dart';

enum Category implements WithName {
  ring('Anél', 'assets/images/anel.png'),
  earring('Brinco', 'assets/images/brincos.png'),
  necklace('Colar', 'assets/images/colar.png'),
  bracelet('Bracelete', 'assets/images/pulseira.png'),
  pendant('Pingente', 'assets/images/pingente.png');

  const Category(this.name, this.path);

  @override
  final String name;

  final String path;

  static findItem(String name) {
    return values.firstWhere((element) => element.name == name);
  }
}
