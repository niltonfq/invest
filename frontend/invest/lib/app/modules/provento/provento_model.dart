// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../Ativo/models/ativo_model.dart';
import '../banco/banco_model.dart';
import '../dominio/dominio_model.dart';



class ProventoModel {
  int? id;
  DominioModel? tipoprovento;
  AtivoModel? ativo;
  BancoModel? banco;
  String? data;
  double? valor;
  double? quantidade;
  double? total;
  ProventoModel({
    this.id,
    this.tipoprovento,
    this.ativo,
    this.banco,
    this.data,
    this.valor,
    this.quantidade,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipoprovento': tipoprovento?.toMap(),
      'ativo': ativo?.toMap(),
      'banco': banco?.toMap(),
      'data': data,
      'valor': valor,
      'quantidade': quantidade,
      'total': total,
    };
  }

  factory ProventoModel.fromMap(Map<String, dynamic> map) {
    return ProventoModel(
      id: map['id'] != null ? map['id'] as int : null,
      tipoprovento: map['tipoprovento'] != null
          ? DominioModel.fromMap(map['tipoprovento'] as Map<String, dynamic>)
          : null,
      ativo: map['ativo'] != null
          ? AtivoModel.fromMap(map['ativo'] as Map<String, dynamic>)
          : null,
      banco: map['banco'] != null
          ? BancoModel.fromMap(map['banco'] as Map<String, dynamic>)
          : null,
      data:
          map['data'] != null ? map['data'] as String : null,
      valor:
          map['valor'] != null ? map['valor'] as double : null,
      quantidade:
          map['quantidade'] != null ? map['quantidade'] as double : null,
      total:
          map['total'] != null ? map['total'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProventoModel.fromJson(String source) =>
      ProventoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$tipoprovento';
  }
}
