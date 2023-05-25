import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/buttons/custom_button.dart';
import 'package:commons_design_system/widgets/commons/custom_combo_dialog.dart';
import 'package:commons_design_system/widgets/commons/custom_text_form_field.dart';
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
      body: _controller.obx(
        (state) {
          return SingleChildScrollView(
            child: Form(
              key: _controller.form,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  //Combo TipoAtivo
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Escolha o Tipo de Ativo'),
                    value: _controller.state?.tipoAtivo,
                    onChanged: (value) {
                      _controller.state?.tipoAtivo = value.toString();
                      _controller.atualizarTela();
                    },
                    items: _controller.dropOpcoesTA
                        .map(
                          (op) => DropdownMenuItem(
                            child: Text(op),
                            value: op,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Ticket',
                    controller: _controller.codigoTEC,
                    validator: Validatorless.required('Campo Obrigatório'),
                    onFieldSubmitted: (_) async {
                      await _controller.salvar();
                    },
                  ),
                  const SizedBox(height: 15),
                  //Combo Moeda
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Escolha a Moeda'),
                    value: _controller.state?.moeda,
                    onChanged: (value) {
                      _controller.state?.moeda = value.toString();
                      _controller.atualizarTela();
                    },
                    items: _controller.dropOpcoesMO
                        .map(
                          (mo) => DropdownMenuItem(
                            child: Text(mo),
                            value: mo,
                          ),
                        )
                        .toList(),
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
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Observação',
                    controller: _controller.observacaoTEC,
                    onFieldSubmitted: (_) async {
                      await _controller.salvar();
                      clearFields();
                    },
                  ),
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Preço Medio',
                    enabled: false,
                    initialValue:
                        _controller.state?.precoMedio?.toStringAsFixed(2) ??
                            '0.0',
                  ),
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Nota',
                    enabled: false,
                    initialValue:
                        _controller.state?.nota?.toStringAsFixed(2) ?? '0.0',
                  ),
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Cnpj',
                    controller: _controller.cnpjTEC,
                    validator: Validatorless.cnpj('Campo Obrigatório'),
                    onFieldSubmitted: (_) async {
                      await _controller.salvar();
                      clearFields();
                    },
                  ),
                  const SizedBox(height: 15),
                  AbsTextFormField(
                    titulo: 'Razão Social',
                    controller: _controller.nomeTEC,
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

                  CustomButton(
                    onPressed: () async {
                      await _controller.salvar();
                      _controller.atualizarTela();
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void clearFields() {
    _controller.nomeTEC.text = '';
    _controller.cnpjTEC.text = '';
    _controller.codigoTEC.text = '';
    _controller.observacaoTEC.text = '';
  }
}
