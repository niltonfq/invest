import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'percentualinvestimento_controller.dart';

class PercentualinvestimentoPage
    extends GetView<PercentualinvestimentoController> {
  static const double tamanho = 400;

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
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      sliderComp(
                        'Ações',
                        controller.state?.acoes,
                        controller.setAcoes,
                      ),
                      sliderComp(
                        'Fundos Imobiliários',
                        controller.state?.fundosImobiliarios,
                        controller.setFII,
                      ),
                      sliderComp(
                        'Fundos Investimento',
                        controller.state?.fundosInvestimentos,
                        controller.setFundosInvestimentos,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      sliderComp(
                        'Fiagro',
                        controller.state?.fiagro,
                        controller.setFiagro,
                      ),
                      sliderComp(
                        'Stocks',
                        controller.state?.stocks,
                        controller.setStocks,
                      ),
                      sliderComp(
                        'Reits',
                        controller.state?.reits,
                        controller.setReits,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      sliderComp(
                        'ETFs Nacionais',
                        controller.state?.etfsNacionais,
                        controller.setEtfsNacionais,
                      ),
                      sliderComp(
                        'ETFs Internacionais',
                        controller.state?.etfsInternacionais,
                        controller.setEtfsInternacionais,
                      ),
                      sliderComp(
                        'Criptomoedas',
                        controller.state?.criptoMoedas,
                        controller.setCriptomoedas,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      sliderComp(
                        'Tesouro Direto',
                        controller.state?.tesouroDireto,
                        controller.setTesouroDireto,
                      ),
                      sliderComp(
                        'CDB',
                        controller.state?.cdb,
                        controller.setCDB,
                      ),
                      sliderComp(
                        'LCI e LCA',
                        controller.state?.lcilca,
                        controller.setLcilca,
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      sliderComp(
                        'Cri e Cra',
                        controller.state?.cricra,
                        controller.setCricra,
                      ),
                      sliderComp(
                        'Debendures',
                        controller.state?.debendures,
                        controller.setDebendures,
                      ),
                      sliderComp(
                        'BDRs',
                        controller.state?.bdrs,
                        controller.setBDRs,
                      ),
                    ],
                  ),
                  SizedBox(
                      width: tamanho,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
                        child: CustomButton(
                          child: Text(
                              'Salvar ${controller.percentualTotal.value}%'),
                          onPressed: controller.salvar,
                        ),
                      ))
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

  Widget sliderBarra(int? percent, Function callback) {
    percent ??= 0;
    return SizedBox(
      width: tamanho,
      child: Slider(
        value: percent.toDouble(),
        onChanged: (double newValue) {
          callback(newValue);
          controller.somaPercent();
        },
        min: 0,
        max: 100.0,
      ),
    );
  }

  Widget sliderComp(String titulo, int? percent, Function callback) {
    return Column(
      children: [
        sliderTitulo(titulo, percent),
        sliderBarra(percent, callback),
      ],
    );
  }
}
