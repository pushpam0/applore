import 'package:firebase_auth/firebase_auth.dart';

Future<String> firebaseLoginAuth(String email,String password)async {
  // FirebaseAuth auth = FirebaseAuth.instance;


  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return 'No user found for that email.';

    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return 'Wrong password provided for that user.';

    }


  }
  return "sucessful login";
}