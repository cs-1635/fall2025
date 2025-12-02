import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Level Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const BatteryPage(),
    );
  }
}

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  int? _batteryLevel;
  String? _error;
  bool _loading = false;

  // Channel name must match the Kotlin side
  static const _batteryChannel =
      MethodChannel('com.example.battery/methods');

  Future<void> _getBatteryLevel() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // The generic <int> tells Dart to expect an int from native.
      final level = await _batteryChannel.invokeMethod<int>('getBatteryLevel');

      if (!mounted) return;

      setState(() {
        _batteryLevel = level;
        if (level == null || level < 0) {
          _error = 'Battery level not available.';
        }
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        _batteryLevel = null;
        _error = 'Failed to get battery level: ${e.code} – ${e.message}';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _batteryLevel = null;
        _error = 'Unexpected error: $e';
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Optionally fetch immediately:
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Level (Platform Channel)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_loading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text('Fetching battery level...'),
              ] else if (_error != null) ...[
                Icon(Icons.error_outline,
                    size: 48, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ] else if (_batteryLevel != null) ...[
                const Icon(Icons.battery_full, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Battery level:',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '$_batteryLevel%',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else ...[
                const Icon(Icons.help_outline, size: 48),
                const SizedBox(height: 16),
                const Text('Battery level not loaded yet.'),
              ],
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _loading ? null : _getBatteryLevel,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
