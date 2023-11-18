import 'package:app_jms/services/firebase_services.dart';
import 'package:flutter/material.dart';
import '../customers/customers_screen.dart';
import '../financial/sales_screen.dart';
import '../reports/reports_screen.dart';
import '../shared/configuration_drawer.dart';
import '../stock/stock_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // backgroundColor: Color(0xFFD9D9D9),
      drawer: const ConfigurationDrawer(),
      key: scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              foregroundImage:
                  const AssetImage('assets/images/avatar_default.png'),
              backgroundColor: Colors.grey[600],
            ),
          ),
        ),
        centerTitle: true,
        title: Text.rich(
          const TextSpan(
            children: [
              TextSpan(
                text: 'JM  ',
                style: TextStyle(fontFamily: 'Montecarlo', fontSize: 30),
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
              _services.logOutUser();
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const ShapeDecoration(
          shape: ContinuousRectangleBorder(),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: Colors.white70,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.diamond_outlined,
                size: 30,
              ),
              label: 'Estoque',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                size: 30,
              ),
              label: 'Clientes',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
              ),
              label: 'Financeiro',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.query_stats,
                size: 30,
              ),
              label: 'Relatórios',
            ),
          ],
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
      body: [
        const StockScreen(),
        const CustomersScreen(),
        const SalesScreen(),
        const ReportsScreen(),
      ][_currentPageIndex],
    );
  }
}
