import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/asset_paths.dart';
import '../common/theming/color_schemes.dart';

/// A widget that displays a loading spinner.
class Spinner extends StatelessWidget {
  const Spinner({
    super.key,
    this.scale = 1.0,
  });

  /// The scale of the spinner.
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 37,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AssetPaths.monogram,
                ),
              ),
            ),
            SpinKitWaveSpinner(
              color: PortfolioColorSchemes.dark.tertiaryContainer
                  .withOpacity(0.75),
              trackColor:
                  PortfolioColorSchemes.dark.outlineVariant.withOpacity(0.15),
              waveColor:
                  PortfolioColorSchemes.dark.tertiaryContainer.withOpacity(0.3),
              duration: const Duration(milliseconds: 2500),
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
