import 'package:app_jms/services/controllers/customers_caretaker.dart';
import 'package:app_jms/services/controllers/showcase_manager.dart';
import 'package:app_jms/services/firebase_services/authentication_services.dart';
import 'package:app_jms/src/shared/components/loading_widget.dart';
import 'package:provider/provider.dart';
import '../shared/scaffold_components/navigation_drawer.dart';
import 'package:flutter/material.dart';

class WebMenuPage extends StatefulWidget {
  const WebMenuPage({super.key});

  static const String id = '/menu';

  @override
  State<WebMenuPage> createState() => _WebMenuPageState();
}

class _WebMenuPageState extends State<WebMenuPage> {
  bool _isLoading = true;

  void fetchData() async {
    Provider.of<ShowcaseManager>(context, listen: false).getProducts();
    Provider.of<CustomersCaretaker>(context, listen: false).getCustomers();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(child: CircularLoading()),
          )
        : Scaffold(
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
