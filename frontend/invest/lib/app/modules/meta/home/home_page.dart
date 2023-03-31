import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller;

  const HomePage({Key? key, required HomeController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
