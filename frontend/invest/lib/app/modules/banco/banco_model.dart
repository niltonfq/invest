import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BancoModel {
  int? id;
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
      id: map['id'] != null ? map['id'] as int : null,
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
    return '$nome';
  }
}
