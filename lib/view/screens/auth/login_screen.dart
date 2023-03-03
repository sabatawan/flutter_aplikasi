import 'package:flutter/material.dart';
import 'package:flutter_adakami/helper/route_helper.dart';
import 'package:flutter_adakami/view/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            child: Column(
              children: [
                Text("Login Page"),
                Text("Selamat Datang di Ada Kami")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
