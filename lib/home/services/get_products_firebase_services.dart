import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> getProducts() async {
  List<DocumentSnapshot> product = [];
  Query q =
      FirebaseFirestore.instance.collection('users').orderBy('price').limit(10);
  QuerySnapshot querySnapshot = await q.get();
  product = querySnapshot.docs;
  return product;
}

Future<List<DocumentSnapshot>> getMProducts(lastdoc) async {
  List<DocumentSnapshot> product = [];
  Query q = FirebaseFirestore.instance
      .collection('users')
      .orderBy('price')
      .startAfter(lastdoc.data)
      .limit(10);
  QuerySnapshot querySnapshot = await q.get();
  product = querySnapshot.docs;
  return product;
}
