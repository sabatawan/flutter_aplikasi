import 'package:flutter/material.dart';
import 'package:flutter_adakami/helper/route_helper.dart';
import 'package:flutter_adakami/utill/color_resources.dart';
import 'package:flutter_adakami/utill/dimensions.dart';
import 'package:flutter_adakami/utill/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
              bottom: false,
              child: Column(children: [
                Text("Selamat Datang di Ada Kami")
              ])),
        ),
      ),
    );
  }
}
