import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudarshan_creations/views/sudarshan_homepage.dart';
import 'package:sudarshan_creations/views/widgets/top_appbar.dart';
import '../../shared/const.dart';
import '../../shared/theme.dart';

final wrapperScafKey = GlobalKey<ScaffoldState>();

class Wrapper2 extends StatefulWidget {
  const Wrapper2({
    super.key,
    required this.body,
    this.scafKey,
    this.endDrawer,
    this.scrollController,
    this.showFooter = true,
    this.allowScroll = true,
    this.showBackToTop = true,
    this.showFilter = false,
  });

  final Widget body;
  final Widget? endDrawer;
  final ScrollController? scrollController;
  final GlobalKey<ScaffoldState>? scafKey;
  final bool showFooter;
  final bool showFilter;
  final bool allowScroll;
  final bool showBackToTop;

  @override
  State<Wrapper2> createState() => _Wrapper2State();
}

class _Wrapper2State extends State<Wrapper2> {
  final wrapperScrlCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    final small = false;
    return Scaffold(
      key: widget.scafKey ?? wrapperScafKey,
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        // physics:
        //     widget.allowScroll ? null : const NeverScrollableScrollPhysics(),
        controller: widget.scrollController ?? wrapperScrlCtrl,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: TopAppBarDesk(mobile: false),
              pinned: true,
              shadowColor: Colors.amber,
              surfaceTintColor: Colors.amber,
              foregroundColor: Colors.amber,
              // elevation: 0,
              forceMaterialTransparency: true,
              // scrolledUnderElevation: .5,
              automaticallyImplyLeading: false,
              actions: const [SizedBox()],
              snap: true,
              floating: true,
              backgroundColor: Colors.black38,
              // forceElevated: innerBoxIsScrolled,
              expandedHeight: (kIsWeb ? 80 : 60) + 32,
              bottom: const NavBar(),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          physics: widget.allowScroll
              ? const ClampingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            widget.body,
            if (small && widget.showBackToTop)
              ListTile(
                tileColor: Colors.grey.shade200,
                title: const Text("BACK TO TOP"),
                trailing:
                    const Icon(Icons.arrow_upward_rounded, color: Colors.red),
                onTap: () {
                  widget.scrollController != null
                      ? widget.scrollController?.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear)
                      : wrapperScrlCtrl.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                },
              ),
            // if (widget.showFooter) const FooterWid(),
          ],
        ),
      ),
    );
  }
}
