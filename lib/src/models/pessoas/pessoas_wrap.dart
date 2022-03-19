import 'dart:convert';

class PessoasWrap {
  int idcontrato;
  int idunidadeimovel;
  int idlocador;
  int idlocatario;
  int diavencimento;
  String datacontrato;
  int statuscontrato;
  String validadecontrato;
  int valor;
  int taxacondominio;
  int valordecaucao;
  int idpessoa;
  String nome;
  String telefone;
  bool proprietario;
  String cadastradoem;
  int status;
  String urlAvatar;
  String email;
  String unidade;
  String imovel;
  String enddereco;
  String pago;

  PessoasWrap(
      {this.idcontrato,
      this.idunidadeimovel,
      this.idlocador,
      this.idlocatario,
      this.diavencimento,
      this.datacontrato,
      this.statuscontrato,
      this.validadecontrato,
      this.valor,
      this.taxacondominio,
      this.valordecaucao,
      this.idpessoa,
      this.nome,
      this.telefone,
      this.proprietario,
      this.cadastradoem,
      this.status,
      this.urlAvatar,
      this.email,
      this.unidade,
      this.imovel,
      this.enddereco,
      this.pago});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcontrato'] = this.idcontrato;
    data['idunidadeimovel'] = this.idunidadeimovel;
    data['idlocador'] = this.idlocador;
    data['idlocatario'] = this.idlocatario;
    data['diavencimento'] = this.diavencimento;
    data['datacontrato'] = this.datacontrato;
    data['statuscontrato'] = this.statuscontrato;
    data['validadecontrato'] = this.validadecontrato;
    data['valor'] = this.valor;
    data['taxacondominio'] = this.taxacondominio;
    data['valordecaucao'] = this.valordecaucao;
    data['idpessoa'] = this.idpessoa;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['proprietario'] = this.proprietario;
    data['cadastradoem'] = this.cadastradoem;
    data['status'] = this.status;
    data['url_avatar'] = this.urlAvatar;
    data['email'] = this.email;
    data['unidade'] = this.unidade;
    data['imovel'] = this.imovel;
    data['enddereco'] = this.enddereco;
    data['pago'] = this.pago;
    return data;
  }

  factory PessoasWrap.fromMap(Map<String, dynamic> json) {
    print(json);
    return PessoasWrap(
      idcontrato: int.parse(json['idcontrato']),
      idunidadeimovel: int.parse(json['idunidadeimovel']),
      idlocador: int.parse(json['idlocador']),
      idlocatario: int.parse(json['idlocatario']),
      diavencimento: int.parse(json['diavencimento']),
      datacontrato: json['datacontrato'].toString(),
      statuscontrato: int.parse(json['statuscontrato']),
      validadecontrato: json['validadecontrato'].toString(),
      valor: json['valor'],
      taxacondominio: json['taxacondominio'],
      valordecaucao: json['valordecaucao'],
      idpessoa: int.parse(json['idpessoa']),
      nome: json['nome'],
      telefone: json['telefone'].toString(),
      proprietario: json['proprietario'],
      cadastradoem: json['cadastradoem'].toString(),
      status: int.parse(json['status']),
      urlAvatar: json['url_avatar'],
      email: json['email'],
      unidade: json['unidade'],
      imovel: json['imovel'],
      enddereco: json['enddereco'],
      pago: json['pago'].toString(),
    );
  }

  factory PessoasWrap.fromJson(String source) =>
      PessoasWrap.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PessoasWrap(idcontrato:$idcontrato,idunidadeimovel:$idunidadeimovel,idlocador:$idlocador,idlocatario:$idlocatario,diavencimento:$diavencimento,datacontrato:$datacontrato,status:$status,validadecontrato:$validadecontrato,valor:$valor,taxacondominio:$taxacondominio,valordecaucao:$valordecaucao,idpessoa:$idpessoa,nome:$nome,telefone:$telefone,proprietario:$proprietario,cadastradoem:$cadastradoem,url_avatar:$urlAvatar,email:$email,unidade:$unidade,imovel:$imovel,enddereco:$enddereco,pago:$pago)';
  }
}
