import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants.dart';
import '../../../../services/firebase_services.dart';

AppBar kDefaultAppBar(
  BuildContext context, {
  required GlobalKey<ScaffoldState> scaffoldKey,
  required FirebaseServices firebaseServices,
  bool automaticallyImplyLeading = false,
  Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: !automaticallyImplyLeading
        ? GestureDetector(
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
          )
        : null,
    centerTitle: true,
    title: Text.rich(
      const TextSpan(
        children: [
          TextSpan(
            text: 'JM  ',
            style: TextStyle(fontFamily: 'MonteCarlo', fontSize: 30),
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
      if (automaticallyImplyLeading)
        GestureDetector(
          onTap: () {
            scaffoldKey.currentState!.openEndDrawer();
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
      IconButton(
        onPressed: () {
          Navigator.pop(context);
          firebaseServices.logOutUser();
          Navigator.pushNamed(context, '/login');
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

SpeedDial kSpeedDial(BuildContext context) {
  return SpeedDial(
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
          Navigator.pushNamed(context, '/add');
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
  );
}

Widget kDefaultNavigationBar(
  int selectedIndex,
  void Function(int) onDestinationSelected,
) {
  return Container(
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
      notchMargin: 4,
      clipBehavior: Clip.antiAlias,
      child: NavigationBar(
        backgroundColor: const Color(0xFFF5F0E6),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
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
      ),
    ),
  );
}
