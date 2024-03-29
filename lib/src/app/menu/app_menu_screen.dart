import 'package:flutter/material.dart';
import '../../app/shared/configuration_drawer.dart';
import '../reports/reports_screen.dart';
import '../../app/financial/sales_screen.dart';
import '../../app/customers/customers_screen.dart';
import '../shared/scaffold_components/default_components.dart';
import '../stock/stock_screen.dart';

class AppMenuScreen extends StatefulWidget {
  const AppMenuScreen({super.key});

  static const String id = '/app/menu';

  @override
  State<AppMenuScreen> createState() => _AppMenuScreenState();
}

class _AppMenuScreenState extends State<AppMenuScreen> {
  int _currentPageIndex = 0;

  List<Widget> destinationsList = [
    const StockScreen(),
    const CustomersScreen(),
    const Placeholder(),
    const SalesScreen(),
    const ReportsScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ConfigurationDrawer(),
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: kDefaultAppBar(
        context,
        scaffoldKey: _scaffoldKey,
      ),
      floatingActionButton: kSpeedDial(context),
      bottomNavigationBar: kDefaultNavigationBar(
        _currentPageIndex,
        (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: destinationsList[_currentPageIndex],
    );
  }
}
