import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SegmentoModel {
  String? id;
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
      id: map['id'] != null ? map['id'] as String : null,
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
  String toString() => 'SegmentoModel(id: $id, nome: $nome)';

  SegmentoModel copyWith({
    String? id,
    String? nome,
  }) {
    return SegmentoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  @override
  bool operator ==(covariant SegmentoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
