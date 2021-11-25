import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  static const String _belizeFlag = 'images/about_page/belize_flag.png';
  static const String _uOfALogo = 'images/about_page/ua_logo.png';
  static const String _ambLogo = 'images/about_page/amb_logo.png';
  static const String _flutterLogo = 'images/about_page/flutter_logo.png';
  static const String _selfPortrait = 'images/about_page/self_portrait.png';
  static const String _selfPortraitHorizontal =
      'images/about_page/self_portrait_horizontal.png';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomWidgets().pageTitle(context, Strings.aboutPageTitle),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: control.mobileScreenSize
                      ? Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1 / 0.67,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  _selfPortraitHorizontal,
                                  fit: BoxFit.cover,
                                  width: control.windowWidth < 700
                                      ? control.windowWidth
                                      : 700,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _bulletedText(context, _belizeFlag,
                                Strings.descriptionLine1, true),
                            _bulletedText(context, _uOfALogo,
                                Strings.descriptionLine2, true),
                            _bulletedText(context, _ambLogo,
                                Strings.descriptionLine3, true),
                            _bulletedText(context, _flutterLogo,
                                Strings.descriptionLine4, true),
                          ],
                        )
                      : Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                _selfPortrait,
                                height: control.windowHeight - 200,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _bulletedText(context, _belizeFlag,
                                        Strings.descriptionLine1, false),
                                    _bulletedText(context, _uOfALogo,
                                        Strings.descriptionLine2, false),
                                    _bulletedText(context, _ambLogo,
                                        Strings.descriptionLine3, false),
                                    _bulletedText(context, _flutterLogo,
                                        Strings.descriptionLine4, false),
                                  ],
                                )),
                          ],
                        ))
            ],
          ),
        ));
  }

  Widget _bulletedText(BuildContext context, String imagePath, String text,
      bool mobileScreenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: mobileScreenSize ? 50 : 75,
            width: mobileScreenSize ? 75 : 100,
          ),
          const SizedBox(
            width: 25,
          ),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white60),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
