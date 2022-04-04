class Leitura {
  int idunidade;
  int idimovel;
  int idpessoa;
  String descricao;
  int status;
  Imovel imovel;
  Pessoa pessoa;
  List<Leituraaguaunidades> leituraaguaunidades;
  List<Leituraluzunidades> leituraluzunidades;

  Leitura(
      {this.idunidade,
      this.idimovel,
      this.idpessoa,
      this.descricao,
      this.status,
      this.imovel,
      this.pessoa,
      this.leituraaguaunidades,
      this.leituraluzunidades});

  Leitura.fromJson(Map<String, dynamic> json) {
    idunidade = json['idunidade'];
    idimovel = json['idimovel'];
    idpessoa = json['idpessoa'];
    descricao = json['descricao'];
    status = json['status'];
    imovel =
        json['imovel'] != null ? new Imovel.fromJson(json['imovel']) : null;
    pessoa =
        json['pessoa'] != null ? new Pessoa.fromJson(json['pessoa']) : null;
    if (json['leituraaguaunidades'] != null) {
      leituraaguaunidades = <Leituraaguaunidades>[];
      json['leituraaguaunidades'].forEach((v) {
        leituraaguaunidades.add(new Leituraaguaunidades.fromJson(v));
      });
    }
    if (json['leituraluzunidades'] != null) {
      leituraluzunidades = <Leituraluzunidades>[];
      json['leituraluzunidades'].forEach((v) {
        leituraluzunidades.add(new Leituraluzunidades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idunidade'] = this.idunidade;
    data['idimovel'] = this.idimovel;
    data['idpessoa'] = this.idpessoa;
    data['descricao'] = this.descricao;
    data['status'] = this.status;
    if (this.imovel != null) {
      data['imovel'] = this.imovel.toJson();
    }
    if (this.pessoa != null) {
      data['pessoa'] = this.pessoa.toJson();
    }
    if (this.leituraaguaunidades != null) {
      data['leituraaguaunidades'] =
          this.leituraaguaunidades.map((v) => v.toJson()).toList();
    }
    if (this.leituraluzunidades != null) {
      data['leituraluzunidades'] =
          this.leituraluzunidades.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imovel {
  int idimovel;
  String descricao;
  String endereco;
  int idpessoa;
  int status;

  Imovel(
      {this.idimovel,
      this.descricao,
      this.endereco,
      this.idpessoa,
      this.status});

  Imovel.fromJson(Map<String, dynamic> json) {
    idimovel = json['idimovel'];
    descricao = json['descricao'];
    endereco = json['endereco'];
    idpessoa = json['idpessoa'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idimovel'] = this.idimovel;
    data['descricao'] = this.descricao;
    data['endereco'] = this.endereco;
    data['idpessoa'] = this.idpessoa;
    data['status'] = this.status;
    return data;
  }
}

class Pessoa {
  int idpessoa;
  String nome;
  String telefone;
  bool proprietario;
  String cadastradoem;
  int status;
  String urlAvatar;
  String email;

  Pessoa(
      {this.idpessoa,
      this.nome,
      this.telefone,
      this.proprietario,
      this.cadastradoem,
      this.status,
      this.urlAvatar,
      this.email});

  Pessoa.fromJson(Map<String, dynamic> json) {
    idpessoa = json['idpessoa'];
    nome = json['nome'];
    telefone = json['telefone'];
    proprietario = json['proprietario'];
    cadastradoem = json['cadastradoem'];
    status = json['status'];
    urlAvatar = json['url_avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpessoa'] = this.idpessoa;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['proprietario'] = this.proprietario;
    data['cadastradoem'] = this.cadastradoem;
    data['status'] = this.status;
    data['url_avatar'] = this.urlAvatar;
    data['email'] = this.email;
    return data;
  }
}

class Leituraaguaunidades {
  int idleituraaguaunidade;
  int idunidade;
  String leituraanterior;
  String leituraatual;
  int codigomedidor;
  String dataleitura;
  int status;
  String valor;

  Leituraaguaunidades(
      {this.idleituraaguaunidade,
      this.idunidade,
      this.leituraanterior,
      this.leituraatual,
      this.codigomedidor,
      this.dataleitura,
      this.status,
      this.valor});

  Leituraaguaunidades.fromJson(Map<String, dynamic> json) {
    idleituraaguaunidade = json['idleituraaguaunidade'];
    idunidade = json['idunidade'];
    leituraanterior = json['leituraanterior'];
    leituraatual = json['leituraatual'];
    codigomedidor = json['codigomedidor'];
    dataleitura = json['dataleitura'];
    status = json['status'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idleituraaguaunidade'] = this.idleituraaguaunidade;
    data['idunidade'] = this.idunidade;
    data['leituraanterior'] = this.leituraanterior;
    data['leituraatual'] = this.leituraatual;
    data['codigomedidor'] = this.codigomedidor;
    data['dataleitura'] = this.dataleitura;
    data['status'] = this.status;
    data['valor'] = this.valor;
    return data;
  }
}

class Leituraluzunidades {
  int idleituraluzunidade;
  int idunidade;
  String leituraanterior;
  String leituraatual;
  int codigomedidor;
  String dataleitura;
  int status;
  String valor;

  Leituraluzunidades(
      {this.idleituraluzunidade,
      this.idunidade,
      this.leituraanterior,
      this.leituraatual,
      this.codigomedidor,
      this.dataleitura,
      this.status,
      this.valor});

  Leituraluzunidades.fromJson(Map<String, dynamic> json) {
    idleituraluzunidade = json['idleituraluzunidade'];
    idunidade = json['idunidade'];
    leituraanterior = json['leituraanterior'];
    leituraatual = json['leituraatual'];
    codigomedidor = json['codigomedidor'];
    dataleitura = json['dataleitura'];
    status = json['status'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idleituraluzunidade'] = this.idleituraluzunidade;
    data['idunidade'] = this.idunidade;
    data['leituraanterior'] = this.leituraanterior;
    data['leituraatual'] = this.leituraatual;
    data['codigomedidor'] = this.codigomedidor;
    data['dataleitura'] = this.dataleitura;
    data['status'] = this.status;
    data['valor'] = this.valor;
    return data;
  }
}
