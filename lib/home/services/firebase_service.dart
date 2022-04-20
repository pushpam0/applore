import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> firebaseItemAdd(
    String product, String price, String discreption, String url) async {
  FirebaseFirestore.instance.collection('users').add({
    'product_name': product, // John Doe
    'price': price, // Stokes and Sons
    'discription': discreption,
    'url': url // 42
  });
  return "sucessful login";
}
