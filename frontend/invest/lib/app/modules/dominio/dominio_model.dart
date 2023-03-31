import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DominioModel {
  int? id;
  String? tabela;
  String? campo;
  String? valor;
  String? descricao;
  int? ordem;
  DominioModel({
    this.id,
    this.tabela,
    this.campo,
    this.valor,
    this.descricao,
    this.ordem,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tabela': tabela,
      'campo': campo,
      'valor': valor,
      'descricao': descricao,
      'ordem': ordem,
    };
  }

  factory DominioModel.fromMap(Map<String, dynamic> map) {
    return DominioModel(
      id: map['id'] != null ? map['id'] as int : null,
      tabela: map['tabela'] != null ? map['tabela'] as String : null,
      campo: map['campo'] != null ? map['campo'] as String : null,
      valor: map['valor'] != null ? map['valor'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      ordem: map['ordem'] != null ? map['ordem'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DominioModel.fromJson(String source) =>
      DominioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<DominioModel> fromJsonList(Iterable list) {
    return list.map((item) => DominioModel.fromMap(item)).toList();
  }

  @override
  String toString() {
    return '$descricao';
  }
}
