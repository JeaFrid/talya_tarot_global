import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getPublicIP() async {
  try {
    final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['ip']; 
    } else {
      print('IP adresi alınamadı. Status Code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('IP adresi alınırken hata oluştu: $e');
    return null;
  }
}
