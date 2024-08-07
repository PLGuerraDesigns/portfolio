import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/routing/routes.dart';
import '../common/strings.dart';

/// The error screen.
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.uhOh,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              Strings.looksLikeSomethingWentWrong,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                context.go(Routes.home);
              },
              child: Text(
                Strings.goToTheHomePage.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
