import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/globals.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: Column(
          children: [
            CustomWidgets().pageTitle(
                context, Strings.resumePageTitle, control.mobileScreenSize),
            Expanded(child: _downloadButton(context, control))
          ],
        ));
  }

  Widget _downloadButton(BuildContext context, ControlModel control) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: control.mobileScreenSize ? 20 : 200.0,
        ),
        child: OutlinedButton(
          onPressed: () {
            control.unavailableSnackBar();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1.0, color: Colors.white54),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'DOWNLOAD RESUME',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
