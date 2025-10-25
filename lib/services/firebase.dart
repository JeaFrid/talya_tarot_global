import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInAnonymously() async {
  try {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    throw Exception('Anonim giriş sırasında hata oluştu: ${e.message}');
  } catch (e) {
    throw Exception('Bilinmeyen bir hata oluştu: $e');
  }
}
