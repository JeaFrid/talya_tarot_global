import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tarot/theme/color.dart';
import 'package:tarot/widget/textbox.dart';

ValueNotifier<List<Widget>> com = ValueNotifier([]);
ValueNotifier<List<Widget>> comPin = ValueNotifier([]);
ValueNotifier<List<Widget>> comNew = ValueNotifier([]);

Future<void> getCommunity() async {
  com.value.clear();
  comPin.value.clear();
  comNew.value.clear();
  List a = await CosmosFirebase.getOnce("community");
  List users = await CosmosFirebase.getOnce("users");
  String myUID = await CosmosFirebase.getUID();
  List c = CosmosTools.sortFromList(a, 3);

  for (List element in c.reversed.toList()) {
    List userList = [];
    for (List b in users) {
      if (b[0] == element[1]) {
        userList = b;
      }
    }
    if (element[5] == "true") {
      comPin.value.add(
        CommunityMessage(
          pin: true,
          name: userList[1],
          time: element[3],
          message: element[2],
          owner: myUID == element[1],
          tag: element[0],
        ),
      );
    } else {
      if (!isTimeDMT24s(element[3], CosmosTime.getNowTimeString())) {
        comNew.value.add(
          CommunityMessage(
            pin: false,
            name: userList[1],
            time: element[3],
            message: element[2],
            owner: myUID == element[1],
            tag: element[0],
          ),
        );
      } else {
        com.value.add(
          CommunityMessage(
            pin: false,
            name: userList[1],
            time: element[3],
            message: element[2],
            owner: myUID == element[1],
            tag: element[0],
          ),
        );
      }
    }
  }
  com.notifyListeners();
  comNew.notifyListeners();
  comPin.notifyListeners();
}

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1),
      () async {
        await getCommunity();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        com,
      ]),
      builder: (_, __) {
        return Scaffold(
          backgroundColor: bgColor,
          body: CosmosBackgroundImage(
            image: "assets/985588-min.jpg",
            opacity: 0.1,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Talya Toplulugu",
                                  style: GoogleFonts.rochester(
                                    color: defaultColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: comPin.value.isNotEmpty,
                            child: Opacity(
                              opacity: 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "Sabitlenmiş",
                                      style: GoogleFonts.poppins(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: comPin.value,
                          ),
                          Visibility(
                            visible: comNew.value.isNotEmpty,
                            child: Opacity(
                              opacity: 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "En Yeni",
                                      style: GoogleFonts.poppins(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: comNew.value,
                          ),
                          Visibility(
                            visible: com.value.isNotEmpty,
                            child: Opacity(
                              opacity: 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      "Tüm Gönderiler",
                                      style: GoogleFonts.poppins(
                                        color: textColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: textColor,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: com.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextBoxBottom(
                    width: width(context),
                    textEditingController: textEditingController,
                    text: "Topluluğa yaz...",
                    onTap: () async {
                      String text = textEditingController.text;
                      textEditingController.clear();
                      String tag = CosmosRandom.randomTag();
                      String uid = await CosmosFirebase.getUID();

                      await CosmosFirebase.add(
                        reference: "community",
                        tag: tag,
                        value: [
                          tag,
                          uid,
                          text,
                          CosmosTime.getNowTimeString(),
                          "", //Photo
                          "false", //isPinned?
                          "", // özel mesaj
                        ],
                        onSuccess: () async {
                          await getCommunity();
                        },
                      );
                    },
                    onTapLong: () async {
                      String text = textEditingController.text;
                      textEditingController.clear();
                      String tag = CosmosRandom.randomTag();
                      String uid = await CosmosFirebase.getUID();
                      await CosmosFirebase.add(
                        reference: "community",
                        tag: tag,
                        value: [
                          tag,
                          uid,
                          text,
                          CosmosTime.getNowTimeString(),
                          "", //Photo
                          "true", //isPinned?
                          "", // özel mesaj
                        ],
                        onSuccess: () async {
                          await getCommunity();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CommunityMessage extends StatefulWidget {
  final String name;
  final String time;
  final String message;
  final String tag;
  final bool owner;
  final bool pin;
  const CommunityMessage({
    super.key,
    required this.name,
    required this.time,
    required this.message,
    required this.owner,
    required this.tag,
    required this.pin,
  });

  @override
  State<CommunityMessage> createState() => _CommunityMessageState();
}

class _CommunityMessageState extends State<CommunityMessage> {
  ValueNotifier<bool> read = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: read,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Container(
          width: width(context),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: widget.pin == true
              ? BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/111-min.jpg",
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: cColor,
                  boxShadow: [
                    BoxShadow(
                      color: textColor.withOpacity(0.2),
                      offset: const Offset(1, -1),
                      blurRadius: 4,
                    ),
                  ],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: cColor,
                  boxShadow: [
                    BoxShadow(
                      color: textColor.withOpacity(0.2),
                      offset: const Offset(1, -1),
                      blurRadius: 4,
                    ),
                  ],
                ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    widget.pin == true ? Icons.location_on : Icons.person,
                    color: widget.owner == true ? defaultColor : textColor,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.pin == true ? "Talya  Moderasyonu" : widget.name,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    CosmosTime.getDateTR(CosmosTime.getDateTime(widget.time))
                        .split(", ")[2],
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  read.value = !read.value;
                  read.notifyListeners();
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.message,
                            maxLines: read.value == false ? null : 4,
                            overflow: read.value == false
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Visibility(
                            visible: widget.message.length < 180 ? false : true,
                            child: Text(
                              "Daha fazlasını oku...",
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: defaultColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      CosmosTime.getDateTR(CosmosTime.getDateTime(widget.time))
                          .split(", ")[0],
                      style: GoogleFonts.poppins(
                        color: textColor.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await copy(widget.message);
                      await Fluttertoast.showToast(
                        msg: "Kopyalandı.",
                        backgroundColor: defaultColor,
                        textColor: textColor,
                      );
                    },
                    child: Icon(
                      Icons.copy_rounded,
                      color: textColor.withOpacity(0.5),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

bool isTimeDMT24s(String time1, String time2) {
  DateFormat format = DateFormat("d/M/yyyy H:m:s");

  DateTime dateTime1 = format.parse(time1);
  DateTime dateTime2 = format.parse(time2);

  Duration difference = dateTime1.difference(dateTime2).abs();
  return difference.inDays > 1;
}
