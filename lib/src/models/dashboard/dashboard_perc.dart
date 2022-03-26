class DashBoardPerc {
  dynamic ativos;
  dynamic valortotalcontrato;
  dynamic inativos;
  dynamic vencidos;
  dynamic pagosematraso;
  dynamic pagosnovencimento;
  dynamic emdia;
  dynamic percemdia;
  dynamic percvencidos;
  dynamic percpgematraso;

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ativos': ativos});
    result.addAll({'valortotalcontrato': valortotalcontrato});
    result.addAll({'inativos': inativos});
    result.addAll({'vencidos': vencidos});
    result.addAll({'pagosematraso': pagosematraso});
    result.addAll({'pagosnovencimento': pagosnovencimento});
    result.addAll({'emdia': emdia});
    result.addAll({'percemdia': percemdia});
    result.addAll({'percvencidos': percvencidos});
    result.addAll({'percpgematraso': percpgematraso});

    return result;
  }
}
