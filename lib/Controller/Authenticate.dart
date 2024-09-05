import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sudarshan_creations/Model/UserModel.dart';

class AuthenticateController extends GetxController  {

  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  
  Future userSignup(UserModel user) async{
    try{

      await auth.verifyPhoneNumber(
        phoneNumber: user.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
        this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
      //Web sign in method when using phone numbers

      
    } catch(e){
      return e.toString();
    }
  }

  Future<bool> verifyCode(String OTP) async{
    var credentials = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: OTP));
    return credentials.user != null ? true : false;
  }

}