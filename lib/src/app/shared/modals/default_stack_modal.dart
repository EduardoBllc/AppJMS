import 'package:app_jms/constants.dart';
import 'package:flutter/material.dart';

class DefaultStackModal extends StatelessWidget {
  const DefaultStackModal({
    super.key,
    required this.bodyWidget,
    required this.maxHeight,
    this.backgroundColor,
  });

  final Widget bodyWidget;
  final double maxHeight;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: 10,
        maxHeight: maxHeight,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? kColorScheme.onBackground,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 5,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: bodyWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
