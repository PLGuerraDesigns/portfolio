import 'package:flutter/material.dart';

import '../common/strings.dart';
import '../services/redirect_handler.dart';
import 'theme_mode_button.dart';

/// A collection of custom app bars.
class CustomAppBars {
  CustomAppBars._();

  /// The app bar to display on the home page.
  static PreferredSizeWidget homeAppBar({
    required BuildContext context,
    required Widget poweredByFlutterButton,
    required String lastUpdated,
    bool compact = false,
  }) {
    return AppBar(
      title: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(Strings.appName),
          ),
          if (!compact) poweredByFlutterButton,
        ],
      ),
      scrolledUnderElevation: 0,
      centerTitle: false,
      actions: <Widget>[
        if (!compact)
          Text(
            lastUpdated,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        const SizedBox(width: 12),
        if (!compact)
          IconButton(
            onPressed: () => RedirectHandler.openUrl(Strings.sourceCodeUrl),
            icon: const Icon(Icons.code),
            tooltip: Strings.viewSourceCode,
          ),
        const ThemeModeButton(),
      ],
    );
  }

  /// A generic app bar used throughout the app.
  static PreferredSizeWidget genericAppBar({
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
