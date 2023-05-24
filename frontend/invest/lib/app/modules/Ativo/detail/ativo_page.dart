import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/custom_combo_dialog.dart';
import 'package:commons_design_system/widgets/commons/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:invest/app/enums/tipoativo.dart';

import 'ativo_controller.dart';

class AtivoPage extends StatelessWidget {
  final AtivoController _controller;
  final dropValue = ValueNotifier('');
  final dropOpcoes = TipoAtivos.values.map((e) => e.value).toList();
  //[
  //   'Ações',
  //   'Fundos_Imobiliários',
  //   'Fundos_Investimentos',
  //   'Fiagro',
  //   'Stocks',
  //   'Reits',
  //   'ETFs_Nacionais',
  //   'ETFs_Internacionais',
  //   'Criptomoedas',
  //   'Tesouro_Direto',
  //   'CDB',
  //   'LCI_e_LCA',
  //   'Cri_e_Cra',
  //   'Debendures',
  //   'BDRs'
  // ];

  AtivoPage({Key? key, required AtivoController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ativo')),
      body: Column(
        children: [
          const SizedBox(height: 15),
          ValueListenableBuilder(
            valueListenable: dropValue,
            builder: (BuildContext context, String value, _) {
              return DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Escolha o Tipo de Ativo'),
                value: (value.isEmpty) ? null : value,
                items: dropOpcoes
                    .map(
                      (op) => DropdownMenuItem(
                        child: Text(op),
                        value: op,
                      ),
                    )
                    .toList(),
                onChanged: (escolha) => dropValue.value = escolha.toString(),
              );
            },
          ),
          const SizedBox(height: 15),
          AbsTextFormField(
            titulo: 'Ticket',
            controller: _controller.codigoTEC,
            validator: Validatorless.required('Campo Obrigatório'),
            onFieldSubmitted: (_) async {
              await _controller.salvar();
              clearFields();
            },
          ),
          const SizedBox(height: 15),
          CustomComboDialog(
            fonteDados: _controller.carregaBancos,
            chave: 'nome;numero',
            lista: _controller.bancos,
            titulo: 'Bancos',
            onTap: _controller.selecionaBanco,
            valorAtual: _controller.state?.banco?.nome ?? '',
            addNovo: () async => await Get.toNamed('/bancos'),
            label: 'Banco',
          ),
          const SizedBox(height: 15),
          CustomComboDialog(
            fonteDados: _controller.carregaSegmento,
            chave: 'nome;',
            lista: _controller.segmentos,
            titulo: 'Segmento',
            onTap: _controller.selecionaSegmento,
            valorAtual: _controller.state?.segmento?.nome ?? '',
            addNovo: () async => await Get.toNamed('/segmentos'),
            label: 'Segmento',
          ),
        ],
      ),
    );
  }

  void clearFields() {
    _controller.nomeTEC.text = '';
    _controller.cnpjTEC.text = '';
    _controller.codigoTEC.text = '';
    _controller.observacaoTEC.text = '';

    _controller.precoTEC.text = '';

    // _controller.state(AtivoModel(
    //     moeda: _controller.state.moeda,
    //     tipoAtivo: _controller.obj.value.tipoAtivo,
    //     banco: _controller.state?.banco));
  }
}
