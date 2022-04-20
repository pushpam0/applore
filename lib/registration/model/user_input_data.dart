import '../services/firebase_services.dart';

class CollectUserInputData{
  Future<String> registrationRequiedData({required String email,required password}) async {
    print("$email, $password,");
    String  status = await firebaseInserAuth(email,password);
    return status;
   // print("user created ");
  }
}