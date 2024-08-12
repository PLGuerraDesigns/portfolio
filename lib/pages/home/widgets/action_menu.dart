import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/strings.dart';
import '../../../common/urls.dart';
import '../../../services/redirect_handler.dart';
import '../../../widgets/frosted_container.dart';
import 'app_version.dart';
import 'frosted_action_button.dart';

/// A menu that provides various action buttons.
class ActionMenu extends StatelessWidget {
  const ActionMenu({
    super.key,
    required this.compact,
  });

  /// Whether the menu should be compact.
  final bool compact;

  /// The icon for the action button.
  Widget _action({
    required BuildContext context,
    required String title,
    required IconData iconData,
    required Function() onTap,
  }) {
    return FrostedActionButton(
      icon: Icon(
        iconData,
        size: 46,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: title,
      onTap: () {
        // Close drawer if in compact mode
        if (compact) {
          Navigator.of(context).pop();
        }
        onTap();
      },
    );
  }

  /// Shows a dialog prompting the user to confirm
  /// how they would like to proceed.
  Future<void> _contactMeConfirmationDialog({
    required BuildContext context,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Strings.contactMe),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(Strings.contactMeMessage),
              Tooltip(
                message: Strings.copyToClipboard,
                child: TextButton(
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: Strings.contactEmail));
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(Strings.emailCopied),
                      ),
                    );
                  },
                  child: const Text(
                    Strings.contactEmail,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                RedirectHandler.openUrl(Urls.openEmail);
              },
              child: Text(Strings.openEmailApp.toUpperCase()),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Strings.close.toUpperCase()),
            ),
          ],
        );
      },
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
                _action(
                  context: context,
                  title: Strings.about,
                  iconData: Icons.help,
                  onTap: () => RedirectHandler.openUrl(Urls.projectReadme),
                ),
                _action(
                  context: context,
                  iconData: Icons.quick_contacts_mail_rounded,
                  title: Strings.contactMe,
                  onTap: () => _contactMeConfirmationDialog(context: context),
                ),
                _action(
                  context: context,
                  iconData: Icons.code,
                  title: Strings.viewSourceCode,
                  onTap: () => RedirectHandler.openUrl(Urls.projectSourceCode),
                ),
                _action(
                  context: context,
                  iconData: Icons.bug_report_rounded,
                  title: Strings.reportAnIssue,
                  onTap: () => RedirectHandler.openUrl(Urls.projectIssues),
                ),
              ],
            ),
          ),
          Align(
            alignment: compact ? Alignment.bottomCenter : Alignment.bottomRight,
            child: const AppVersion(),
          ),
        ],
      ),
    );
  }
}
