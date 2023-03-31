import 'dart:convert';

import '../tipo_ativo/tipo_ativo_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionarioModel {
  int? id;
  TipoAtivoModel? tipoAtivo;
  String? criterio;
  String? pergunta;
  QuestionarioModel({
    this.id,
    this.tipoAtivo,
    this.criterio,
    this.pergunta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipoAtivo': tipoAtivo?.toMap(),
      'criterio': criterio,
      'pergunta': pergunta,
    };
  }

  factory QuestionarioModel.fromMap(Map<String, dynamic> map) {
    return QuestionarioModel(
      id: map['id'] != null ? map['id'] as int : null,
      tipoAtivo: map['tipoAtivo'] != null
          ? TipoAtivoModel.fromMap(map['tipoAtivo'] as Map<String, dynamic>)
          : null,
      criterio: map['criterio'] != null ? map['criterio'] as String : null,
      pergunta: map['pergunta'] != null ? map['pergunta'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionarioModel.fromJson(String source) =>
      QuestionarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<QuestionarioModel> fromJsonList(Iterable list) {
    return list.map((item) => QuestionarioModel.fromMap(item)).toList();
  }

  @override
  String toString() => '$criterio';
}
