import 'package:app_jms/services/firebase_services/authentication_services.dart';

import '../shared/scaffold_components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import '../pages/reports/reports_page.dart';
import '../pages/financial/sales_page.dart';
import '../pages/customers/customers_page.dart';
import '../pages/stock/stock_page.dart';

class WebMenuPage extends StatefulWidget {
  const WebMenuPage({super.key});

  static const String id = '/menu';

  @override
  State<WebMenuPage> createState() => _WebMenuPageState();
}

class _WebMenuPageState extends State<WebMenuPage> {
  List<Widget> destinationsList = [
    const StockPage(),
    const CustomersPage(),
    const SalesPage(),
    const ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuNavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          const TextSpan(
            children: [
              TextSpan(
                text: 'Janete  ',
                style: TextStyle(
                  fontFamily: 'MonteCarlo',
                  fontSize: 30,
                ),
              ),
              TextSpan(
                text: 'semijoias',
                style: TextStyle(fontFamily: 'Aboreto', fontSize: 17),
              ),
            ],
          ),
          style: TextStyle(color: Colors.amber.shade200),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              FirebaseAuthServices.logOutUser();
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
