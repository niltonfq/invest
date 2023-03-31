import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegistroPage({Key? key}) : super(key: key);

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
                height: 540,
                width: 604,
                child: Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: CustomColors.destaque,
                        ),
                        label: 'Nome',
                        borderRadius: 45,
                      ),
                      SizedBox(height: 35),
                      CustomTextFormField(
                        controller: emailController,
                        prefixIcon: Icon(
                          Icons.call_outlined,
                          color: CustomColors.destaque,
                        ),
                        label: 'Telefone',
                        borderRadius: 45,
                      ),
                      SizedBox(height: 35),
                      CustomTextFormField(
                        controller: emailController,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: CustomColors.destaque,
                        ),
                        label: 'email',
                        borderRadius: 45,
                      ),
                      SizedBox(height: 32),
                      CustomTextFormField(
                        controller: passwordController,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: CustomColors.destaque,
                        ),
                        label: 'senha',
                        isSecret: true,
                        borderRadius: 45,
                      ),
                      SizedBox(height: 24),
                      CustomButton(
                        child: Text(
                          ' Registrar ',
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
                      SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: CustomColors.branco.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Ou',
                                style: TextStyle(
                                  color: CustomColors.branco,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: CustomColors.branco.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      CustomButtonSecondary(
                        child: Text(
                          ' ENTRAR ',
                          style: TextStyle(
                            color: CustomColors.branco,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('login');
                        },
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
