import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCtrl extends GetxController {
  late final TextEditingController phoneCtrl;
  final otpCtrl = TextEditingController();
  String verificationCode = "";
  int? resendToken;
  bool timout = false;
  bool sendingOtp = false;
  bool verifyingOtp = false;
  bool otpSent = false;
  RxInt timerValue = 60.obs;

  @override
  void onInit() {
    // print("object")
    super.onInit();
    phoneCtrl = TextEditingController();
  }

  resetTimer() => timerValue.value = 60;

  startTimer() async {
    while (timerValue > 0) {
      await Future.delayed(const Duration(seconds: 1));
      --timerValue.value;
    }
  }

  sentOtp(BuildContext context) async {
    try {
      if (sendingOtp) return;
      if (phoneCtrl.text.substring(0, 3) != "+91") {
        phoneCtrl.text = '+91${phoneCtrl.text}';
      }
      if (phoneCtrl.text.length < 10) {
        showAppSnackBar("Invalid Phone Number");
      }
      sendingOtp = true;
      update();

      await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: resendToken,
        phoneNumber: phoneCtrl.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint("Success");
          sendingOtp = false;
          update();
          await signInWithCreds(credential, context);
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('Failed $e');
          if (e.code == 'invalid-phone-number') {
            debugPrint('Phone number invalid');
          }
          sendingOtp = false;
          update();
        },
        codeSent: (String verificationId, int? resendToken) async {
          debugPrint("Code Sent... $verificationId");
          otpSent = true;
          verificationCode = verificationId;
          this.resendToken = resendToken;
          sendingOtp = false;
          update();
          resetTimer();
          startTimer();
          // add navigator to otp
          // if (context.mounted) {
          //   await Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const OtpScreen(),
          //       ));
          // }
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          sendingOtp = false;
          update();
          debugPrint("Timeout...");
          timout = true;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      sendingOtp = false;
      update();
    }
  }

  createCredsAndSignIn(BuildContext context) async {
    verifyingOtp = true;
    update();
    await signInWithCreds(createCreds(), context);
  }

  signInWithCreds(PhoneAuthCredential credential, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      verifyingOtp = false;
      update();
      // if (context.mounted) {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const HomePage(),
      //       ));
      // }
    } catch (e) {
      debugPrint("------${e.toString()}");
      verifyingOtp = false;
      update();
      const snackBar = SnackBar(content: Text('Incorrect Otp'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  PhoneAuthCredential createCreds() {
    return PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: otpCtrl.text);
  }
}

void showAppSnackBar(String message) {
  try {
    Get.showSnackbar(
      GetSnackBar(
        duration: const Duration(seconds: 3),
        barBlur: 10,
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: const Color.fromARGB(255, 28, 28, 29),
        // borderRadius: 12,
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}






// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/state_manager.dart';

// class AuthenticateController extends GetxController  {

//   FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   var verificationId = ''.obs;
//   var userId = "";
//   var phoneNumber = "";

  
//   Future userSignup(String phone) async{
//     try{

//       await auth.verifyPhoneNumber(
//         phoneNumber: phone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await auth.signInWithCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           if (e.code == 'invalid-phone-number') {
//             debugPrint('The provided phone number is not valid.');
//           }
//         },
//         codeSent: (String verificationId, int? resendToken) async {
//         this.verificationId.value = verificationId;
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           debugPrint("Auto Retrieval Time Out");
//         },
//       );
//       //Web sign in method when using phone numbers

      
//     } catch(e){
//       return e.toString();
//     }
//   }

//   Future<bool> verifyCode(String OTP) async{
//     var credentials = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: OTP));
//     return credentials.user != null ? true : false;
//   }

//   Future<void> insertUser(String userId, String phoneNumber) async{

//     try {
//       var res = await db.collection("User").doc(userId).get();
//       if (res.exists){

//       } else{
//         UserModel user = new UserModel(userId, "", "", "", phoneNumber);
//         Map<String, dynamic> UserData = user.toJson();
//         db.collection("User").doc(userId).set(UserData);
//       }

//     } catch (err) {
//       print(err);
//     }
    
//   }

// }