import 'package:app_jms/constants.dart';

import '../financial/sale.dart';
import '../utils/mixins/registerable.dart';

class Customer implements Registerable {
  Customer({
    required this.id,
    required this.name,
    required this.birthday,
    required this.registerDate,
    this.whatsapp,
    this.email,
    this.cellphone,
    this.lastPurchaseId,
    this.lastPurchase,
  }) {
    if (whatsapp == null && cellphone != null) {
      whatsapp = cellphone;
    }
  }

  final int id;
  final String name;
  late final DateTime registerDate;
  final DateTime birthday;
  int? lastPurchaseId;
  Sale? lastPurchase;
  String? whatsapp;
  String? cellphone;
  String? email;

  String get formattedBirthday => brazilianDateFormatter.format(birthday);

  String get maskedCellphone => cellphoneMask.maskText(cellphone.toString());

  String get timeSinceLastPurchase {
    if (lastPurchase == null) {
      return 'cliente ainda não possui compras';
    }
    int timeDifferenceInDays = DateTime.now().difference(lastPurchase!.saleDate).inDays;

    if (timeDifferenceInDays > 60) {
      if (timeDifferenceInDays % 30 != 0) {
        return '${timeDifferenceInDays ~/ 30} meses e ${timeDifferenceInDays % 30} dias';
      } else {
        return '${timeDifferenceInDays / 30} meses';
      }
    } else {
      return '$timeDifferenceInDays dias';
    }
  }

  @override
  String toString() => name;

  @override
  String get log => '$name, contato: ${whatsapp ?? cellphone ?? email ?? 'Não registrado'}';

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'nome': name,
        'celular': cellphone,
        'whatsapp': whatsapp,
        'email': email,
        'data_aniversário': birthday,
        'data_registro': registerDate,
      };
}
