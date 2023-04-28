// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../Ativo/models/ativo_model.dart';



class CarteiraSegmentoModel {
  String? tipo;
  double? quantidade;
  double? total;
  double? percentual;
  List<AtivoModel>? ativos;
  CarteiraSegmentoModel({
    this.tipo,
    this.quantidade,
    this.total,
    this.percentual,
    this.ativos,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'quantidade': quantidade,
      'total': total,
      'percentual': percentual,
      'ativos': ativos?.map((x) => x.toMap()).toList(),
    };
  }

  factory CarteiraSegmentoModel.fromMap(Map<String, dynamic> map) {
    return CarteiraSegmentoModel(
      tipo: map['tipo'],
      quantidade: map['quantidade']?.toDouble(),
      total: map['total']?.toDouble(),
      percentual: map['percentual']?.toDouble(),
      ativos: map['ativos'] != null
          ? List<AtivoModel>.from(
              map['ativos']?.map((x) => AtivoModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarteiraSegmentoModel.fromJson(String source) =>
      CarteiraSegmentoModel.fromMap(json.decode(source));

  static List<CarteiraSegmentoModel> fromJsonList(Iterable list) {
    return list.map((item) => CarteiraSegmentoModel.fromMap(item)).toList();
  }
}
