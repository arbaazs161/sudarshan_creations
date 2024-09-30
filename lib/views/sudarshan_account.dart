import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/footer.dart';
import 'widgets/sub_cat_product_topbar.dart';

class SudarshanAccountPage extends StatefulWidget {
  const SudarshanAccountPage({super.key});

  @override
  State<SudarshanAccountPage> createState() => _SudarshanAccountPageState();
}

class _SudarshanAccountPageState extends State<SudarshanAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF7F3),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const PageHeaderTopBar(title: "Account"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                // color: Colors.black12,
                constraints: BoxConstraints(
                  maxWidth: 1200,
                  // min height = screen height  - footer height - appbar height
                  minHeight: MediaQuery.sizeOf(context).height - 60 - 350,
                ),
                child: false
                    ? true
                        //   CREATE ACCOUNT SECTION
                        ? Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Create account",
                                    style: GoogleFonts.brawler(
                                      color: const Color(0xff95170D),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'First Name',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'Last Name',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        surfaceTintColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 30),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        backgroundColor:
                                            const Color(0xff95170D),
                                      ),
                                      child: Text(
                                        "Create",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            letterSpacing: 1.7),
                                      )),
                                  const SizedBox(height: 15),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xff95170D),
                                                width: .5))),
                                    child: Text(
                                      "Have an account",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff95170D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          )
                        //   LOGIN SECTION
                        : Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Login",
                                    style: GoogleFonts.brawler(
                                      color: const Color(0xff95170D),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: .5)),
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 8),
                                    child: SizedBox(
                                      height: 35,
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 14.5),
                                        cursorColor: const Color.fromARGB(
                                            255, 106, 106, 106),
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                          floatingLabelStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFF4F4F4F)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color(0xff95170D),
                                                    width: .5))),
                                        child: Text(
                                          "Forgot your password?",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xff95170D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        surfaceTintColor: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 30),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        backgroundColor:
                                            const Color(0xff95170D),
                                      ),
                                      child: Text(
                                        "Sign in",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            letterSpacing: 1.7),
                                      )),
                                  const SizedBox(height: 15),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xff95170D),
                                                width: .5))),
                                    child: Text(
                                      "Create account",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff95170D),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 400,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color(0xffFEF7F3),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0)),
                                      ]),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Account"),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color(0xffFEF7F3),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.5,
                                            offset: Offset(0, 0)),
                                      ]),
                                  child: const Text('Data'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            const SudarshanFooterSection(),
          ],
        ),
      ),
    );
  }
}
