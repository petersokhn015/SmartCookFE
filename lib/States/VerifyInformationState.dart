import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerifyInformationState extends ChangeNotifier {
  File _imageFile;

  File get imageFile => _imageFile;

  void pickLocalImage(String path) {
    _imageFile = File(path);
    notifyListeners();
  }
}
