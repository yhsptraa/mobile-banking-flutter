import 'package:flutter/material.dart';

// Keep the button at the bottom, while allowing forms to scroll above a keyboard.
class ScrollableForm extends StatelessWidget {
  const ScrollableForm({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(child: child),
      ),
    ),
  );
}
