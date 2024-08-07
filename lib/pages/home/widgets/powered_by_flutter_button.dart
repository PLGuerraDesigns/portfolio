import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';

/// A button that redirects to the Flutter website.
class PoweredByFlutterButton extends StatelessWidget {
  const PoweredByFlutterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => RedirectHandler.openUrl(Urls.flutter),
      child: Text(
        Strings.poweredByFlutter.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
      ),
    );
  }
}
