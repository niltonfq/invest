// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../Ativo/models/ativo_model.dart';



class SugestaoInvestimentoModel {
  String tipo;
  int tipoAtivo;
  double aporte;
  List<AtivoModel>? ativos;
  SugestaoInvestimentoModel({
    required this.tipo,
    required this.tipoAtivo,
    required this.aporte,
    this.ativos,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'tipoAtivo': tipoAtivo,
      'aporte': aporte,
      'ativos': ativos?.map((x) => x.toMap()).toList(),
    };
  }

  factory SugestaoInvestimentoModel.fromMap(Map<String, dynamic> map) {
    return SugestaoInvestimentoModel(
      tipo: map['tipo'] ?? '',
      tipoAtivo: map['tipoAtivo']?.toInt() ?? 0,
      aporte: map['aporte']?.toDouble() ?? 0.0,
      ativos: map['ativos'] != null ? List<AtivoModel>.from(map['ativos']?.map((x) => AtivoModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SugestaoInvestimentoModel.fromJson(String source) => SugestaoInvestimentoModel.fromMap(json.decode(source));
}
