import 'dart:io';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<UploadTask> firebaseImageAdd(File url) async {
  final filename = basename(url.path);
  final destination = 'files/$filename';
  final ref = FirebaseStorage.instance.ref(destination);
  return ref.putFile(url);

  //return "";
}
