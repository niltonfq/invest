// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:commons_deps/commons_deps.dart';

class AtivoViewModel {
  String? codigo;
  double? precoMedio;
  double? precoAtual;
  double? diferenca;
  double? quantidade;
  double? totalInvestido;
  double? patrimonio;
  double? percentual;
  double? percentualCarteira;

  AtivoViewModel({
    this.codigo,
    this.precoMedio,
    this.precoAtual,
    this.diferenca,
    this.quantidade,
    this.totalInvestido,
    this.patrimonio,
    this.percentual,
    this.percentualCarteira,
  });

  get precoMedioFormatado => NumberFormat("##0.00", 'pt_BR').format(precoMedio);
  get precoAtualFormatado => NumberFormat("##0.00", 'pt_BR').format(precoAtual);
  get diferencaFormatada => NumberFormat("##0.00", 'pt_BR').format(diferenca);

  get percentualDiferencaFormatada =>
      "${((((precoAtual ?? 0) / (precoMedio ?? 1)) - 1) * 100).toStringAsFixed(2)} %";

  get totalInvestidoFormatado =>
      NumberFormat("R\$ ##0.00", 'pt_BR').format(totalInvestido);
  get patrimonioFormatado =>
      NumberFormat("R\$ ##0.00", 'pt_BR').format(patrimonio);
  get percentualFormatado => "${percentual?.toStringAsFixed(2)} %";
  get percentualCarteiraFormatado =>
      "${percentualCarteira?.toStringAsFixed(2)} %";

  AtivoViewModel copyWith({
    String? codigo,
    double? precoMedio,
    double? precoAtual,
    double? diferenca,
    double? quantidade,
    double? totalInvestido,
    double? patrimonio,
    double? percentual,
    double? percentualCarteira,
  }) {
    return AtivoViewModel(
      codigo: codigo ?? this.codigo,
      precoMedio: precoMedio ?? this.precoMedio,
      precoAtual: precoAtual ?? this.precoAtual,
      diferenca: diferenca ?? this.diferenca,
      quantidade: quantidade ?? this.quantidade,
      totalInvestido: totalInvestido ?? this.totalInvestido,
      patrimonio: patrimonio ?? this.patrimonio,
      percentual: percentual ?? this.percentual,
      percentualCarteira: percentualCarteira ?? this.percentualCarteira,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'precoMedio': precoMedio,
      'precoAtual': precoAtual,
      'diferenca': diferenca,
      'quantidade': quantidade,
      'totalInvestido': totalInvestido,
      'patrimonio': patrimonio,
      'percentual': percentual,
      'percentualCarteira': percentualCarteira,
    };
  }

  factory AtivoViewModel.fromMap(Map<String, dynamic> map) {
    return AtivoViewModel(
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      precoMedio:
          map['precoMedio'] != null ? map['precoMedio'] as double : null,
      precoAtual:
          map['precoAtual'] != null ? map['precoAtual'] as double : null,
      diferenca: map['diferenca'] != null ? map['diferenca'] as double : null,
      quantidade:
          map['quantidade'] != null ? map['quantidade'] as double : null,
      totalInvestido: map['totalInvestido'] != null
          ? map['totalInvestido'] as double
          : null,
      patrimonio:
          map['patrimonio'] != null ? map['patrimonio'] as double : null,
      percentual:
          map['percentual'] != null ? map['percentual'] as double : null,
      percentualCarteira: map['percentualCarteira'] != null
          ? map['percentualCarteira'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtivoViewModel.fromJson(String source) =>
      AtivoViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AtivoViewModel(codigo: $codigo, precoMedio: $precoMedio, precoAtual: $precoAtual, diferenca: $diferenca, quantidade: $quantidade, totalInvestido: $totalInvestido, patrimonio: $patrimonio, percentual: $percentual, percentualCarteira: $percentualCarteira)';
  }

  @override
  bool operator ==(covariant AtivoViewModel other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.precoMedio == precoMedio &&
        other.precoAtual == precoAtual &&
        other.diferenca == diferenca &&
        other.quantidade == quantidade &&
        other.totalInvestido == totalInvestido &&
        other.patrimonio == patrimonio &&
        other.percentual == percentual &&
        other.percentualCarteira == percentualCarteira;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        precoMedio.hashCode ^
        precoAtual.hashCode ^
        diferenca.hashCode ^
        quantidade.hashCode ^
        totalInvestido.hashCode ^
        patrimonio.hashCode ^
        percentual.hashCode ^
        percentualCarteira.hashCode;
  }
}
