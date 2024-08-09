import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import 'powered_by_flutter_button.dart';
import 'theme_mode_button.dart';

/// The app bar for the home page.
class HomeAppBar {
  HomeAppBar._();

  /// The app bar for the home page.
  static PreferredSizeWidget build({
    required BuildContext context,
    required bool compact,
  }) {
    return AppBar(
      title: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(Strings.appName),
          ),
          if (!compact) const PoweredByFlutterButton(),
        ],
      ),
      scrolledUnderElevation: 0,
      centerTitle: false,
      actions: <Widget>[
        if (!compact)
          Text(
            Strings.lastUpdated,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        const ThemeModeButton(),
      ],
    );
  }
}
