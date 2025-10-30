// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Multilingual App';

  @override
  String get homeTitle => 'Hello';

  @override
  String get welcome => 'Welcome to our app!';

  @override
  String greetUser(String username) {
    return 'Welcome, $username!';
  }

  @override
  String cartItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You have $count items',
      one: 'You have 1 item',
      zero: 'Your cart is empty',
    );
    return '$_temp0';
  }

  @override
  String todayIs(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Today is $dateString';
  }

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get resetLanguage => 'System default';

  @override
  String get rtlHint => 'Try Arabic to see RTL layout';
}
