import 'package:flutter/material.dart';

import '../../../../../models/customers/customer.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    bool mediumWidth = MediaQuery.sizeOf(context).width > 1100;
    bool largeWidth = MediaQuery.sizeOf(context).width > 1300;
    return Container(
      height: 120,
      padding: const EdgeInsets.fromLTRB(20, 10, 25, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage: const AssetImage('assets/images/avatar_default.png'),
                    backgroundColor: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: mediumWidth
                          ? MediaQuery.sizeOf(context).width * 0.13
                          : MediaQuery.sizeOf(context).width * 0.3,
                      child: Text(
                        customer.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: mediumWidth ? TextAlign.left : TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      customer.id.toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (largeWidth)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Contato',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${customer.cellphone != null ? customer.maskedCellphone : customer.email}'),
                    const SizedBox(height: 10),
                    const Text(
                      'Aniversário',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(customer.formattedBirthday),
                  ],
                ),
              ),
            ),
          if (mediumWidth)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: VerticalDivider(
                color: Color(0xFFd9d9d9),
                indent: 15,
                endIndent: 15,
                thickness: 1.5,
              ),
            ),
          if (mediumWidth)
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Tempo desde a última compra',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(customer.timeSinceLastPurchase),
                        ],
                      ),
                      if (customer.lastPurchase != null)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Valor da úlima compra',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${customer.lastPurchase!.amountPaid}/${customer.lastPurchase!.total}',
                              style: TextStyle(
                                color: customer.lastPurchase!.paid
                                    ? Colors.greenAccent
                                    : customer.lastPurchase!.amountPaid >= customer.lastPurchase!.total / 2
                                        ? Colors.amberAccent
                                        : Colors.redAccent,
                                fontWeight:
                                    customer.lastPurchase!.amountPaid == 0 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
