import 'package:app_jms/models/financial/sale.dart';
import 'package:app_jms/models/utils/enums/payment_type.dart';
import 'package:app_jms/services/controllers/customers_caretaker.dart';
import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:app_jms/src/web/pages/customers/components/customer_card.dart';
import 'package:app_jms/src/web/shared/web_default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/customers/customer.dart';
import '../../../../models/stock/product.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  static String id = '/clientes';

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.sizeOf(context).width);

    List<Customer> customerList = Provider.of<CustomersCaretaker>(context).customersList;

    List<Product> productList = Provider.of<ShowcaseManager>(context).productList;

    customerList[0].lastPurchase = Sale(
      customer: customerList[0],
      id: 0,
      saleDate: DateTime(2023, 10, 12),
      firstProduct: ProductSale(
        id: 0,
        customer: customerList[0],
        saleDay: DateTime.now(),
        paymentType: PaymentType.money,
        product: productList[0],
      ),
    );

    return WebScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffDEDEDE),
                ),
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemCount: customerList.length,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  itemBuilder: (context, index) {
                    return CustomerCard(customer: customerList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
