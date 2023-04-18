// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../banco/banco_model.dart';
import '../../segmento/segmento_model.dart';

class AtivoModel {
  String? id;
  String? tipoAtivo;
  String? codigo;
  String? moeda;
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
    return <String, dynamic>{
      'id': id,
      'tipoAtivo': tipoAtivo,
      'codigo': codigo,
      'moeda': moeda,
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
      id: map['id'] != null ? map['id'] as String : null,
      tipoAtivo: map['tipoAtivo'] != null ? map['tipoAtivo'] as String : null,
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      moeda: map['moeda'] != null ? map['moeda'] as String : null,
      segmento: map['segmento'] != null ? SegmentoModel.fromMap(map['segmento'] as Map<String,dynamic>) : null,
      observacao: map['observacao'] != null ? map['observacao'] as String : null,
      precoMedio: map['precoMedio'] != null ? map['precoMedio'] as double : null,
      nota: map['nota'] != null ? map['nota'] as double : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      banco: map['banco'] != null ? BancoModel.fromMap(map['banco'] as Map<String,dynamic>) : null,
      valorAtual: map['valorAtual'] != null ? map['valorAtual'] as double : null,
      quantidadeInvestida: map['quantidadeInvestida'] != null ? map['quantidadeInvestida'] as double : null,
      totalInvestido: map['totalInvestido'] != null ? map['totalInvestido'] as double : null,
      aporte: map['aporte'] != null ? map['aporte'] as double : null,
      percentual: map['percentual'] != null ? map['percentual'] as double : null,
      percentualTotal: map['percentualTotal'] != null ? map['percentualTotal'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtivoModel.fromJson(String source) => AtivoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AtivoModel(id: $id, tipoAtivo: $tipoAtivo, codigo: $codigo, moeda: $moeda, segmento: $segmento, observacao: $observacao, precoMedio: $precoMedio, nota: $nota, cnpj: $cnpj, nome: $nome, banco: $banco, valorAtual: $valorAtual, quantidadeInvestida: $quantidadeInvestida, totalInvestido: $totalInvestido, aporte: $aporte, percentual: $percentual, percentualTotal: $percentualTotal)';
  }

  AtivoModel copyWith({
    String? id,
    String? tipoAtivo,
    String? codigo,
    String? moeda,
    SegmentoModel? segmento,
    String? observacao,
    double? precoMedio,
    double? nota,
    String? cnpj,
    String? nome,
    BancoModel? banco,
    double? valorAtual,
    double? quantidadeInvestida,
    double? totalInvestido,
    double? aporte,
    double? percentual,
    double? percentualTotal,
  }) {
    return AtivoModel(
      id: id ?? this.id,
      tipoAtivo: tipoAtivo ?? this.tipoAtivo,
      codigo: codigo ?? this.codigo,
      moeda: moeda ?? this.moeda,
      segmento: segmento ?? this.segmento,
      observacao: observacao ?? this.observacao,
      precoMedio: precoMedio ?? this.precoMedio,
      nota: nota ?? this.nota,
      cnpj: cnpj ?? this.cnpj,
      nome: nome ?? this.nome,
      banco: banco ?? this.banco,
      valorAtual: valorAtual ?? this.valorAtual,
      quantidadeInvestida: quantidadeInvestida ?? this.quantidadeInvestida,
      totalInvestido: totalInvestido ?? this.totalInvestido,
      aporte: aporte ?? this.aporte,
      percentual: percentual ?? this.percentual,
      percentualTotal: percentualTotal ?? this.percentualTotal,
    );
  }

  @override
  bool operator ==(covariant AtivoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.tipoAtivo == tipoAtivo &&
      other.codigo == codigo &&
      other.moeda == moeda &&
      other.segmento == segmento &&
      other.observacao == observacao &&
      other.precoMedio == precoMedio &&
      other.nota == nota &&
      other.cnpj == cnpj &&
      other.nome == nome &&
      other.banco == banco &&
      other.valorAtual == valorAtual &&
      other.quantidadeInvestida == quantidadeInvestida &&
      other.totalInvestido == totalInvestido &&
      other.aporte == aporte &&
      other.percentual == percentual &&
      other.percentualTotal == percentualTotal;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tipoAtivo.hashCode ^
      codigo.hashCode ^
      moeda.hashCode ^
      segmento.hashCode ^
      observacao.hashCode ^
      precoMedio.hashCode ^
      nota.hashCode ^
      cnpj.hashCode ^
      nome.hashCode ^
      banco.hashCode ^
      valorAtual.hashCode ^
      quantidadeInvestida.hashCode ^
      totalInvestido.hashCode ^
      aporte.hashCode ^
      percentual.hashCode ^
      percentualTotal.hashCode;
  }
}
