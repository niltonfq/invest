// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../banco/banco_model.dart';
import '../dominio/dominio_model.dart';
import '../segmento/segmento_model.dart';
import '../tipo_ativo/tipo_ativo_model.dart';

class AtivoModel {
  int? id;
  int? status;
  TipoAtivoModel? tipoAtivo;
  String? codigo;
  DominioModel? moeda;
  SegmentoModel? segmento;
  String? observacao;
  double? precoMedio;
  double? nota;
  String? cnpj;
  String? nome;
  BancoModel? banco;
  double? valorAtual;
  double? quantidadeInvestida;
  double? totalInvestido;
  double? aporte;
  double? percentual;
  double? percentualTotal;
  AtivoModel({
    this.id,
    this.status = 1,
    this.tipoAtivo,
    this.codigo,
    this.moeda,
    this.segmento,
    this.observacao,
    this.precoMedio,
    this.nota,
    this.cnpj,
    this.nome,
    this.banco,
    this.valorAtual,
    this.quantidadeInvestida,
    this.totalInvestido,
    this.aporte,
    this.percentual,
    this.percentualTotal,
  });

  static List<AtivoModel> fromJsonList(Iterable list) {
    return list.map((item) => AtivoModel.fromMap(item)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'tipoAtivo': tipoAtivo?.toMap(),
      'codigo': codigo,
      'moeda': moeda?.toMap(),
      'segmento': segmento?.toMap(),
      'observacao': observacao,
      'precoMedio': precoMedio,
      'nota': nota,
      'cnpj': cnpj,
      'nome': nome,
      'banco': banco?.toMap(),
      'valorAtual': valorAtual,
      'quantidadeInvestida': quantidadeInvestida,
      'totalInvestido': totalInvestido,
      'aporte': aporte,
      'percentual': percentual,
      'percentualTotal': percentualTotal,
    };
  }

  factory AtivoModel.fromMap(Map<String, dynamic> map) {
    return AtivoModel(
      id: map['id']?.toInt(),
      status: map['status']?.toInt(),
      tipoAtivo: map['tipoAtivo'] != null
          ? TipoAtivoModel.fromMap(map['tipoAtivo'])
          : null,
      codigo: map['codigo'],
      moeda: map['moeda'] != null ? DominioModel.fromMap(map['moeda']) : null,
      segmento: map['segmento'] != null
          ? SegmentoModel.fromMap(map['segmento'])
          : null,
      observacao: map['observacao'],
      precoMedio: map['precoMedio']?.toDouble(),
      nota: map['nota']?.toDouble(),
      cnpj: map['cnpj'],
      nome: map['nome'],
      banco: map['banco'] != null ? BancoModel.fromMap(map['banco']) : null,
      valorAtual: map['valorAtual']?.toDouble(),
      quantidadeInvestida: map['quantidadeInvestida']?.toDouble(),
      totalInvestido: map['totalInvestido']?.toDouble(),
      aporte: map['aporte']?.toDouble(),
      percentual: map['percentual']?.toDouble(),
      percentualTotal: map['percentualTotal']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AtivoModel.fromJson(String source) =>
      AtivoModel.fromMap(json.decode(source));

  @override
  String toString() => '$codigo';
}
