import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarteiraModel {
  int? id;
  String? nome;
  CarteiraModel({
    this.id,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
    };
  }

  factory CarteiraModel.fromMap(Map<String, dynamic> map) {
    return CarteiraModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarteiraModel.fromJson(String source) =>
      CarteiraModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<CarteiraModel> fromJsonList(Iterable list) {
    return list.map((item) => CarteiraModel.fromMap(item)).toList();
  }

  @override
  String toString() => '$nome';
}
