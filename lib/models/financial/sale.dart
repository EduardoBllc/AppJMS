import 'package:app_jms/models/stock/product.dart';
import '../customers/customer.dart';
import '../utils/enums/payment_type.dart';
import '../utils/mixins/registerable.dart';

class Sale implements Registerable {
  Sale({
    required this.customer,
    required this.id,
    required this.saleDate,
    required ProductSale firstProduct,
  }) {
    _products.add(firstProduct);
    total = firstProduct.total;
  }

  final int id;
  final Customer customer;
  final DateTime saleDate;
  final List<ProductSale> _products = [];
  double amountPaid = 0;
  double total = 0;

  bool get paid => total - amountPaid <= 0;

  List<int> get productsId =>
      _products.map<int>((product) => product.id).toList();

  void addProduct(ProductSale product) {
    _products.add(product);
  }

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
    total = paymentType == PaymentType.creditCard ||
            paymentType == PaymentType.installment
        ? total = product.aVista
        : product.aPrazo;
  }
  final int id;
  final Customer customer;
  final Product product;
  final DateTime saleDay;
  final PaymentType paymentType;
  late double total;
}
