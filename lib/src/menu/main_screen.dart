import 'package:app_jms/services/firebase_services.dart';
import 'package:flutter/material.dart';
import '../customers/customers_screen.dart';
import '../financial/sales_screen.dart';
import '../reports/reports_screen.dart';
import '../shared/configuration_drawer.dart';
import '../shared/scaffold_components/default_components.dart';
import '../stock/stock_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Widget> destinationsList = [
    const StockScreen(),
    const CustomersScreen(),
    if (!kIsWeb) const Placeholder(),
    const SalesScreen(),
    const ReportsScreen(),
  ];

  final FirebaseServices _firebaseServices = FirebaseServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebScaffold(
            scaffoldKey: _scaffoldKey,
            firebaseServices: _firebaseServices,
            body: destinationsList[_currentPageIndex],
            navigationRail: kDefaultNavigationRail(_currentPageIndex, (index) {
              setState(() {
                _currentPageIndex = index;
              });
            }))
        : MobileScaffold(
            scaffoldKey: _scaffoldKey,
            firebaseServices: _firebaseServices,
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

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({
    super.key,
    required this.scaffoldKey,
    required this.firebaseServices,
    required this.bottomNavigationBar,
    required this.body,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final FirebaseServices firebaseServices;
  final Widget bottomNavigationBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ConfigurationDrawer(),
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: kDefaultAppBar(
        context,
        scaffoldKey: scaffoldKey,
        firebaseServices: firebaseServices,
      ),
      floatingActionButton: kSpeedDial(context),
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}

class WebScaffold extends StatelessWidget {
  const WebScaffold({
    super.key,
    required this.scaffoldKey,
    required this.firebaseServices,
    required this.body,
    required this.navigationRail,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final FirebaseServices firebaseServices;
  final Widget body;
  final NavigationRail navigationRail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ConfigurationDrawer(),
      key: scaffoldKey,
      appBar: kDefaultAppBar(
        context,
        scaffoldKey: scaffoldKey,
        firebaseServices: firebaseServices,
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            navigationRail,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
