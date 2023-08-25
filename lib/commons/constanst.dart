import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xff18181A),
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Future<Uint8List?> pickImageFromGallery() async {
  FilePickerResult? pickedFile =
      await FilePicker.platform.pickFiles(type: FileType.image);
  if (pickedFile != null) {
    if (kIsWeb) {
      return pickedFile.files.single.bytes!;
    }
    return await File(pickedFile.files.single.path!).readAsBytes();
  }
  return null;
}
