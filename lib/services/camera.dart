import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> getCameraPhoto() async {
  try {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      Fluttertoast.showToast(msg: "Kameraya ulaşılamıyor...");

      return null;
    } else {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        return File(pickedImage.path);
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    Fluttertoast.showToast(msg: "Kamera kontrolü sağlanamadı.");

    return null;
  }
  return null;
}
