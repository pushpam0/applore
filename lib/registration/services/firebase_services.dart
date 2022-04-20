import 'package:firebase_auth/firebase_auth.dart';

Future<String> firebaseInserAuth(String email,String password)async {
 // FirebaseAuth auth = FirebaseAuth.instance;


  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return "The password provided is too weak";

    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 'The account already exists for that email.';
    }
  } catch (e) {

    print(e);
    return e.toString();
  }
  return "user created";
}