import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';
import '../../../widgets/frosted_container.dart';
import 'custom_icon_button.dart';

/// A menu that provides various action buttons.
class ActionMenu extends StatelessWidget {
  const ActionMenu({
    super.key,
    required this.compact,
    required this.versionNumber,
  });

  /// Whether the menu should be compact.
  final bool compact;

  /// The app version number.
  final String versionNumber;

  Widget _icon({
    required BuildContext context,
    required IconData iconData,
  }) {
    return Icon(
      iconData,
      size: 46,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      borderRadiusAmount: compact ? 0 : 16.0,
      child: Stack(
        children: <Widget>[
          GridView.custom(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: compact ? 2 : 4,
              childAspectRatio: 0.9,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            childrenDelegate: SliverChildListDelegate(
              <Widget>[
                FrostedActionButton(
                  icon: _icon(
                    context: context,
                    iconData: Icons.quick_contacts_mail_rounded,
                  ),
                  title: Strings.contactMe,
                  onTap: () => RedirectHandler.openUrl(Urls.contactEmail),
                ),
                FrostedActionButton(
                  icon: _icon(
                    context: context,
                    iconData: Icons.bug_report_rounded,
                  ),
                  title: Strings.reportAnIssue,
                  onTap: () => RedirectHandler.openUrl(Urls.projectIssues),
                ),
              ],
            ),
          ),
          Align(
            alignment: compact ? Alignment.bottomCenter : Alignment.bottomRight,
            child: Text(
              versionNumber,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
