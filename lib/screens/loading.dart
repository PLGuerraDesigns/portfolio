import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/strings.dart';

/// A screen that displays a loading indicator while loading data.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.fromRoute,
    required this.nextRoute,
    required this.loadFunction,
  });

  final String fromRoute;

  /// The route to navigate to after loading.
  final String nextRoute;

  /// The function to load data.
  final Future<void> Function(BuildContext context) loadFunction;

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  /// Loads the data and navigates to the next route when done.
  Future<void> _loadDataAndNavigate() async {
    await widget.loadFunction(context);
    if (context.mounted) {
      context.go(
          '${Strings.homeRoute}/${widget.fromRoute}/${Strings.detailsSubRoute}/${widget.nextRoute}');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
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
