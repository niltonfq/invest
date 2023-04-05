import 'package:commons_deps/commons_deps.dart';

import '../../custom_colors.dart';

class CustomSnackbar {
  static void sucesso(String mensagem) {
    Get.snackbar(
      'Aviso',
      mensagem,
      backgroundColor: CustomColors.branco,
    );
  }

  static void erro({
    required String mensagem,
    int tempo = 5,
  }) {
    Get.snackbar(
      'Erro',
      mensagem,
      backgroundColor: CustomColors.alerta,
      isDismissible: true,
      duration: tempo.seconds,
    );
  }

  static void alerta({
    required String mensagem,
    int tempo = 5,
  }) {
    Get.snackbar(
      'Atenção',
      mensagem,
      backgroundColor: CustomColors.alerta,
      isDismissible: true,
      duration: tempo.seconds,
    );
  }
}
