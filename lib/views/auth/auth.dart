// REFERENCE AUTH CODE

/* import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../shared/firebase.dart';
import '../../shared/methods.dart';
import '../../shared/router.dart';
import '../../shared/snackbar.dart';

final _authScafKey = GlobalKey<ScaffoldState>();

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.goTo});

  final String? goTo;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  late TabController tabCtrl;
  final mobileCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final otpCtrl = TextEditingController();
  ConfirmationResult? confirmationResult;
  int? newUserEmailOtp;
  DateTime? newUserEmailOtpSentOn;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      showBackToTop: false,
      scafKey: _authScafKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoggedIn()
            ? const Text("Already logged in!")
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _loginText(),
                          const SizedBox(height: 20),
                          _desc(),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          _tabBar(),
                          const SizedBox(height: 40),
                          _formWids[tabCtrl.index],
                          const SizedBox(height: 32),
                          if (tabCtrl.index == 0 && confirmationResult != null)
                            _otpInputField(),
                          if (tabCtrl.index != 0 && newUserEmailOtp != null)
                            _otpInputField(),
                          _submitButton(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Column _otpInputField() {
    return Column(
      children: [
        Form(
          key: otpFormKey,
          child: TextFormField(
            controller: otpCtrl,
            validator: (value) => value!.isNumericOnly && value.length == 10
                ? null
                : "Invalid OTP!",
            onFieldSubmitted: (value) => tabCtrl.index == 0
                ? _confirmOTP(otpCtrl.text)
                : _confirmEmailOTP(otpCtrl.text),
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 8),
                child: Icon(Icons.password_rounded),
              ),
              hintText: "One Time Password",
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  _onSubmit() async {
    try {
      if (loading) return;
      if (tabCtrl.index == 0) {
        if (mobileFormKey.currentState!.validate()) {
          setState(() => loading = true);
          confirmationResult =
              await FBAuth.auth.signInWithPhoneNumber('+91${mobileCtrl.text}');
          showAppSnack("OTP Sent!");
        }
        setState(() => loading = false);
      } else {
        _authWithEmail();
      }
    } catch (e) {
      setState(() => loading = false);
      debugPrint(e.toString());
    }
  }

  _authWithEmail() async {
    try {
      if (emailFormKey.currentState!.validate()) {
        setState(() => loading = true);
        final otp = Random().nextInt(999999);
        final res = await FBFireStore.users
            .where('authEmail', isEqualTo: emailCtrl.text)
            .get();
        if (res.docs.isNotEmpty) {
          // // Document Exist
          debugPrint("Old User");
          // Save Otp
          newUserEmailOtp = otp;
          newUserEmailOtpSentOn = DateTime.now();
          await FBFireStore.users.doc(res.docs.first.id).update({
            'otp': otp,
            'otpTime': FieldValue.serverTimestamp(),
          });
          // Send OTP Email
          await FBFunctions.ff.httpsCallable('sendOtpEmail').call(
            {
              'email': emailCtrl.text,
              'otp': otp,
            },
          );
          showAppSnack("OTP Sent!");
        } else {
          // // New User
          debugPrint("New User");
          newUserEmailOtp = otp;
          newUserEmailOtpSentOn = DateTime.now();
          await FBFunctions.ff.httpsCallable('sendOtpEmail').call(
            {
              'email': emailCtrl.text,
              'otp': otp,
            },
          );
          showAppSnack("OTP Sent!");
        }
      }
      setState(() => loading = false);
    } catch (e) {
      setState(() => loading = false);
      debugPrint(e.toString());
    }
  }

  _confirmEmailOTP(String otp) async {
    try {
      if (loading) return;
      setState(() => loading = true);
      final res = await FBFireStore.users
          .where('authEmail', isEqualTo: emailCtrl.text)
          .get();
      if (res.docs.isNotEmpty) {
        // // Doc Found
        debugPrint("Old User");
        final userDocData = res.docs.first;
        if (userDocData['otp'].toString() == otp &&
            (userDocData['otpTime']
                    ?.toDate()
                    .add(const Duration(minutes: 5))
                    .isAfter(DateTime.now()) ??
                false)) {
          await FBAuth.auth.signInWithEmailAndPassword(
              email: emailCtrl.text, password: res.docs.first['password']);
          //
          if (context.mounted) {
            context.go(widget.goTo != null
                ? widget.goTo!
                : routeHistory.reversed.elementAt(1));
          }
        }
      } else {
        // // New User
        debugPrint("New User");
        if (otp == newUserEmailOtp.toString() &&
            (newUserEmailOtpSentOn
                    ?.add(const Duration(minutes: 5))
                    .isAfter(DateTime.now()) ??
                false)) {
          final newPass = getRandomId(8);
          final newUserCred = await FBAuth.auth.createUserWithEmailAndPassword(
              email: emailCtrl.text, password: newPass);
          var data = {
            'phone': "",
            'email': emailCtrl.text,
            'firstOrderDone': false,
            'authEmail': emailCtrl.text,
            'defaultAddressId': null,
            'addresses': {},
            'cartData': {},
            'password': newPass,
          };
          await FBFireStore.users.doc(newUserCred.user?.uid).set(data);
          //
          if (mounted) {
            context.go(widget.goTo != null
                ? widget.goTo!
                : routeHistory.reversed.elementAt(1));
          }
        } else {
          showAppSnack("OTP Invalid or Expired!");
        }
      }
      setState(() => loading = false);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.code.toString());
      if (e.code == 'invalid-verification-code') {
        showAppSnack("Invalid OTP!");
      } else {
        showAppSnack(e.message?.toString() ?? "Something went wrong!");
      }
      setState(() => loading = false);
    } catch (e) {
      debugPrint(e.toString());
      setState(() => loading = false);
    }
  }

  _confirmOTP(String otp) async {
    try {
      if (loading) return;
      setState(() => loading = true);
      UserCredential? userCredential = await confirmationResult?.confirm(otp);
      if (userCredential != null && mounted) {
        context.go(widget.goTo != null
            ? widget.goTo!
            : routeHistory.reversed.elementAt(1));
        if (!((await FBFireStore.users.doc(userCredential.user?.uid).get())
            .exists)) {
          var data = {
            'phone': userCredential.user?.phoneNumber,
            'email': emailCtrl.text,
            'firstOrderDone': false,
            'authEmail': "",
            'defaultAddressId': null,
            'addresses': {},
            'cartData': {},
            'password': "",
          };
          await FBFireStore.users.doc(userCredential.user?.uid).set(data);
        }
      }
      setState(() => loading = false);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'invalid-verification-code') {
        showAppSnack("Invalid OTP!");
      } else {
        showAppSnack(e.message?.toString() ?? "Something went wrong!");
      }
      setState(() => loading = false);
    } catch (e) {
      debugPrint(e.toString());
      setState(() => loading = false);
    }
  }

  Text _loginText() {
    return const Text(
      "Login with OTP",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Text _desc() {
    return const Text(
      "Please login to access your saved sizes if you've shopped Online or In Store with us.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }

  ElevatedButton _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: () => tabCtrl.index == 0
          ? confirmationResult == null
              ? _onSubmit()
              : _confirmOTP(otpCtrl.text)
          : newUserEmailOtp == null
              ? _onSubmit()
              : _confirmEmailOTP(otpCtrl.text),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tabCtrl.index == 0
                ? confirmationResult == null
                    ? "Send OTP"
                    : "Verify OTP"
                : newUserEmailOtp == null
                    ? "Send OTP"
                    : "Verify OTP",
            style: const TextStyle(color: Colors.white),
          ),
          if (loading)
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white)),
              ),
            ),
        ],
      ),
    );
  }

  List<Form> get _formWids {
    return [
      Form(
        key: mobileFormKey,
        child: TextFormField(
          controller: mobileCtrl,
          validator: (value) => value!.isNumericOnly && value.length == 10
              ? null
              : "Require a valid number!",
          onFieldSubmitted: (value) => _onSubmit(),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 8),
              child: Icon(CupertinoIcons.phone_fill),
            ),
            prefixText: "+91",
            hintText: "Mobile Number",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      Form(
        key: emailFormKey,
        child: TextFormField(
          controller: emailCtrl,
          validator: (value) =>
              value!.isEmail ? null : "Require a valid email!",
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12.0, right: 8),
              child: Icon(CupertinoIcons.mail_solid),
            ),
            hintText: "abc@email.com",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    ];
  }

  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: TabBar(
          splashBorderRadius: BorderRadius.circular(8),
          indicatorPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          controller: tabCtrl,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black,
          ),
          onTap: (v) => setState(() {}),
          dividerColor: Colors.transparent,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mobile No.",
                    style: TextStyle(
                        color:
                            tabCtrl.index == 0 ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "E-mail",
                    style: TextStyle(
                        color:
                            tabCtrl.index == 1 ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}


 */

// ARBAAZ CODE

/* 
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpVisible = false;
  // AuthenticateController _authController = AuthenticateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: 'e.g. +1234567890',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String phoneNumber = _phoneController.text.trim();
                // Call the authenticate method from AuthController
                // await _authController.userSignup(phoneNumber);

                // Show the OTP input field after the phone number is authenticated
              },
              child: const Text('Submit Phone Number'),
            ),
            const SizedBox(height: 20),
            if (_isOtpVisible) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String otp = _otpController.text.trim();
                  // Call a method in AuthController to verify OTP
                  // _authController.verifyCode(otp);
                },
                child: const Text('Submit OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
 */