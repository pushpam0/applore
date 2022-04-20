



import 'package:flutter_app_demo/login/services/firebase_service.dart';

class CollectUserLoginData{
  Future<String> loginRequiedData({required String email,required password}) async {
    print("$email, $password,");
    String  status = await firebaseLoginAuth(email,password);
    return status;
    // print("user created ");
  }
}