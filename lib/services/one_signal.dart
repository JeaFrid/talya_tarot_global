import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Belirli bir kullanıcıya OneSignal bildirim gönderir.
///
/// [playerId] : Hedef kullanıcının OneSignal Player ID'si.
/// [title]    : Bildirimin başlığı.
/// [message]  : Bildirimin içeriği.
Future<void> sendNotificationToUser({
  required String playerId,
  required String title,
  required String message,
}) async {
  final String? oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'];
  final String? restApiKey = dotenv.env['ONESIGNAL_REST_API_KEY'];

  if (oneSignalAppId == null ||
      oneSignalAppId.isEmpty ||
      restApiKey == null ||
      restApiKey.isEmpty) {
    throw StateError(
      'OneSignal credentials are missing. Please set ONESIGNAL_APP_ID and '
      'ONESIGNAL_REST_API_KEY in your .env file.',
    );
  }

  final Uri url = Uri.parse('https://onesignal.com/api/v1/notifications');

  // Bildirim gönderimi için payload (veri) oluşturuluyor.
  final Map<String, dynamic> payload = {
    'app_id': oneSignalAppId,
    'include_player_ids': [playerId], // Sadece bu kullanıcıya gönder.
    'headings': {'en': title},
    'contents': {'en': message},
    // İsterseniz diğer parametreleri de ekleyebilirsiniz.
  };

  try {
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic $restApiKey',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      print('Bildirim başarıyla gönderildi.');
    } else {
      print('Bildirim gönderilemedi. Hata: ${response.body}');
    }
  } catch (e) {
    print('Bildirim gönderilirken hata oluştu: $e');
  }
}
