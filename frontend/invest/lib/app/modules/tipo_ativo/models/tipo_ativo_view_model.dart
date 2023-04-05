// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:commons_deps/commons_deps.dart';
import 'package:flutter/foundation.dart';

import '../../Ativo/models/ativo_view_model.dart';

class TipoAtivoViewModel {
  String? tipoAtivo;
  int? quantidade;
  double? percentual;
  double? total;
  List<AtivoViewModel>? ativos;

  TipoAtivoViewModel({
    this.tipoAtivo,
    this.quantidade,
    this.percentual,
    this.total,
    this.ativos,
  });

  get totalFormatado => NumberFormat("R\$ ##0.00", 'pt_BR').format(total);
  get percentualFormatado => "${percentual?.toStringAsFixed(2)} %";

  TipoAtivoViewModel copyWith({
    String? tipoAtivo,
    int? quantidade,
    double? percentual,
    double? total,
    List<AtivoViewModel>? ativos,
  }) {
    return TipoAtivoViewModel(
      tipoAtivo: tipoAtivo ?? this.tipoAtivo,
      quantidade: quantidade ?? this.quantidade,
      percentual: percentual ?? this.percentual,
      total: total ?? this.total,
      ativos: ativos ?? this.ativos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipoAtivo': tipoAtivo,
      'quantidade': quantidade,
      'percentual': percentual,
      'total': total,
      'ativos': ativos?.map((x) => x.toMap()).toList(),
    };
  }

  factory TipoAtivoViewModel.fromMap(Map<String, dynamic> map) {
    return TipoAtivoViewModel(
      tipoAtivo: map['tipoAtivo'] != null ? map['tipoAtivo'] as String : null,
      quantidade: map['quantidade'] != null ? map['quantidade'] as int : null,
      percentual:
          map['percentual'] != null ? map['percentual'] as double : null,
      total: map['total'] != null ? map['total'] as double : null,
      ativos: map['ativos'] != null
          ? List<AtivoViewModel>.from(
              (map['ativos'] as List<int>).map<AtivoViewModel?>(
                (x) => AtivoViewModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoAtivoViewModel.fromJson(String source) =>
      TipoAtivoViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoAtivoViewModel(tipoAtivo: $tipoAtivo, quantidade: $quantidade, percentual: $percentual, total: $total, ativos: $ativos)';
  }

  @override
  bool operator ==(covariant TipoAtivoViewModel other) {
    if (identical(this, other)) return true;

    return other.tipoAtivo == tipoAtivo &&
        other.quantidade == quantidade &&
        other.percentual == percentual &&
        other.total == total &&
        listEquals(other.ativos, ativos);
  }

  @override
  int get hashCode {
    return tipoAtivo.hashCode ^
        quantidade.hashCode ^
        percentual.hashCode ^
        total.hashCode ^
        ativos.hashCode;
  }
}
