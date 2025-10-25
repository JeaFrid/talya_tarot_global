import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tarot/firebase_options.dart';
import 'package:tarot/page/loading.dart';
import 'package:tarot/theme/color.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('tr', null);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: bgColor,
    statusBarIconBrightness: Brightness.light,
  ));
  if (!kIsWeb) {
    final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'];
    if (oneSignalAppId == null || oneSignalAppId.isEmpty) {
      throw StateError(
        'ONESIGNAL_APP_ID is not set. Please provide it in your .env file.',
      );
    }
    OneSignal.initialize(oneSignalAppId);
  }
  runApp(const Tarot());
}

class Tarot extends StatelessWidget {
  const Tarot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Talya',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    );
  }
}
