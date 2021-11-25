import 'package:flutter/material.dart';
import 'package:plg_portfolio/models/custom_enums.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  static const String _contactCardURL =
      'https://drive.google.com/file/d/1n1SDtqUshRtOuDdikA6Zx1LUAAj1sAK3/view';

  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final control = Provider.of<ControlModel>(context);

    return SizedBox(
        height: control.windowHeight - 60,
        width: control.windowWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomWidgets().pageTitle(context, Strings.contactPageTitle),
            Expanded(
              child:
                  _contactSection(context, Icons.phone, Strings.phoneNumber, [
                _contact(context, Strings.usNumberLabel, ContactType.phone,
                    Strings.usNumber),
                _contact(context, Strings.bzNumberLabel, ContactType.phone,
                    Strings.bzNumber)
              ]),
            ),
            Expanded(
              child: _contactSection(context, Icons.mail, Strings.email, [
                _contact(context, Strings.personal1Label, ContactType.email,
                    Strings.personal1),
                _contact(context, Strings.personal2Label, ContactType.email,
                    Strings.personal2),
              ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: OutlinedButton(
                onPressed: () async {
                  if (await canLaunch(_contactCardURL)) {
                    await launch(_contactCardURL);
                  } else {
                    throw "Could not launch $_contactCardURL";
                  }
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
                        Strings.downloadContactCard,
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _contactSection(
      BuildContext context, IconData icon, String title, List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, bottom: 10.0, top: 10.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              const Divider(
                color: Colors.white30,
              ),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: widgets,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white54),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _contact(BuildContext context, String label, ContactType contactType,
      String details) {
    String url = '';
    if (contactType == ContactType.phone) {
      url = 'tel:$details';
    } else if (contactType == ContactType.email) {
      url = 'mailto:$details';
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: OutlinedButton(
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw "Could not launch $url";
          }
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.0, color: Colors.white54),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$label $details',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );
  }
}
