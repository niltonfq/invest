enum TipoAtivos {
  acoes('Ações'),
  fundosImobiliarios('Fundos_Imobiliários'),
  fundosInvestimentos('Fundos_Investimentos'),
  fiagro('Fiagro'),
  stocks('Stocks'),
  reits('Reits'),
  eTFsNacionais('ETFs_Nacionais'),
  criptomoedas('Criptomoedas'),
  tesouroDireto('Tesouro_Direto'),
  cDB('CDB'),
  lCIeLCA('LCI_e_LCA'),
  crieCra('Cri_e_Cra'),
  debendures('Debendures'),
  bDRs('BDRs');

  final String value;
  const TipoAtivos(this.value);
}
