import 'package:app_jms/views/sales_screen.dart';
import 'package:app_jms/views/stock_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controllers/user_provider.dart';
import 'configuration_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: const ConfigurationDrawer(),
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.5,
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
        title: Text(
          'JM Semijoias',
          style: kBrandTextStyle(25, color: Colors.amber.shade200),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<UserProvider>(context, listen: false).signOutUser();
              Navigator.pushNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 250),
        height: 65,
        buttonBackgroundColor: Colors.black,
        index: _currentPageIndex,
        items: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                width: 2,
                color: kColorScheme.primary,
              ),
            ),
            child: Icon(
              Icons.diamond_outlined,
              size: 33,
              color: kColorScheme.primary,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 2,
                color: kColorScheme.primary,
              ),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              size: 28,
              color: kColorScheme.primary,
            ),
          ),
        ],
        color: Colors.white,
        backgroundColor: kColorScheme.background,
        onTap: (index) {
          _currentPageIndex = index;¨¨
        },
      ),
      body: [
        const StockScreen(),
        const SalesScreen(),
        // const ReportsScreen(),
      ][_currentPageIndex],
    );
  }
}
