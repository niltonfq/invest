import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BancoModel {
  String? id;
  String? nome;
  String? numero;
  String? cnpj;
  BancoModel({
    this.id,
    this.nome,
    this.numero,
    this.cnpj,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'numero': numero,
      'cnpj': cnpj,
    };
  }

  factory BancoModel.fromMap(Map<String, dynamic> map) {
    return BancoModel(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BancoModel.fromJson(String source) =>
      BancoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<BancoModel> fromJsonList(Iterable list) {
    return list.map((item) => BancoModel.fromMap(item)).toList();
  }

  @override
  String toString() {
    return 'BancoModel(id: $id, nome: $nome, numero: $numero, cnpj: $cnpj)';
  }

  BancoModel copyWith({
    String? id,
    String? nome,
    String? numero,
    String? cnpj,
  }) {
    return BancoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numero: numero ?? this.numero,
      cnpj: cnpj ?? this.cnpj,
    );
  }

  @override
  bool operator ==(covariant BancoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome &&
      other.numero == numero &&
      other.cnpj == cnpj;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nome.hashCode ^
      numero.hashCode ^
      cnpj.hashCode;
  }
}
