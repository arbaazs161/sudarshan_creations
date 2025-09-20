import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:sudarshan_creations/controller/home_controller.dart';
import 'package:sudarshan_creations/shared/router.dart';
import 'package:url_launcher/url_launcher_string.dart';

final wrapperScafKey = GlobalKey<ScaffoldState>();

class Wrapper extends StatefulWidget {
  const Wrapper(
      {super.key,
      required this.body,
      // required this.small,
      required this.scafkey});
  final Widget body;
  // final bool small;
  final GlobalKey<ScaffoldState>? scafkey;
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffFEF7F3),
      backgroundColor: Colors.white,

      key: widget.scafkey ?? wrapperScafKey,
      drawer: Drawer(
        backgroundColor: Colors.black,
        // backgroundColor: Colors.red,

        key: wrapperScafKey,
        shape: const RoundedRectangleBorder(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: GetBuilder<HomeCtrl>(
              init: Get.find<HomeCtrl>(),
              builder: (hCtrl) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CloseButton(widget.scafkey ?? wrapperScafKey),
                    const SizedBox(height: 24),
                    // ...[
                    const Text("Categories",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white, height: 0),
                    const SizedBox(height: 5),

                    ...hCtrl.homeCategories.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            context.go("${Routes.category}/${e.docId}");
                            widget.scafkey?.currentState?.closeDrawer();
                          },
                          child: Text(
                            e.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }),
                    // ],
                    const SizedBox(height: 20),
                    const Text("Contact Us",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white, height: 0),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          launchUrlString("tel://919586112126");
                          widget.scafkey?.currentState?.closeDrawer();
                        },
                        child: const Row(children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(height: 15),
                          Text("(+91) 95861 12126",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ]),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // VerticalDivider(color: Colors.white, width: 1,thickness: 3,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InkWell(
                        onTap: () {
                          launchUrlString('mailto:sudarshan@gmail.com');
                          widget.scafkey?.currentState?.closeDrawer();
                        },
                        child: const Row(children: [
                          Icon(
                            CupertinoIcons.mail,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(width: 10),
                          Text("sudarshan@gmail.com",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ]),
                      ),
                    )

                    // contact ui
                  ],
                );
              }),
        ),
      ),
      body: widget.body,
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton(this.scafKey);
  final GlobalKey<ScaffoldState> scafKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            scafKey.currentState?.closeDrawer();
            //  scafKey.currentState?.closeEndDrawer();
          },
          child: const Icon(CupertinoIcons.xmark, color: Colors.white),
        ),
      ],
    );
  }
}
