import 'package:commons_design_system/custom_colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/logo.jpg'),
      color: CustomColors.branco,
    );
  }
}
