import 'package:app_jms/constants.dart';
import '../financial/sale.dart';
import '../utils/mixins/registerable.dart';

class Customer implements Registerable {
  Customer({
    required this.id,
    required this.name,
    required this.birthday,
    this.whatsapp,
    this.email,
    this.cellphone,
  }) {
    if (whatsapp == null && cellphone != null) {
      whatsapp = cellphone;
    }
  }

  final int id;
  final String name;
  late final DateTime _registerDate;
  final DateTime birthday;
  Sale? lastSale;
  int? whatsapp;
  int? cellphone;
  String? email;

  DateTime get registerDate => _registerDate;

  String get formattedBirthday => brazilianDateFormatter.format(birthday);

  String get maskedCellphone => cellphoneMask.maskText(cellphone.toString());

  @override
  String toString() => name;

  @override
  String get log =>
      '$name, contato: ${whatsapp ?? cellphone ?? email ?? 'Não registrado'}';

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'nome': name,
        'celular': cellphone,
        'whatsapp': whatsapp,
        'email': email,
        'data_aniversário': birthday,
        'data_registro': _registerDate,
      };
}
