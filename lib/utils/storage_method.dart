import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadProfileToStorage(
    Uint8List profileImage, String uid) async {
  FirebaseStorage storage = FirebaseStorage.instance;

  Reference ref = storage.ref().child('profile-pic').child(uid);
  UploadTask uploadTask = ref.putData(
    profileImage,
    // SettableMetadata(contentType: 'image/jpg'),
  );
  TaskSnapshot snapshot = await uploadTask;
  String downLoadUrl = await snapshot.ref.getDownloadURL();
  return downLoadUrl;
}