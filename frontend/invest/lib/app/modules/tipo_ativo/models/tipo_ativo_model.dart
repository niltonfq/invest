// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TipoAtivoModel {
  int? id;
  String? nome;
  String? fixavariavel;

  TipoAtivoModel({
    this.id,
    this.nome,
    this.fixavariavel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'fixavariavel': fixavariavel,
    };
  }

  factory TipoAtivoModel.fromMap(Map<String, dynamic> map) {
    return TipoAtivoModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      fixavariavel:
          map['fixavariavel'] != null ? map['fixavariavel'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoAtivoModel.fromJson(String source) =>
      TipoAtivoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<TipoAtivoModel> fromJsonList(Iterable list) {
    return list.map((item) => TipoAtivoModel.fromMap(item)).toList();
  }

  @override
  String toString() => 'TipoAtivoModel(id: $id, nome: $nome, fixavariavel: $fixavariavel)';

  TipoAtivoModel copyWith({
    int? id,
    String? nome,
    String? fixavariavel,
  }) {
    return TipoAtivoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      fixavariavel: fixavariavel ?? this.fixavariavel,
    );
  }

  @override
  bool operator ==(covariant TipoAtivoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome &&
      other.fixavariavel == fixavariavel;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ fixavariavel.hashCode;
}
