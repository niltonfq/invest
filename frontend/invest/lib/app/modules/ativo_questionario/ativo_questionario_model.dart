import 'dart:convert';

import '../Ativo/ativo_model.dart';
import '../questionario/questionario_model.dart';



// ignore_for_file: public_member_api_docs, sort_constructors_first
class AtivoQuestionarioModel {
  int? id;
  AtivoModel? ativo;
  QuestionarioModel? questionario;
  
  String? levantamento;
  int? nota;
  AtivoQuestionarioModel({
    this.id,
    this.ativo,
    this.questionario,
    this.levantamento,
    this.nota,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ativo': ativo?.toMap(),
      'questionario': questionario?.toMap(),
      'levantamento': levantamento,
      'nota': nota,
    };
  }

  factory AtivoQuestionarioModel.fromMap(Map<String, dynamic> map) {
    return AtivoQuestionarioModel(
      id: map['id'] != null ? map['id'] as int : null,
      ativo: map['ativo'] != null ? AtivoModel.fromMap(map['ativo'] as Map<String,dynamic>) : null,
      questionario: map['questionario'] != null ? QuestionarioModel.fromMap(map['questionario'] as Map<String,dynamic>) : null,
      levantamento: map['levantamento'] != null ? map['levantamento'] as String : null,
      nota: map['nota'] != null ? map['nota'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtivoQuestionarioModel.fromJson(String source) =>
      AtivoQuestionarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<AtivoQuestionarioModel> fromJsonList(Iterable list) {
    return list.map((item) => AtivoQuestionarioModel.fromMap(item)).toList();
  }

  

  AtivoQuestionarioModel copyWith({
    int? id,
    AtivoModel? ativo,
    QuestionarioModel? questionario,
    String? levantamento,
    int? nota,
  }) {
    return AtivoQuestionarioModel(
      id: id ?? this.id,
      ativo: ativo ?? this.ativo,
      questionario: questionario ?? this.questionario,
      levantamento: levantamento ?? this.levantamento,
      nota: nota ?? this.nota,
    );
  }

  @override
  String toString() {
    return 'AtivoQuestionarioModel(id: $id, ativo: $ativo, questionario: $questionario, levantamento: $levantamento, nota: $nota)';
  }

  @override
  bool operator ==(covariant AtivoQuestionarioModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.ativo == ativo &&
      other.questionario == questionario &&
      other.levantamento == levantamento &&
      other.nota == nota;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      ativo.hashCode ^
      questionario.hashCode ^
      levantamento.hashCode ^
      nota.hashCode;
  }
}
