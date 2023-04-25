import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionarioModel {
  int? id;
  String? tipoAtivo;
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
      'tipoAtivo': tipoAtivo,
      'criterio': criterio,
      'pergunta': pergunta,
    };
  }

  factory QuestionarioModel.fromMap(Map<String, dynamic> map) {
    return QuestionarioModel(
      id: map['id'] != null ? map['id'] as int : null,
      tipoAtivo: map['tipoAtivo'] != null ? map['tipoAtivo'] as String : null,
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
  String toString() {
    return 'QuestionarioModel(id: $id, tipoAtivo: $tipoAtivo, criterio: $criterio, pergunta: $pergunta)';
  }

  QuestionarioModel copyWith({
    int? id,
    String? tipoAtivo,
    String? criterio,
    String? pergunta,
  }) {
    return QuestionarioModel(
      id: id ?? this.id,
      tipoAtivo: tipoAtivo ?? this.tipoAtivo,
      criterio: criterio ?? this.criterio,
      pergunta: pergunta ?? this.pergunta,
    );
  }

  @override
  bool operator ==(covariant QuestionarioModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.tipoAtivo == tipoAtivo &&
      other.criterio == criterio &&
      other.pergunta == pergunta;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tipoAtivo.hashCode ^
      criterio.hashCode ^
      pergunta.hashCode;
  }
}
