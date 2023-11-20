import 'package:app_jms/constants.dart';
import 'package:app_jms/services/firebase_services.dart';
import 'package:app_jms/src/stock/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../customers/customers_screen.dart';
import '../financial/sales_screen.dart';
import '../reports/reports_screen.dart';
import '../shared/configuration_drawer.dart';
import '../stock/stock_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  final FirebaseServices _firebaseServices = FirebaseServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFD9D9D9),
      drawer: const ConfigurationDrawer(),
      key: _scaffoldKey,
      appBar: kAppBar(
        context,
        scaffoldKey: _scaffoldKey,
        firebaseServices: _firebaseServices,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.2,
        spaceBetweenChildren: 5,
        icon: Icons.add,
        iconTheme: const IconThemeData(
          size: 35,
        ),
        children: [
          SpeedDialChild(
            shape: const CircleBorder(),
            label: 'Peça',
            labelStyle: const TextStyle(color: Colors.black),
            onTap: () {
              Navigator.pushNamed(context, AddProductScreen.id);
            },
            child: Icon(
              MdiIcons.ring,
              color: kColorScheme.onPrimary,
            ),
          ),
          SpeedDialChild(
            shape: const CircleBorder(),
            label: 'Venda',
            labelStyle: const TextStyle(color: Colors.black),
            onTap: () {},
            child: Icon(
              MdiIcons.cash,
              color: kColorScheme.onPrimary,
            ),
          ),
          SpeedDialChild(
            shape: const CircleBorder(),
            label: 'Cliente',
            labelStyle: const TextStyle(color: Colors.black),
            onTap: () {},
            child: Icon(
              MdiIcons.accountMultiplePlusOutline,
              color: kColorScheme.onPrimary,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const ShapeDecoration(
          shape: ContinuousRectangleBorder(),
          shadows: [
            BoxShadow(
              color: Color(0xefe1e0dd),
              blurRadius: 3,
              offset: Offset(0, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomAppBar(
          color: const Color(0Xfff0eee9),
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          child: NavigationBar(
            backgroundColor: Colors.transparent,
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
              SizedBox(),
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
      ),
      body: [
        const StockScreen(),
        const CustomersScreen(),
        const Placeholder(),
        const SalesScreen(),
        const ReportsScreen(),
      ][_currentPageIndex],
    );
  }
}
