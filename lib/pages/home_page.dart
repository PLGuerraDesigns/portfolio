import 'package:flutter/material.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  static const String _backgroundImage = 'images/home_page/background.png';
  static const String _profilePicture = 'images/home_page/profile_picture.png';

  static const String _gitHubIcon = 'images/home_page/gitHub_icon.png';
  static const String _linkedInIcon = 'images/home_page/linkedIn_icon.png';
  static const String _thingiverseIcon =
      'images/home_page/thingiverse_icon.png';

  static const String _gitHubURL = 'https://github.com/PLGuerraDesigns';
  static const String _linkedInURL = 'https://www.linkedin.com/in/plguerra/';
  static const String _thingiverseURL =
      'https://www.thingiverse.com/plg_designs/designs';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
      height: control.windowHeight - 60,
      width: control.windowWidth,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              _backgroundImage,
              height: control.windowHeight,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: control.mobileScreenSize ? 80 : 100,
                backgroundImage: const AssetImage(_profilePicture),
              ),
              const SizedBox(height: 25),
              Text(
                Strings.name,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _externalPages(
                      context, Strings.gitHub, _gitHubIcon, _gitHubURL),
                  _externalPages(
                      context, Strings.linkedIn, _linkedInIcon, _linkedInURL),
                  _externalPages(context, Strings.thingiverse, _thingiverseIcon,
                      _thingiverseURL)
                ],
              ),
            ],
          ),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.expand_more,
                  color: Colors.white24,
                ),
              ))
        ],
      ),
    );
  }

  Widget _externalPages(
      BuildContext context, String title, String filepath, String url) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw "Could not launch $url";
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              filepath,
              height: 25,
              color: Colors.white54,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context).textTheme.button,
            )
          ],
        ),
      ),
    );
  }
}
