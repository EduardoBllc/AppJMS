import 'package:flutter/material.dart';
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
            text: 'Janete  ',
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
          FirebaseServices.logOutUser();
          Navigator.pushNamed(context, '/login');
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

NavigationRail kDefaultNavigationRail(
  int selectedIndex,
  void Function(int) onDestinationSelected,
) {
  return NavigationRail(
    backgroundColor: const Color(0XFFF0EEE9),
    labelType: NavigationRailLabelType.selected,
    groupAlignment: 0,
    unselectedIconTheme: IconThemeData(
      color: kColorScheme.onPrimary,
      size: 40,
    ),
    selectedIconTheme: IconThemeData(
      color: kColorScheme.primary,
      size: 40,
    ),
    unselectedLabelTextStyle: const TextStyle(
      color: Colors.black,
    ),
    selectedLabelTextStyle: const TextStyle(
      color: Colors.black,
    ),
    useIndicator: false,
    elevation: 5,
    onDestinationSelected: onDestinationSelected,
    selectedIndex: selectedIndex,
    destinations: const [
      NavigationRailDestination(
        icon: Icon(
          Icons.diamond_outlined,
        ),
        label: Text('Estoque'),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.person_outline,
        ),
        label: Text('Clientes'),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.account_balance_wallet_outlined,
        ),
        label: Text('Financeiro'),
      ),
      NavigationRailDestination(
        icon: Icon(
          Icons.query_stats,
        ),
        label: Text('Relatórios'),
      ),
    ],
  );
}
