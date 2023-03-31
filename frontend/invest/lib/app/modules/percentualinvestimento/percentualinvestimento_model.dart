// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PercentualinvestimentoModel {
  int? id;
  int? rendaFixa;
  int? criptoMoedas;
  int? acoesNacionais;
  int? acoesInternacionais;
  int? fundosImobiliarios;
  int? reits;
  PercentualinvestimentoModel({
    this.id,
    this.rendaFixa,
    this.criptoMoedas,
    this.acoesNacionais,
    this.acoesInternacionais,
    this.fundosImobiliarios,
    this.reits,
  });
  

  static List<PercentualinvestimentoModel> fromJsonList(Iterable list) {
    return list
        .map((item) => PercentualinvestimentoModel.fromMap(item))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rendaFixa': rendaFixa,
      'criptoMoedas': criptoMoedas,
      'acoesNacionais': acoesNacionais,
      'acoesInternacionais': acoesInternacionais,
      'fundosImobiliarios': fundosImobiliarios,
      'reits': reits,
    };
  }

  factory PercentualinvestimentoModel.fromMap(Map<String, dynamic> map) {
    return PercentualinvestimentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      rendaFixa: map['rendaFixa'] != null ? map['rendaFixa'] as int : null,
      criptoMoedas: map['criptoMoedas'] != null ? map['criptoMoedas'] as int : null,
      acoesNacionais: map['acoesNacionais'] != null ? map['acoesNacionais'] as int : null,
      acoesInternacionais: map['acoesInternacionais'] != null ? map['acoesInternacionais'] as int : null,
      fundosImobiliarios: map['fundosImobiliarios'] != null ? map['fundosImobiliarios'] as int : null,
      reits: map['reits'] != null ? map['reits'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PercentualinvestimentoModel.fromJson(String source) => PercentualinvestimentoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
