// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PercentualinvestimentoModel {
  String? id;
  int? acoes;
  int? fundosImobiliarios;
  int? fundosInvestimentos;
  int? fiagro;
  int? stocks;
  int? reits;
  int? etfsNacionais;
  int? etfsInternacionais;
  int? criptoMoedas;
  int? tesouroDireto;
  int? cdb;
  int? lcilca;
  int? cricra;
  int? debendures;
  int? bdrs;
	
  PercentualinvestimentoModel({
    this.id,
    this.acoes,
    this.fundosImobiliarios,
    this.fundosInvestimentos,
    this.fiagro,
    this.stocks,
    this.reits,
    this.etfsNacionais,
    this.etfsInternacionais,
    this.criptoMoedas,
    this.tesouroDireto,
    this.cdb,
    this.lcilca,
    this.cricra,
    this.debendures,
    this.bdrs,
  });
  

  static List<PercentualinvestimentoModel> fromJsonList(Iterable list) {
    return list
        .map((item) => PercentualinvestimentoModel.fromMap(item))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'acoes': acoes,
      'fundosImobiliarios': fundosImobiliarios,
      'fundosInvestimentos': fundosInvestimentos,
      'fiagro': fiagro,
      'stocks': stocks,
      'reits': reits,
      'etfsNacionais': etfsNacionais,
      'etfsInternacionais': etfsInternacionais,
      'criptoMoedas': criptoMoedas,
      'tesouroDireto': tesouroDireto,
      'cdb': cdb,
      'lcilca': lcilca,
      'cricra': cricra,
      'debendures': debendures,
      'bdrs': bdrs,
    };
  }

  factory PercentualinvestimentoModel.fromMap(Map<String, dynamic> map) {
    return PercentualinvestimentoModel(
      id: map['id'] != null ? map['id'] as String : null,
      acoes: map['acoes'] != null ? map['acoes'] as int : null,
      fundosImobiliarios: map['fundosImobiliarios'] != null ? map['fundosImobiliarios'] as int : null,
      fundosInvestimentos: map['fundosInvestimentos'] != null ? map['fundosInvestimentos'] as int : null,
      fiagro: map['fiagro'] != null ? map['fiagro'] as int : null,
      stocks: map['stocks'] != null ? map['stocks'] as int : null,
      reits: map['reits'] != null ? map['reits'] as int : null,
      etfsNacionais: map['etfsNacionais'] != null ? map['etfsNacionais'] as int : null,
      etfsInternacionais: map['etfsInternacionais'] != null ? map['etfsInternacionais'] as int : null,
      criptoMoedas: map['criptoMoedas'] != null ? map['criptoMoedas'] as int : null,
      tesouroDireto: map['tesouroDireto'] != null ? map['tesouroDireto'] as int : null,
      cdb: map['cdb'] != null ? map['cdb'] as int : null,
      lcilca: map['lcilca'] != null ? map['lcilca'] as int : null,
      cricra: map['cricra'] != null ? map['cricra'] as int : null,
      debendures: map['debendures'] != null ? map['debendures'] as int : null,
      bdrs: map['bdrs'] != null ? map['bdrs'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PercentualinvestimentoModel.fromJson(String source) => PercentualinvestimentoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PercentualinvestimentoModel copyWith({
    String? id,
    int? acoes,
    int? fundosImobiliarios,
    int? fundosInvestimentos,
    int? fiagro,
    int? stocks,
    int? reits,
    int? etfsNacionais,
    int? etfsInternacionais,
    int? criptoMoedas,
    int? tesouroDireto,
    int? cdb,
    int? lcilca,
    int? cricra,
    int? debendures,
    int? bdrs,
  }) {
    return PercentualinvestimentoModel(
      id: id ?? this.id,
      acoes: acoes ?? this.acoes,
      fundosImobiliarios: fundosImobiliarios ?? this.fundosImobiliarios,
      fundosInvestimentos: fundosInvestimentos ?? this.fundosInvestimentos,
      fiagro: fiagro ?? this.fiagro,
      stocks: stocks ?? this.stocks,
      reits: reits ?? this.reits,
      etfsNacionais: etfsNacionais ?? this.etfsNacionais,
      etfsInternacionais: etfsInternacionais ?? this.etfsInternacionais,
      criptoMoedas: criptoMoedas ?? this.criptoMoedas,
      tesouroDireto: tesouroDireto ?? this.tesouroDireto,
      cdb: cdb ?? this.cdb,
      lcilca: lcilca ?? this.lcilca,
      cricra: cricra ?? this.cricra,
      debendures: debendures ?? this.debendures,
      bdrs: bdrs ?? this.bdrs,
    );
  }

  @override
  String toString() {
    return 'PercentualinvestimentoModel(id: $id, acoes: $acoes, fundosImobiliarios: $fundosImobiliarios, fundosInvestimentos: $fundosInvestimentos, fiagro: $fiagro, stocks: $stocks, reits: $reits, etfsNacionais: $etfsNacionais, etfsInternacionais: $etfsInternacionais, criptoMoedas: $criptoMoedas, tesouroDireto: $tesouroDireto, cdb: $cdb, lcilca: $lcilca, cricra: $cricra, debendures: $debendures, bdrs: $bdrs)';
  }

  @override
  bool operator ==(covariant PercentualinvestimentoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.acoes == acoes &&
      other.fundosImobiliarios == fundosImobiliarios &&
      other.fundosInvestimentos == fundosInvestimentos &&
      other.fiagro == fiagro &&
      other.stocks == stocks &&
      other.reits == reits &&
      other.etfsNacionais == etfsNacionais &&
      other.etfsInternacionais == etfsInternacionais &&
      other.criptoMoedas == criptoMoedas &&
      other.tesouroDireto == tesouroDireto &&
      other.cdb == cdb &&
      other.lcilca == lcilca &&
      other.cricra == cricra &&
      other.debendures == debendures &&
      other.bdrs == bdrs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      acoes.hashCode ^
      fundosImobiliarios.hashCode ^
      fundosInvestimentos.hashCode ^
      fiagro.hashCode ^
      stocks.hashCode ^
      reits.hashCode ^
      etfsNacionais.hashCode ^
      etfsInternacionais.hashCode ^
      criptoMoedas.hashCode ^
      tesouroDireto.hashCode ^
      cdb.hashCode ^
      lcilca.hashCode ^
      cricra.hashCode ^
      debendures.hashCode ^
      bdrs.hashCode;
  }
}
