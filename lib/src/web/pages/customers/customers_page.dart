import 'package:app_jms/src/web/pages/customers/components/customer_card.dart';
import 'package:app_jms/src/web/shared/web_default_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../models/customers/customer.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  static String id = '/clientes';

  @override
  Widget build(BuildContext context) {
    List<Customer> customerList = [
      Customer(
        id: 0,
        name: 'Eduardo Salvagni Ballico',
        birthday: DateTime(2002, 9, 19),
        cellphone: 54996758088,
      ),
    ];

    return WebScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffDEDEDE),
                ),
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemCount: customerList.length,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  itemBuilder: (context, index) {
                    return CustomerCard(customer: customerList[index]);
                  },
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(3, 3),
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Color(0x30000000),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
