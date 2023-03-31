import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MetaModel {
  int? id;
  String? nome;
  double? montante;
  MetaModel({
    this.id,
    this.nome,
    this.montante,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'montante': montante,
    };
  }

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      montante: map['montante'] != null ? map['montante'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaModel.fromJson(String source) =>
      MetaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<MetaModel> fromJsonList(Iterable list) {
    return list.map((item) => MetaModel.fromMap(item)).toList();
  }

  @override
  String toString() => '$nome';
}
