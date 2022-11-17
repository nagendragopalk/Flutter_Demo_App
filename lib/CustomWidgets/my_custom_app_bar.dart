import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final List<Widget>? actionsWidget;

  const MyCustomAppBar({
    Key? key,
    required this.height,
    this.actionsWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          shadowColor: Colors.grey[500],
          actions: actionsWidget,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
