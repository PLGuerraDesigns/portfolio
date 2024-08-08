import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/routing/routes.dart';

/// A screen that displays a loading indicator while loading data.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.from,
    required this.to,
    required this.loadFunction,
  });

  final String from;

  /// The route to navigate to after loading.
  final String to;

  /// The function to load data.
  final Future<void> Function(BuildContext context) loadFunction;

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  /// Loads the data and then redirects to the next screen.
  Future<void> _loadThenRedirect() async {
    await widget.loadFunction(context);
    if (context.mounted) {
      context.go(
        Routes.loadingRedirect(
          from: widget.from,
          to: widget.to,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadThenRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
