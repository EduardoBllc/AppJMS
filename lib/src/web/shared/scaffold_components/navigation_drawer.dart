import 'package:flutter/material.dart';
import '../../pages/customers/customers_page.dart';
import '../../pages/financial/sales_page.dart';
import '../../pages/stock/stock_page.dart';

class MenuNavigationDrawer extends StatelessWidget {
  const MenuNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Divider separatorDivider = const Divider(
      indent: 30,
      endIndent: 30,
      color: Color(0x10000000),
      thickness: 2,
    );

    return Container(
      constraints: BoxConstraints(
        minWidth: 50,
        maxWidth: MediaQuery.sizeOf(context).width * 0.2,
      ),
      color: Colors.white,
      child: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.3,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    radius: MediaQuery.sizeOf(context).height * 0.07,
                    foregroundImage:
                        const AssetImage('assets/images/avatar_default.png'),
                    backgroundColor: Colors.grey[600],
                  ),
                ),
                const Text(
                  'Definições do perfil',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: separatorDivider,
          ),
          NavigationTile(
            icon: Icons.diamond_outlined,
            pageName: 'Estoque',
            pageRoute: StockPage.id,
          ),
          separatorDivider,
          NavigationTile(
            pageName: 'Financeiro',
            icon: Icons.account_balance_wallet_outlined,
            pageRoute: SalesPage.id,
          ),
          separatorDivider,
          NavigationTile(
            pageName: 'Clientes',
            icon: Icons.groups_outlined,
            pageRoute: CustomersPage.id,
          ),
        ],
      ),
    );
  }
}

class NavigationTile extends StatelessWidget {
  const NavigationTile({
    super.key,
    required this.pageName,
    required this.icon,
    required this.pageRoute,
  });

  final String pageName;
  final IconData icon;
  final String pageRoute;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(enableFeedback: false),
      onPressed: () {
        Navigator.pushNamed(
          context,
          pageRoute,
        );
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              icon,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
