import 'dart:convert';

class AlugarUnidade {
  //pagamento
  int idpagamento;
  String datapagamento;
  double valorpago;
  double juros;
  double desconto;
  int idcontrato;
  //Contrato
  int idunidadeimovel;
  int idlocador;
  int idlocatario;
  int diavencimento;
  String datacontrato;
  String validadecontrato;
  double valor;
  double taxacondominio;
  double valordecaucao;
  //Pessoa
  int idpessoa; //int
  String nome;
  String telefone;
  bool proprietario; //bool
  String cadastradoem; //String, date
  String url_avatar;
  String email;
  AlugarUnidade({
    this.idpagamento,
    this.datapagamento,
    this.valorpago,
    this.juros,
    this.desconto,
    this.idcontrato,
    this.idunidadeimovel,
    this.idlocador,
    this.idlocatario,
    this.diavencimento,
    this.datacontrato,
    this.validadecontrato,
    this.valor,
    this.taxacondominio,
    this.valordecaucao,
    this.idpessoa,
    this.nome,
    this.telefone,
    this.proprietario,
    this.cadastradoem,
    this.url_avatar,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'idpagamento': idpagamento,
      'datapagamento': datapagamento,
      'valorpago': valorpago,
      'juros': juros,
      'desconto': desconto,
      'idcontrato': idcontrato,
      'idunidadeimovel': idunidadeimovel,
      'idlocador': idlocador,
      'idlocatario': idlocatario,
      'diavencimento': diavencimento,
      'datacontrato': datacontrato,
      'validadecontrato': validadecontrato,
      'valor': valor,
      'taxacondominio': taxacondominio,
      'valordecaucao': valordecaucao,
      'idpessoa': idpessoa,
      'nome': nome,
      'telefone': telefone,
      'proprietario': proprietario,
      'cadastradoem': cadastradoem,
      'url_avatar': url_avatar,
      'email': email,
    };
  }

  factory AlugarUnidade.fromMap(Map<String, dynamic> map) {
    return AlugarUnidade(
      idpagamento: map['idpagamento'] ?? '',
      datapagamento: map['datapagamento'] ?? '',
      valorpago: map['valorpago']?.toDouble() ?? 0.0,
      juros: map['juros']?.toDouble() ?? 0.0,
      desconto: map['desconto']?.toDouble() ?? 0.0,
      idcontrato: map['idcontrato']?.toInt() ?? 0,
      idunidadeimovel: map['idunidadeimovel']?.toInt() ?? 0,
      idlocador: map['idlocador']?.toInt() ?? 0,
      idlocatario: map['idlocatario']?.toInt() ?? 0,
      diavencimento: map['diavencimento']?.toInt() ?? 0,
      datacontrato: map['datacontrato'] ?? '',
      validadecontrato: map['validadecontrato'] ?? '',
      valor: map['valor']?.toDouble() ?? 0.0,
      taxacondominio: map['taxacondominio']?.toDouble() ?? 0.0,
      valordecaucao: map['valordecaucao']?.toDouble() ?? 0.0,
      idpessoa: map['idpessoa']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      proprietario: map['proprietario'] ?? false,
      cadastradoem: map['cadastradoem'] ?? '',
      url_avatar: map['url_avatar'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AlugarUnidade.fromJson(String source) =>
      AlugarUnidade.fromMap(json.decode(source));
}
