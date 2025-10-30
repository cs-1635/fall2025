// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق متعدد اللغات';

  @override
  String get homeTitle => 'مرحبًا';

  @override
  String get welcome => 'مرحبًا بك في تطبيقنا!';

  @override
  String greetUser(String username) {
    return 'مرحبًا، $username!';
  }

  @override
  String cartItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لديك $count عناصر',
      one: 'لديك عنصر واحد',
      zero: 'سلة التسوق فارغة',
    );
    return '$_temp0';
  }

  @override
  String todayIs(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'اليوم $dateString';
  }

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get resetLanguage => 'إعداد النظام';

  @override
  String get rtlHint => 'جرّب العربية لترى الاتجاه من اليمين إلى اليسار';
}
