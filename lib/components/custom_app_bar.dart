import 'package:flutter/material.dart';

class CustomAppBar {
  static build(
    BuildContext context,
    String title, {
    centerTitle = true,
    automaticallyImplyLeading = false,
  }) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 5.0,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
