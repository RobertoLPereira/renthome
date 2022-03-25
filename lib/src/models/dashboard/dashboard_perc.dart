class DashBoardPerc {
  String ativos;
  String valortotalcontrato;
  String inativos;
  String vencidos;
  String pagosematraso;
  String pagosnovencimento;
  String emdia;
  String percemdia;
  String percvencidos;
  String percpgematraso;

  DashBoardPerc(
      {this.ativos,
      this.valortotalcontrato,
      this.inativos,
      this.vencidos,
      this.pagosematraso,
      this.pagosnovencimento,
      this.emdia,
      this.percemdia,
      this.percvencidos,
      this.percpgematraso});

  DashBoardPerc.fromJson(Map<String, dynamic> json) {
    ativos = json['ativos'];
    valortotalcontrato = json['valortotalcontrato'];
    inativos = json['inativos'];
    vencidos = json['vencidos'];
    pagosematraso = json['pagosematraso'];
    pagosnovencimento = json['pagosnovencimento'];
    emdia = json['emdia'];
    percemdia = json['percemdia'];
    percvencidos = json['percvencidos'];
    percpgematraso = json['percpgematraso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ativos'] = this.ativos;
    data['valortotalcontrato'] = this.valortotalcontrato;
    data['inativos'] = this.inativos;
    data['vencidos'] = this.vencidos;
    data['pagosematraso'] = this.pagosematraso;
    data['pagosnovencimento'] = this.pagosnovencimento;
    data['emdia'] = this.emdia;
    data['percemdia'] = this.percemdia;
    data['percvencidos'] = this.percvencidos;
    data['percpgematraso'] = this.percpgematraso;
    return data;
  }
}
