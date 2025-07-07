import 'package:flutter/material.dart';

class HeroNavbarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. SliverAppBar that overlays the hero banner
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Your Brand',
                style: TextStyle(
                    shadows: [Shadow(color: Colors.black45, blurRadius: 3)]),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://amour-sample-2.netlify.app/path-to-hero-image.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color:
                        Colors.black.withOpacity(0.3), // Optional dark overlay
                  ),
                ],
              ),
            ),
          ),

          // 2. SliverList or SliverFillRemaining for content below
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Content block #${index + 1}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
