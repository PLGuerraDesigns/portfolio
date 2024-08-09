import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';

/// A [TextButton] widget that displays the app version and redirects to the
/// github changelog readme file when clicked.
class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  /// Load the app version information.
  Future<String> _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version} (${packageInfo.buildNumber})';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TextButton(
            onPressed: () => RedirectHandler.openUrl(Urls.changelog),
            child: Text(
              snapshot.data!,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
