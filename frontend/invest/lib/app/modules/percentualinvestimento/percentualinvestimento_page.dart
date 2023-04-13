import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'percentualinvestimento_controller.dart';

class PercentualinvestimentoPage
    extends GetView<PercentualinvestimentoController> {
  const PercentualinvestimentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Percentual de Investimento'),
      ),
      body: controller.obx(
        (state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: Column(
                children: [
                  Row(children: [
                    sliderTitulo("Ações", controller.state?.acoes),
                    Slider(
                      value: controller.state?.acoes?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.acoes = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("Fundos Imobiliários",
                        controller.state?.fundosImobiliarios),
                    Slider(
                      value:
                          controller.state?.fundosImobiliarios?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.fundosImobiliarios = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("Fundos Investimentos",
                        controller.state?.fundosInvestimentos),
                    Slider(
                      value:
                          controller.state?.fundosInvestimentos?.toDouble() ??
                              0,
                      onChanged: (double newValue) {
                        controller.state?.fundosInvestimentos =
                            newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                  ]),
                  Row(children: [
                    sliderTitulo("Fiagro", controller.state?.fiagro),
                    Slider(
                      value: controller.state?.fiagro?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.fiagro = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("Stocks", controller.state?.stocks),
                    Slider(
                      value: controller.state?.stocks?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.stocks = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("Reits", controller.state?.reits),
                    Slider(
                      value: controller.state?.reits?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.reits = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                  ]),
                  Row(children: [
                    sliderTitulo(
                        "ETFs Nacionais", controller.state?.etfsNacionais),
                    Slider(
                      value: controller.state?.etfsNacionais?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.etfsNacionais = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("ETFs Internacionais",
                        controller.state?.etfsInternacionais),
                    Slider(
                      value:
                          controller.state?.etfsInternacionais?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.etfsInternacionais = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo(
                        "Criptomoedas", controller.state?.criptoMoedas),
                    Slider(
                      value: controller.state?.criptoMoedas?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.criptoMoedas = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                  ]),
                  Row(children: [
                    sliderTitulo(
                        "Tesouro Direto", controller.state?.tesouroDireto),
                    Slider(
                      value: controller.state?.tesouroDireto?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.tesouroDireto = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("CDB", controller.state?.cdb),
                    Slider(
                      value: controller.state?.cdb?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.cdb = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                    sliderTitulo("LCI e LCA", controller.state?.lcilca),
                    Slider(
                      value: controller.state?.lcilca?.toDouble() ?? 0,
                      onChanged: (double newValue) {
                        controller.state?.lcilca = newValue.round();
                        controller.somaPercent();
                      },
                      min: 0,
                      max: 100.0,
                    ),
                  ]),
                  Row(
                    children: [
                      sliderTitulo("Cri e Cra", controller.state?.cricra),
                      Slider(
                        value: controller.state?.cricra?.toDouble() ?? 0,
                        onChanged: (double newValue) {
                          controller.state?.cricra = newValue.round();
                          controller.somaPercent();
                        },
                        min: 0,
                        max: 100.0,
                      ),
                      sliderTitulo("Debendures", controller.state?.debendures),
                      Slider(
                        value: controller.state?.debendures?.toDouble() ?? 0,
                        onChanged: (double newValue) {
                          controller.state?.debendures = newValue.round();
                          controller.somaPercent();
                        },
                        min: 0,
                        max: 100.0,
                      ),
                      sliderTitulo("BDRs", controller.state?.bdrs),
                      Slider(
                        value: controller.state?.bdrs?.toDouble() ?? 0,
                        onChanged: (double newValue) {
                          controller.state?.bdrs = newValue.round();
                          controller.somaPercent();
                        },
                        min: 0,
                        max: 100.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sliderTitulo(String titulo, int? percent) {
    return SizedBox(
      width: 200,
      child: Text(
        '$titulo  ${percent ?? 0} % ',
        textAlign: TextAlign.center,
      ),
    );
  }
}
