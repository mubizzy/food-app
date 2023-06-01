import 'package:flutter/material.dart';

class RecommendeFoodDetail extends StatelessWidget {
  const RecommendeFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food11.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
