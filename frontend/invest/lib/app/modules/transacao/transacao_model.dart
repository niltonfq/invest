// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../Ativo/ativo_model.dart';
import '../banco/banco_model.dart';
import '../carteira/carteira_model.dart';
import '../dominio/dominio_model.dart';
import '../meta/meta_model.dart';



class TransacaoModel {
  int? id;
  DominioModel? tipooperacao;
  AtivoModel? ativo;
  BancoModel? banco;
  String? data;
  double? quantidade;
  double? valor;
  double? totalLiquido;
  double? custos;
  double? total;
  String? vencimento;
  CarteiraModel? carteira;
  MetaModel? meta;
  DominioModel? reservainvestimento;
  TransacaoModel({
    this.id,
    this.tipooperacao,
    this.ativo,
    this.banco,
    this.data,
    this.quantidade,
    this.valor,
    this.totalLiquido,
    this.custos,
    this.total,
    this.vencimento,
    this.carteira,
    this.meta,
    this.reservainvestimento,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipooperacao': tipooperacao?.toMap(),
      'ativo': ativo?.toMap(),
      'banco': banco?.toMap(),
      'data': data,
      'quantidade': quantidade,
      'valor': valor,
      'totalLiquido': totalLiquido,
      'custos': custos,
      'total': total,
      'vencimento': vencimento,
      'carteira': carteira?.toMap(),
      'meta': meta?.toMap(),
      'reservainvestimento': reservainvestimento?.toMap(),
    };
  }

  factory TransacaoModel.fromMap(Map<String, dynamic> map) {
    return TransacaoModel(
      id: map['id'] != null ? map['id'] as int : null,
      tipooperacao: map['tipooperacao'] != null
          ? DominioModel.fromMap(map['tipooperacao'] as Map<String, dynamic>)
          : null,
      ativo: map['ativo'] != null
          ? AtivoModel.fromMap(map['ativo'] as Map<String, dynamic>)
          : null,
      banco: map['banco'] != null
          ? BancoModel.fromMap(map['banco'] as Map<String, dynamic>)
          : null,
      data: map['data'] != null ? map['data'] as String : null,
      quantidade:
          map['quantidade'] != null ? map['quantidade'] as double : null,
      valor: map['valor'] != null ? map['valor'] as double : null,
      totalLiquido:
          map['totalLiquido'] != null ? map['totalLiquido'] as double : null,
      custos: map['custos'] != null ? map['custos'] as double : null,
      total: map['total'] != null ? map['total'] as double : null,
      vencimento:
          map['vencimento'] != null ? map['vencimento'] as String : null,
      carteira: map['carteira'] != null
          ? CarteiraModel.fromMap(map['carteira'] as Map<String, dynamic>)
          : null,
      meta: map['meta'] != null
          ? MetaModel.fromMap(map['meta'] as Map<String, dynamic>)
          : null,
      reservainvestimento: map['reservainvestimento'] != null
          ? DominioModel.fromMap(
              map['reservainvestimento'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransacaoModel.fromJson(String source) =>
      TransacaoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<TransacaoModel> fromJsonList(Iterable list) {
    return list.map((item) => TransacaoModel.fromMap(item)).toList();
  }

  TransacaoModel copyWith({
    int? id,
    DominioModel? tipooperacao,
    AtivoModel? ativo,
    BancoModel? banco,
    String? data,
    double? quantidade,
    double? valor,
    double? totalLiquido,
    double? custos,
    double? total,
    String? vencimento,
    CarteiraModel? carteira,
    MetaModel? meta,
    DominioModel? reservainvestimento,
  }) {
    return TransacaoModel(
      id: id ?? this.id,
      tipooperacao: tipooperacao ?? this.tipooperacao,
      ativo: ativo ?? this.ativo,
      banco: banco ?? this.banco,
      data: data ?? this.data,
      quantidade: quantidade ?? this.quantidade,
      valor: valor ?? this.valor,
      totalLiquido: totalLiquido ?? this.totalLiquido,
      custos: custos ?? this.custos,
      total: total ?? this.total,
      vencimento: vencimento ?? this.vencimento,
      carteira: carteira ?? this.carteira,
      meta: meta ?? this.meta,
      reservainvestimento: reservainvestimento ?? this.reservainvestimento,
    );
  }

  @override
  String toString() {
    return 'TransacaoModel(id: $id, tipooperacao: $tipooperacao, ativo: $ativo, banco: $banco, data: $data, quantidade: $quantidade, valor: $valor, totalLiquido: $totalLiquido, custos: $custos, total: $total, vencimento: $vencimento, carteira: $carteira, meta: $meta, reservainvestimento: $reservainvestimento)';
  }

  @override
  bool operator ==(covariant TransacaoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tipooperacao == tipooperacao &&
        other.ativo == ativo &&
        other.banco == banco &&
        other.data == data &&
        other.quantidade == quantidade &&
        other.valor == valor &&
        other.totalLiquido == totalLiquido &&
        other.custos == custos &&
        other.total == total &&
        other.vencimento == vencimento &&
        other.carteira == carteira &&
        other.meta == meta &&
        other.reservainvestimento == reservainvestimento;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tipooperacao.hashCode ^
        ativo.hashCode ^
        banco.hashCode ^
        data.hashCode ^
        quantidade.hashCode ^
        valor.hashCode ^
        totalLiquido.hashCode ^
        custos.hashCode ^
        total.hashCode ^
        vencimento.hashCode ^
        carteira.hashCode ^
        meta.hashCode ^
        reservainvestimento.hashCode;
  }
}
