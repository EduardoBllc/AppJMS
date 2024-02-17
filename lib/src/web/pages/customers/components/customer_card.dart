import 'package:flutter/material.dart';

import '../../../../../models/customers/customer.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CircleAvatar(
                  radius: 40,
                  foregroundImage:
                      const AssetImage('assets/images/avatar_default.png'),
                  backgroundColor: Colors.grey[600],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    customer.id.toString(),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              if (MediaQuery.sizeOf(context).width > 1300)
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contato: ${customer.cellphone != null ? customer.maskedCellphone : customer.email ?? ''}',
                      ),
                      const SizedBox(height: 15),
                      Text('Aniversário: ${customer.formattedBirthday}'),
                    ],
                  ),
                ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: VerticalDivider(
              color: Color(0xFFd9d9d9),
              indent: 15,
              endIndent: 15,
              thickness: 1.5,
            ),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('Tempo desde a última compra:'),
                      Text(customer.timeSinceLastPurchase),
                    ],
                  ),
                  if (customer.lastPurchase != null)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text('Valor da úlima compra:'),
                        Text(
                          '${customer.lastPurchase!.amountPaid}/${customer.lastPurchase!.total}',
                          style: TextStyle(
                            color: customer.lastPurchase!.paid
                                ? Colors.greenAccent
                                : customer.lastPurchase!.amountPaid >=
                                        customer.lastPurchase!.total / 2
                                    ? Colors.amberAccent
                                    : Colors.redAccent,
                            fontWeight: customer.lastPurchase!.amountPaid == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
