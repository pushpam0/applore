import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_demo/home/services/firebase_service.dart';
import 'package:flutter_app_demo/home/services/firebase_storage.dart';
import 'package:flutter_app_demo/login/services/firebase_service.dart';

class CollectUserItemData {
  Future<String> productRequiedData(
      {required String product,
      required String price,
      required String disc,
      required File url}) async {
    print("$price  $product  $disc  $url");
    UploadTask task = await firebaseImageAdd(url);
    final snapshot = await task.whenComplete(() {});
    final urlDowanload = await snapshot.ref.getDownloadURL();
    print("dowanload link: ${urlDowanload}");
    await firebaseItemAdd(product, price, disc, urlDowanload.toString());
    return "C";
  }
}
