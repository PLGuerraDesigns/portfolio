import 'package:flutter/material.dart';

import '../common/strings.dart';
import '../services/redirect_handler.dart';
import 'theme_mode_button.dart';

/// A collection of custom app bars.
class CustomAppBars {
  CustomAppBars._();

  /// The default actions to display in all app bars.
  static List<Widget> _defaultActions(BuildContext context) {
    return <Widget>[
      const ThemeModeButton(),
    ];
  }

  /// The app bar to display on the home page.
  static PreferredSizeWidget homeAppBar(
      {required BuildContext context,
      required Widget poweredByFlutterButton,
      required String lastUpdated,
      bool compact = false}) {
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
        IconButton(
          onPressed: () => RedirectHandler.openUrl(Strings.sourceCodeUrl),
          icon: const Icon(Icons.code),
          tooltip: Strings.sourceCode,
        ),
        ..._defaultActions(context)
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
      title: actions == null ? Text(title) : null,
      centerTitle: false,
      actions: <Widget>[...?actions, ..._defaultActions(context)],
    );
  }
}
