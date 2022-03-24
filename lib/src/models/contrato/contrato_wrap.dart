import 'dart:convert';

class ContratoWrap {
  int idcontrato;
  int idunidadeimovel;
  int idlocador;
  String idlocatario;
  String diavencimento;
  int status_contrato;
  int status_pessoa;
  String validadecontrato;
  String nome;
  String telefone;
  String datacontrato;
  String cadastradoem;
  String url_avatar;
  double valor;
  double taxacondominio;
  double valordecaucao;
  bool proprietario;
  int idunidade;
  int idimovel;
  String descricao;
  int status;
  int idimovelcategoria;

  ContratoWrap({
    this.idcontrato,
    this.idunidadeimovel,
    this.idlocador,
    this.idlocatario,
    this.diavencimento,
    this.status_contrato,
    this.status_pessoa,
    this.validadecontrato,
    this.nome,
    this.telefone,
    this.datacontrato,
    this.cadastradoem,
    this.url_avatar,
    this.valor,
    this.taxacondominio,
    this.valordecaucao,
    this.proprietario,
    this.idunidade,
    this.idimovel,
    this.descricao,
    this.status,
    this.idimovelcategoria,
  });

  ContratoWrap copyWith({
    int idcontrato,
    int idunidadeimovel,
    int idlocador,
    int idlocatario,
    int diavencimento,
    int status_contrato,
    int status_pessoa,
    String validadecontrato,
    String nome,
    String telefone,
    String datacontrato,
    String cadastradoem,
    String url_avatar,
    double valor,
    double taxacondominio,
    double valordecaucao,
    bool proprietario,
  }) {
    return ContratoWrap(
      idcontrato: idcontrato ?? this.idcontrato,
      idunidadeimovel: idunidadeimovel ?? this.idunidadeimovel,
      idlocador: idlocador ?? this.idlocador,
      idlocatario: idlocatario ?? this.idlocatario,
      diavencimento: diavencimento ?? this.diavencimento,
      status_contrato: status_contrato ?? this.status_contrato,
      status_pessoa: status_pessoa ?? this.status_pessoa,
      validadecontrato: validadecontrato ?? this.validadecontrato,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      datacontrato: datacontrato ?? this.datacontrato,
      cadastradoem: cadastradoem ?? this.cadastradoem,
      url_avatar: url_avatar ?? this.url_avatar,
      valor: valor ?? this.valor,
      taxacondominio: taxacondominio ?? this.taxacondominio,
      valordecaucao: valordecaucao ?? this.valordecaucao,
      proprietario: proprietario ?? this.proprietario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idcontrato': idcontrato,
      'idunidadeimovel': idunidadeimovel,
      'idlocador': idlocador,
      'idlocatario': idlocatario,
      'diavencimento': diavencimento,
      'status_contrato': status_contrato,
      'status_pessoa': status_pessoa,
      'validadecontrato': validadecontrato,
      'nome': nome,
      'telefone': telefone,
      'datacontrato': datacontrato,
      'cadastradoem': cadastradoem,
      'url_avatar': url_avatar,
      'valor': valor,
      'taxacondominio': taxacondominio,
      'valordecaucao': valordecaucao,
      'proprietario': proprietario,
    };
  }

  factory ContratoWrap.fromMap(Map<String, dynamic> map) {
    return ContratoWrap(
      idcontrato: map['idcontrato']?.toInt() ?? 0,
      idunidadeimovel: map['idunidadeimovel']?.toInt() ?? 0,
      idlocador: map['idlocador']?.toInt() ?? 0,
      idlocatario: map['idlocatario']?.toInt() ?? 0,
      diavencimento: map['diavencimento']?.toInt() ?? 0,
      status_contrato: map['status_contrato']?.toInt() ?? 0,
      status_pessoa: map['status_pessoa']?.toInt() ?? 0,
      validadecontrato: map['validadecontrato'] ?? '',
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      datacontrato: map['datacontrato'] ?? '',
      cadastradoem: map['cadastradoem'] ?? '',
      url_avatar: map['url_avatar'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      taxacondominio: map['taxacondominio']?.toDouble() ?? 0.0,
      valordecaucao: map['valordecaucao']?.toDouble() ?? 0.0,
      proprietario: map['proprietario'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContratoWrap.fromJson(String source) =>
      ContratoWrap.fromMap(json.decode(source));
}
