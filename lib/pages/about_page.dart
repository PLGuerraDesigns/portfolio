import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  static const String _belizeFlag = 'assets/images/about_page/belize_flag.png';
  static const String _uOfALogo = 'assets/images/about_page/ua_logo.png';
  static const String _ambLogo = 'assets/images/about_page/amb_logo.png';
  static const String _flutterLogo =
      'assets/images/about_page/flutter_logo.png';
  static const String _selfPortrait =
      'assets/images/about_page/self_portrait.png';
  static const String _selfPortraitHorizontal =
      'assets/images/about_page/self_portrait_horizontal.png';

  AboutPage({Key? key}) : super(key: key);
  late ControlModel control;

  @override
  Widget build(BuildContext context) {
    control = Provider.of<ControlModel>(context);
    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomWidgets().pageTitle(
                context, Strings.aboutPageTitle, control.mobileScreenSize),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: control.mobileScreenSize
                    ? Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                _selfPortraitHorizontal,
                                fit: BoxFit.cover,
                                width: control.windowWidth < 700
                                    ? control.windowWidth
                                    : 700,
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _bulletedText(
                              context, _belizeFlag, Strings.descriptionLine1),
                          _bulletedText(
                              context, _uOfALogo, Strings.descriptionLine2),
                          _bulletedText(
                              context, _ambLogo, Strings.descriptionLine3),
                          _bulletedText(
                              context, _flutterLogo, Strings.descriptionLine4),
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
                                      Strings.descriptionLine1),
                                  _bulletedText(context, _uOfALogo,
                                      Strings.descriptionLine2),
                                  _bulletedText(context, _ambLogo,
                                      Strings.descriptionLine3),
                                  _bulletedText(context, _flutterLogo,
                                      Strings.descriptionLine4),
                                ],
                              )),
                        ],
                      ))
          ],
        ));
  }

  Widget _bulletedText(BuildContext context, String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: control.mobileScreenSize ? 50 : 75,
            width: control.mobileScreenSize ? 75 : 100,
          ),
          const SizedBox(
            width: 18,
          ),
          Flexible(
            child: Text(
              text,
              style: control.mobileScreenSize
                  ? Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white60)
                  : Theme.of(context).textTheme.headline6,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
