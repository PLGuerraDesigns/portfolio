import 'package:flutter/material.dart';
import 'package:plg_portfolio/models/custom_enums.dart';
import 'package:plg_portfolio/constants/strings.dart';
import 'package:plg_portfolio/view_models/control_model.dart';
import 'package:plg_portfolio/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  static const String _contactCardURL =
      'https://mega.nz/file/N04lQA6K#_fH4QUJatExJJBouIs4EIw3dy9fKIMad9n6gaPRdh8Y';

  ContactPage({Key? key}) : super(key: key);
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
                context, Strings.contactPageTitle, control.mobileScreenSize),
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
              padding: EdgeInsets.symmetric(
                  horizontal: control.mobileScreenSize ? 20 : 40.0,
                  vertical: 10),
              child: OutlinedButton(
                onPressed: () {
                  launch(_contactCardURL);
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
      padding: EdgeInsets.only(
          left: control.mobileScreenSize ? 20 : 40.0,
          right: control.mobileScreenSize ? 20 : 40.0,
          bottom: 10.0,
          top: 10.0),
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
                    style: control.mobileScreenSize
                        ? Theme.of(context).textTheme.headline6
                        : Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              const Divider(
                color: Colors.white38,
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
      padding: EdgeInsets.symmetric(
          vertical: 10.0, horizontal: control.mobileScreenSize ? 4.0 : 10.0),
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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Text(
            '$label $details',
            style: control.mobileScreenSize
                ? Theme.of(context).textTheme.bodyText2
                : Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
