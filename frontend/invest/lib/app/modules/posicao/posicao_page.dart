import 'dart:io';

import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class SenhaPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SenhaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.fundo_tela,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 110,
              ),
              const CustomAppName(
                textSize: 60,
                prefixo: 'ABS',
                sufixo: 'Invest',
              ),
              const SizedBox(
                height: 90,
              ),
              CustomPanelForm(
                height: 526,
                width: 604,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        child: const Text(
                          ' Posicaoar ',
                          style: TextStyle(
                            color: CustomColors.fundo_tela,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(CustomColors.destaque),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
