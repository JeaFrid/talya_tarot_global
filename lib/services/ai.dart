import 'dart:io';

import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tarot/constant/api_key.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/controller/scrollcontroller.dart';
import 'package:tarot/controller/textediting.dart';
import 'package:tarot/controller/value.dart';
import 'package:tarot/widget/message.dart';
import 'package:tarot/widget/textbox.dart';

class Ai extends ChangeNotifier {
  static Future<String> getAIResponse(String prompt) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: geminiApiKey,
        systemInstruction: Content.system("""
Sen bir tarot yapay zekasısın.
Sana verilen verilere bakarak sadece yorum yapacaksın.
Kullanıcıyı adıyla selamlayarak cümleye başla.
Yorumlamayı detaylandır, genişlet ve ince detaylara odaklan. Sorulara yanıt vermeye odaklan.
Başka bir konuya girme, sadece yorum yap.
Bir falcı edasıyla yorumla ve samimi ol.
Senin adın Talya ve bunu söyleyerek cümleye başla.
Markdown yapısını kullanma.
Eğer sana gönderilen isim, yaş veya niyet gibi veriler, random veya anlamsız veriler ise nazikçe uyar ve tarot yorumu yapmayı reddet. Örnek: Random bir isim veya 1000 gibi absürt bir yaş.

Kullanıcı Bilgileri;

Kişisin adını: ${name.text}
Kişinin yaşı: ${old.text}
Niyet: ${niyet.text}

"""),
      );
      final content = [
        Content.text("""
Senden tarot bakmanı istiyorum. 3 kartlık bir açılım olacak. Sana kartları vereceğim. O kartların ne anlama geldiğini yorumlaman gerekiyor.
Kartlar: $prompt
"""),
      ];
      final response = await model.generateContent(content);

      return response.text ?? "";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getAIResponseBurc(String burc) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: geminiApiKey,
        systemInstruction: Content.system("""
Sen bir burç yorumu yapan falcısın.
Fal bakarken, maksimum 3 satırlık ya da 100 kelimelik fal bakacaksın. Daha da uzatma.
Burç yorumunu, bugünün tarihine göre yap: ${CosmosTime.getDateTR(CosmosTime.getDateTime(CosmosTime.getNowTimeString()))}
Kullanıcının yaşına göre fal bak. Eğer kullanıcın yaşı küçükse, daha masum bir fal olsun.
Her zaman Türkçe olarak fal bak.
Sana kullanıcının tüm bilgilerini veriyorum.
Kullanıcıya adıyla hitap et.

Kullanıcı Bilgileri;
Kişisin adını: ${name.text}
Kişinin yaşı: ${old.text}
Burç: $burc

"""),
      );
      final content = [
        Content.text("""
Senden burç yorumu yapmanı istiyorum. Kısa bir yorum olsun.
"""),
      ];
      final response = await model.generateContent(content);

      return response.text ?? "";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getAIResponseChat(String prompt) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: geminiApiKey,
        systemInstruction: Content.system("""
Sen bir tarot yapay zekasısın.
Sana verilen verilere bakarak sadece yorum yapacaksın.
Kullanıcı sana mesajlarla sorular soracak ve sen sana verilen tarot kartlarına bakarak soruyu yanıtlayacaksın.
Başka bir konuya girme, sadece yorum yap.
Bir falcı edasıyla yorumla ve samimi ol.
Senin adın Talya.
Markdown yapısını kullanabilirsin.
Eğer sana gönderilen isim, yaş veya niyet gibi veriler, random veya anlamsız veriler ise nazikçe uyar ve tarot yorumu yapmayı reddet. Örnek: Random bir isim veya 1000 gibi absürt bir yaş.
Eğer sana "Selam, merhaba" gibi kartlara gerek olmayan bir şey yazarsa, kartlara bakmadan kendin olarak yanıt ver.
Tüm soruları basit bir dil ile yanıtla ve unutma ki mesaj yazıyorsun. Bu durumda uzun uzun yazarsan kullanıcı sıkılır.
Kullanıcının EVET-HAYIR tarzı sorularına kartlara bakarak evet veya hayır cevabını vereceksin. Olumlu veya olumsuz durumlara göre evet veya hayır de.
Selam veya merhaba türevi, bir soru veya yanıt içermeyen mesajlara cevap verirken, sana verilen kartları boş ver ve sadece kendin olarak yanıtla. Böyle bir durumda Kartları yorumlama.
Kullanıcı Bilgileri;

Kişisin adını: ${name.text}
Kişinin yaşı: ${old.text}
Niyet: ${niyet.text}

"""),
      );

      final content = [
        Content.text("""
Senden tarot bakmanı istiyorum. 3 kartlık bir açılım olacak. Sana kartları vereceğim. O kartların ne anlama geldiğini yorumlaman gerekiyor.
Kartlar: $prompt
"""),
      ];
      final response = await model.generateContent(content);

      return response.text ?? "";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> getAIResponseYorum(String prompt, File photo) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: geminiApiKey,
        systemInstruction: Content.system("""
Sen bir falcısın. Senin adın Talya. Kendi mobil uygulaman üzerinde hizmet veriyorsun. Uygulamanın adı Talya.
Sana insanlar sorular soracaklar. Sen fotoğrafları yorumluyorsun. Kahve falı, yüz falı veya el falı gibi fallar bakıyorsun.
Başka bir konuya girme, sadece yorum yap.
Bir falcı edasıyla yorumla ve samimi ol.
Tüm soruları basit bir dil ile yanıtla ve unutma ki mesaj yazıyorsun. Bu durumda uzun uzun yazarsan kullanıcı sıkılır.
Markdown yapısını kullanma.
Sana gönderilen fotoğraf ile fal isteği uyuşmuyorsa yani senden el falı istendiğinde fotoğrafta el yoksa yorumlamayı reddet. Yorum yapma.


Kişisin adını: ${name.text}
Kişinin yaşı: ${old.text}


"""),
      );

      final imageBytes = await photo.readAsBytes();
      final imagePart = DataPart('image/jpeg', imageBytes);

      final content = [
        Content.multi([TextPart(prompt), imagePart])
      ];
      final response = await model.generateContent(content);

      return response.text ?? "";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> sendMessage(double width, String texts) async {
    readOnly.value = true;
    String text = messageController.text;
    messageController.clear();
    messageList.value.add(
      MessageBox(
        width: width,
        isRaya: false,
        message: text,
        timestamp: CosmosTime.getDateTR(
          DateTime.now(),
        ),
      ),
    );
    messageList.notifyListeners();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 500,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    String response = await getAIResponseChat(texts);
    messageList.value.add(
      MessageBox(
        width: width,
        isRaya: true,
        message: response,
        timestamp: CosmosTime.getDateTR(
          DateTime.now(),
        ),
      ),
    );
    messageList.notifyListeners();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 500,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    readOnly.value = false;
    // focusNode.nextFocus();
  }
}
