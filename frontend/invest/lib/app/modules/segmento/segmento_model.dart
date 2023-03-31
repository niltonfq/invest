import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SegmentoModel {
  int? id;
  String? nome;
  SegmentoModel({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }

  factory SegmentoModel.fromMap(Map<String, dynamic> map) {
    return SegmentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SegmentoModel.fromJson(String source) =>
      SegmentoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<SegmentoModel> fromJsonList(Iterable list) {
    return list.map((item) => SegmentoModel.fromMap(item)).toList();
  }

  @override
  String toString() => '$nome';
}
