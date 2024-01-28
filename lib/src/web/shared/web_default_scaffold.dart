import 'package:flutter/material.dart';
import '../../../services/firebase_services/authentication_services.dart';
import 'scaffold_components/navigation_drawer.dart';

class WebScaffold extends StatelessWidget {
  const WebScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.endDrawer,
    this.scaffoldKey,
  });

  final Key? scaffoldKey;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: body,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
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
