// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación multilingüe';

  @override
  String get homeTitle => 'Hola';

  @override
  String get welcome => '¡Bienvenido a nuestra aplicación!';

  @override
  String greetUser(String username) {
    return '¡Bienvenido, $username!';
  }

  @override
  String cartItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tienes $count artículos',
      one: 'Tienes 1 artículo',
      zero: 'Tu carrito está vacío',
    );
    return '$_temp0';
  }

  @override
  String todayIs(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Hoy es $dateString';
  }

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get resetLanguage => 'Predeterminado del sistema';

  @override
  String get rtlHint => 'Prueba árabe para ver la orientación RTL';
}
