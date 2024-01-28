import 'package:app_jms/models/stock/product.dart';
import '../customers/customer.dart';
import '../utils/enums/payment_type.dart';
import '../utils/mixins/registerable.dart';

class Sale implements Registerable {
  Sale({
    required this.customer,
    required this.id,
    required this.saleDate,
    required Product firstProduct,
  }) {
    products.add(firstProduct);
  }

  final int id;
  final Customer customer;
  final DateTime saleDate;
  List<Product> products = [];
  double amountPaid = 0;
  double total = 0;

  bool get paid => total - amountPaid <= 0;

  List<int> get productsId =>
      products.map<int>((product) => product.id).toList();

  @override
  String get log => 'Venda id $id para cliente $customer no total de R\$$total';

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'cliente': customer.id,
        'produtos': productsId,
        'data_venda': saleDate,
        'total': total,
        'total_pago': amountPaid,
        'pago': paid
      };
}

class ProductSale {
  ProductSale({
    required this.id,
    required this.customer,
    required this.saleDay,
    required this.paymentType,
    required this.product,
  }) {
    if (paymentType == PaymentType.money ||
        paymentType == PaymentType.pix ||
        paymentType == PaymentType.debitCard) {
      total = product.aVista;
    } else {
      total = product.aPrazo;
    }
  }
  final int id;
  final Customer customer;
  final Product product;
  final DateTime saleDay;
  final PaymentType paymentType;
  late double total;
}
