import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';

class ConfigurationDrawer extends StatelessWidget {
  const ConfigurationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.7,
      ),
      color: kColorScheme.background,
    );
  }
}
