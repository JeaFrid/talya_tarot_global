import 'dart:io';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarot/controller/controller.dart';
import 'package:tarot/controller/value.dart';
import 'package:tarot/page/community.dart';
import 'package:tarot/page/fal_etap_1.dart';
import 'package:tarot/page/fal_etap_2.dart';
import 'package:tarot/page/fal_etap_4.dart';
import 'package:tarot/page/photo_yorum.dart';
import 'package:tarot/page/sana_ozel.dart';
import 'package:tarot/services/ai.dart';
import 'package:tarot/services/camera.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/card_single.dart';

ValueNotifier<List<Widget>> list = ValueNotifier([]);
getYorumlar() async {
  list.value.clear();

  SharedPreferences db = await SharedPreferences.getInstance();
  if (db.getString("user_name") != null && db.getString("user_old") != null) {
    name.text = db.getString("user_name") ?? "";
    old.text = db.getString("user_old") ?? "";
  }

  List keys = db.getKeys().toList();
  for (var element in keys) {
    if (element != "user_name" &&
        element != "user_old" &&
        element != "selected_zodiac") {
      list.value.add(
        YorumKalem(
          comment: db.getStringList(element)![9],
          keys: element,
          list: [
            {
              "name": db.getStringList(element)![0],
              "img": db.getStringList(element)![1],
            },
            {"value": db.getStringList(element)![2]},
            {
              "name": db.getStringList(element)![3],
              "img": db.getStringList(element)![4],
            },
            {"value": db.getStringList(element)![5]},
            {
              "name": db.getStringList(element)![6],
              "img": db.getStringList(element)![7],
            },
            {"value": db.getStringList(element)![8]},
          ],
          name: db.getStringList(element)![10],
          niyet: db.getStringList(element)![12],
          timestamp: CosmosTime.getDateTR(CosmosTime.getDateTime(
            db.getStringList(element)![13],
          )),
        ),
      );
    }
  }
  list.value.reversed.toList();
  list.notifyListeners();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<IconData> iconPath = ValueNotifier(Icons.arrow_drop_down_sharp);
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1),
      () async {
        await getYorumlar();
        SharedPreferences db = await SharedPreferences.getInstance();
        String selectedZodiac = db.getString("selected_zodiac") ?? "İkizler";
        burcYorumu.value = await Ai.getAIResponseBurc(selectedZodiac);
        burcYorumu.value = burcYorumu.value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Talya",
                      style: GoogleFonts.rochester(
                        color: defaultColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        CosmosNavigator.pushNonAnimated(
                          context,
                          const FalPage(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: defaultColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Detaylı Tarot Açılımı (3 Kart)",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        File? photo = await getCameraPhoto();
                        if (photo != null) {
                          CosmosNavigator.pushNonAnimated(
                            context,
                            PhotoYorum(
                              photo: photo,
                              prompt:
                                  "Sana kahve fincanımın fotoğrafını gönderiyorum. Lütfen bu fotoğrafı gör ve kahve falıma bak.",
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: defaultColor.withOpacity(0.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Kahve Falı Yorumlama",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        File? photo = await getCameraPhoto();
                        if (photo != null) {
                          CosmosNavigator.pushNonAnimated(
                            context,
                            PhotoYorum(
                              photo: photo,
                              prompt:
                                  "Sana elimin fotoğrafını gönderiyorum. Lütfen bu fotoğrafı gör ve el falıma bak.",
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: defaultColor.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "El Falı (Palmistry)",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        File? photo = await getCameraPhoto();
                        if (photo != null) {
                          CosmosNavigator.pushNonAnimated(
                            context,
                            PhotoYorum(
                              photo: photo,
                              prompt:
                                  "Sana yüzümün fotoğrafını gönderiyorum. Lütfen bu fotoğrafı gör ve yüz falıma bak.",
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: defaultColor.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Yüz Falı (Fizyonomi)",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        CosmosNavigator.pushFromRightToLeft(
                          context,
                          const Community(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 14,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/985588-min.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Talya Topluluğu",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        CosmosNavigator.pushNonAnimated(
                          context,
                          const SanaOzel(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 14,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/giphy.gif"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sana Özel",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: iconPath,
                builder: (BuildContext context, IconData value, Widget? child) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (Icons.arrow_drop_down_sharp == iconPath.value) {
                            iconPath.value = Icons.arrow_drop_up_sharp;
                          } else {
                            iconPath.value = Icons.arrow_drop_down_sharp;
                          }
                        },
                        child: Icon(
                          value,
                          color: textColor,
                          size: 40,
                        ),
                      ),
                      Visibility(
                        visible:
                            value == Icons.arrow_drop_down_sharp ? false : true,
                        child: Row(
                          children: [
                            Expanded(
                              child: CosmosScroller(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Text(
                                    " Aşk: ",
                                    style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Geçmiş aşk hayatım ile ilgili bir açılım istiyorum. Geçmişteki aşk hayatımda neler oldu? Hatalar nasıl gerçekleşti ve neden bu şekilde sonuçlandı?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: "< ♡",
                                      color: defaultColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Şu an ki aşk hayatımda neler oluyor? Her şey yolunda mı? Bir sorun veya problem var mı? Varsa çözümü nedir? Öneriler nedir?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ♡ ",
                                      color: defaultColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Gelecek aşk hayatımda neler olacak? Yakın gelecekte hayatıma kimler girecek ve nasıl bir aşk hayatım olacak?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ♡ >",
                                      color: defaultColor,
                                    ),
                                  ),
                                  Text(
                                    " Kariyer: ",
                                    style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Geçmiş kariyer hayatımdaki başarılarım, eksikliklerim ve halletmem gereken şeyler nelerdir?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: "< ♜",
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Kariyer hayatımda neler oluyor? Neler başarıyorum ve nasıl sonuçlanacak? Her şey yolunda mı?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ♜ ",
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Gelecekte beni nasıl bir kariyer bekliyor? Kariyer hayatımda neler olacak?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ♜ >",
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  Text(
                                    " Para: ",
                                    style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Maddi (parasal) olarak geçmişte nasıldım? Ne tür hatalar veya doğrular yaptım? Neleri daha iyi yapabilirdim?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: "< ₺",
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Şu an ki maddi hayatım nasıl? Parasal olarak neler yapmalıyım?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ₺ ",
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Gelecekte parasal olarak maddi hayatım nasıl olacak? Başarılı olabilecek miyim?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ₺ >",
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  Text(
                                    " Şans: ",
                                    style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Geçmişteki şansım hakkında kartlar ne düşünüyor?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: "< ☀",
                                      color: Colors.amber[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Hayattaki şu an ki şansım hakkında kartlar ne düşünüyor?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ☀ ",
                                      color: Colors.amber[800],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      niyet.text =
                                          "Gelecekte şansım dönecek mi? Kader yüzüme gülecek mi?";
                                      CosmosNavigator.pushNonAnimated(
                                        context,
                                        const FalPageIkinci(),
                                      );
                                    },
                                    child: SubButton(
                                      text: " ☀ >",
                                      color: Colors.amber[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                width: width(context),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: defaultColor.withOpacity(0.5),
                      offset: const Offset(1.6, 2),
                      blurRadius: 2,
                    ),
                  ],
                  border: Border.all(
                    color: textColor.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: navColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Burç Yorumun",
                          style: GoogleFonts.poppins(
                            color: defaultColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PopupMenuButton<String>(
                          initialValue: "İkizler",
                          onSelected: (String value) async {
                            SharedPreferences db =
                                await SharedPreferences.getInstance();
                            await db.setString("selected_zodiac", value);
                            setState(() {});
                            burcYorumu.value =
                                await Ai.getAIResponseBurc(value);
                            burcYorumu.value = burcYorumu.value.trim();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: cColor,
                            ),
                            child: Row(
                              children: [
                                FutureBuilder<String>(
                                  future: SharedPreferences.getInstance().then(
                                    (db) =>
                                        db.getString("selected_zodiac") ??
                                        "İkizler",
                                  ),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "İkizler",
                                      style: GoogleFonts.poppins(
                                        color: textColor.withOpacity(0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: textColor.withOpacity(0.6),
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: cColor,
                          itemBuilder: (BuildContext context) {
                            return [
                              'Koç',
                              'Boğa',
                              'İkizler',
                              'Yengeç',
                              'Aslan',
                              'Başak',
                              'Terazi',
                              'Akrep',
                              'Yay',
                              'Oğlak',
                              'Kova',
                              'Balık',
                            ].map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(
                                  choice,
                                  style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: burcYorumu,
                      builder: (
                        BuildContext context,
                        dynamic value,
                        Widget? child,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                            left: 2,
                            top: 2,
                          ),
                          child: Text(
                            burcYorumu.value,
                            style: GoogleFonts.poppins(
                              color: textColor.withOpacity(0.4),
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: list,
                builder: (
                  BuildContext context,
                  List<Widget> value,
                  Widget? child,
                ) {
                  if (value.isEmpty) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences db =
                                    await SharedPreferences.getInstance();
                                db.clear();
                              },
                              child: Text(
                                "Geçmişte yaptığınız açılım bulunmuyor...",
                                style: GoogleFonts.poppins(
                                  color: textColor.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Column(
                      children: value,
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          niyet.text =
              "Kendimi şanslı hissediyorum. Kartların bana neler fısıldadığını söyle.";

          CosmosNavigator.pushNonAnimated(
            context,
            const FalPageIkinci(),
          );

          //  CosmosNavigator.pushNonAnimated(
          //    context,
          //    const ChatAI(),
          //  );
        },
        child: Icon(
          Icons.favorite,
          color: textColor,
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  final String text;
  final Color? color;
  const SubButton({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? defaultColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class YorumKalem extends StatelessWidget {
  final String name;
  final String niyet;
  final String timestamp;
  final List<Map<String, String>> list;
  final String comment;
  final String keys;
  const YorumKalem({
    super.key,
    required this.name,
    required this.niyet,
    required this.timestamp,
    required this.list,
    required this.comment,
    required this.keys,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Silmek istiyor musunuz?",
            ),
            action: SnackBarAction(
              label: "Sil",
              onPressed: () async {
                SharedPreferences db = await SharedPreferences.getInstance();
                db.remove(keys);
                getYorumlar();
              },
            ),
          ),
        );
      },
      onTap: () {
        CosmosNavigator.pushNonAnimated(
          context,
          FalPageFinal(
            list: list,
            comment: comment,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        padding: const EdgeInsets.all(10),
        width: width(context),
        decoration: BoxDecoration(
          color: cColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: name,
                              style: GoogleFonts.poppins(
                                color: defaultColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " için yapılan açılım.",
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        niyet,
                        style: GoogleFonts.roboto(
                          color: textColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Transform.rotate(
                    angle: (list[1]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: list[0]["img"] ?? "assets/backgroundcard.png",
                      width: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Transform.rotate(
                    angle: (list[3]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: list[2]["img"] ?? "assets/backgroundcard.png",
                      width: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Transform.rotate(
                    angle: (list[5]["value"] ?? false) == "true" ? 15.7 : 0,
                    child: TarotCardSingle(
                      img: list[4]["img"] ?? "assets/backgroundcard.png",
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    timestamp,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(
                      color: textColor.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
