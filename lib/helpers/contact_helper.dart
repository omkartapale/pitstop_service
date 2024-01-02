import 'package:url_launcher/url_launcher.dart';

/// A contact helper class with utility functions
///
/// Provides helper functions:
/// * [makePhoneCall]
/// * [launchMap]
///
abstract class ContactHelper {
  /// Make a phone call to a provided phoneNumber.
  ///
  /// Opens a default dialer if set or asks to choose app to open number with.
  /// Passes [phoneNumber] to launch app with.
  /// Uses `tel` scheme to [launchUrl].
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      launchUrl(launchUri);
    } else {
      throw 'Calling not supported on this device\nCould not launch $launchUri';
    }
  }

  /// Launch Google Map for a garage location.
  ///
  /// Opens Google Map app if set default or else asks to choose browser app
  /// to open URL with.
  ///
  /// Uses `https` scheme to [launchUrl].
  static Future<void> launchMap() async {
    final map = Uri.parse('https://maps.app.goo.gl/476usahhoGYFtZ32A');

    if (await canLaunchUrl(map)) {
      launchUrl(map);
    } else {
      throw 'Could not launch $map';
    }
  }
}
