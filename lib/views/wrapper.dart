import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.black,
      key: widget.scafkey ?? wrapperScafKey,
      drawer: Drawer(
        key: wrapperScafKey,
        shape: const RoundedRectangleBorder(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _CloseButton(widget.scafkey ?? wrapperScafKey),
            ],
          ),
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
          child: const Icon(CupertinoIcons.xmark),
        ),
      ],
    );
  }
}
