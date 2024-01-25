import 'package:app_jms/src/web/menu/components/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_jms/services/firebase_services.dart';
import '../reports/reports_page.dart';
import '../financial/sales_page.dart';
import '../../web/customers/customers_page.dart';
import '../stock/stock_page.dart';
import '../../web/shared/scaffold_components/default_components.dart';

class WebMenuPage extends StatefulWidget {
  const WebMenuPage({super.key});

  static const String id = '/menu';

  @override
  State<WebMenuPage> createState() => _WebMenuPageState();
}

class _WebMenuPageState extends State<WebMenuPage> {
  int _currentPageIndex = 0;

  List<Widget> destinationsList = [
    const StockPage(),
    const CustomersScreen(),
    const SalesPage(),
    const ReportsScreen(),
  ];

  final FirebaseServices _firebaseServices = FirebaseServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuNavigationDrawer(),
      key: _scaffoldKey,
      appBar: kDefaultAppBar(
        context,
        scaffoldKey: _scaffoldKey,
        firebaseServices: _firebaseServices,
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            kDefaultNavigationRail(
              _currentPageIndex,
              (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
            ),
            Expanded(
              child: destinationsList[_currentPageIndex],
            ),
          ],
        ),
      ),
    );
  }
}
