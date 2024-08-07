import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';
import 'action_menu.dart';
import 'powered_by_flutter_button.dart';
import 'social_media_buttons.dart';

/// A drawer that provides various action buttons.
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () =>
                          RedirectHandler.openUrl(Urls.projectSourceCode),
                      icon: const Icon(Icons.code),
                      tooltip: Strings.viewSourceCode,
                    ),
                    const SocialMediaButtons(),
                  ],
                ),
                const PoweredByFlutterButton(),
                Text(
                  Strings.lastUpdated,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
                      ),
                ),
              ],
            ),
          ),
          const Flexible(
            child: ActionMenu(compact: true),
          ),
        ],
      ),
    );
  }
}
