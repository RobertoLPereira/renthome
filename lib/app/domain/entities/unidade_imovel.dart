import 'dart:convert';

class UnidadeImovel {
  String idunidade;
  String idimovel;
  String idlocatario;
  String descricao;
  String status;
  String idimovelcategoria;
  String nomeimovel;
  String endereco;
  int idproprietario;
  int situacaoimovel;
  String nome;
  UnidadeImovel({
    this.idunidade,
    this.idimovel,
    this.idlocatario,
    this.descricao,
    this.status,
    this.idimovelcategoria,
    this.nomeimovel,
    this.endereco,
    this.idproprietario,
    this.situacaoimovel,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'idunidade': idunidade,
      'idimovel': idimovel,
      'idlocatario': idlocatario,
      'descricao': descricao,
      'status': status,
      'idimovelcategoria': idimovelcategoria,
      'nomeimovel': nomeimovel,
      'endereco': endereco,
      'idproprietario': idproprietario,
      'situacaoimovel': situacaoimovel,
      'nome': nome
    };
  }

  factory UnidadeImovel.fromMap(Map<String, dynamic> map) {
    return UnidadeImovel(
      idunidade: map['idunidade'],
      idimovel: map['idimovel'],
      idlocatario: map['idlocatario'],
      descricao: map['descricao'],
      status: map['status'],
      idimovelcategoria: map['idimovelcategoria'],
      nomeimovel: map['nomeimovel'],
      endereco: map['endereco'],
      idproprietario: map['idproprietario'],
      situacaoimovel: map['situacaoimovel'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UnidadeImovel.fromJson(String source) =>
      UnidadeImovel.fromMap(json.decode(source));
  @override
  @override
  String toString() {
    return 'UnidadeImovel(idunidade: $idunidade, idimovel: $idimovel, idlocatario: $idlocatario, descricao: $descricao, status: $status, idimovelcategoria: $idimovelcategoria, nomeimovel: $nomeimovel, endereco: $endereco, idproprietario: $idproprietario, situacaoimovel: $situacaoimovel, nome: $nome)';
  }
}
