import 'package:url_launcher/url_launcher.dart';

/// Handles redirecting to external URLs.
class RedirectHandler {
  RedirectHandler._();

  /// Opens the given [urlString] in the default browser.
  static Future<void> openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
