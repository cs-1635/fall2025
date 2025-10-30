import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../localization/locale_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartCount = 0;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale ?? Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.appTitle),
        actions: [
          PopupMenuButton<String>(
            tooltip: local.chooseLanguage,
            onSelected: (code) {
              if (code == 'system') {
                localeProvider.clearLocale();
              } else {
                localeProvider.setLocale(Locale(code));
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'system', child: Text(local.resetLanguage)),
              const PopupMenuDivider(),
              ...[
                const Locale('en'),
                const Locale('es'),
                const Locale('ar'),
              ].map((loc) => PopupMenuItem(
                    value: loc.languageCode,
                    child: Text({
                      'en': 'English',
                      'es': 'Español',
                      'ar': 'العربية',
                    }[loc.languageCode]!),
                  )),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.homeTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              local.welcome,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              local.greetUser('Jake'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              local.todayIs(DateTime.now()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              local.cartItems(_cartCount),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _cartCount = 0),
                  child: const Text('0'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _cartCount = 1),
                  child: const Text('1'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _cartCount += 1),
                  child: const Text('+1'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(local.rtlHint),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Locale: ${currentLocale.languageCode}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}