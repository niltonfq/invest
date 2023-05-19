import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import 'ativo_controller.dart';

class AtivoPage extends StatelessWidget {
  final AtivoController _controller;
  const AtivoPage({Key? key, required AtivoController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ativo')),
      body: Column(
        children: [
          const SizedBox(height: 15),
          CustomComboDialog(
            fonteDados: _controller.carregaTipoAtivos,
            chave: 'codigo',
            lista: _controller.ativos,
            titulo: 'TipoAtivos',
            onTap: _controller.selecionaTipoAtivos,
            valorAtual: 'PTBR',
            addNovo: () async => await Get.toNamed('/ativos'),
            label: 'TipoAtivo',
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
