import 'package:flutter/material.dart';

/// A generic app bar used throughout the app.
class GenericAppBar {
  GenericAppBar._();

  static PreferredSizeWidget build({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
  }) {
    return AppBar(
      title: Text(title),
      titleSpacing: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }
}
