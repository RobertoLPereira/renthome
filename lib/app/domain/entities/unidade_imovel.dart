import 'dart:convert';

class UnidadeImovel {
  String idunidade;
  String idimovel;
  String idlocatario;
  String descricao;
  String status;
  String idimovelcategoria;
  String nome;
  String endereco;
  String nomeimovel;

  UnidadeImovel(
      {this.idunidade,
      this.idimovel,
      this.idlocatario,
      this.descricao,
      this.status,
      this.idimovelcategoria,
      this.nome,
      this.endereco,
      this.nomeimovel});
  Map<String, dynamic> toMap() {
    return {
      'idunidade': idunidade,
      'idimovel': idimovel,
      'idlocatario': idlocatario,
      'descricao': descricao,
      'status': status,
      'idimovelcategoria': idimovelcategoria,
      'nome': nome,
      'endereco': endereco,
      'nomeimovel': nomeimovel
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
      nome: map['nome'],
      endereco: map['endereco'],
      nomeimovel: map['nomeimovel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UnidadeImovel.fromJson(String source) =>
      UnidadeImovel.fromMap(json.decode(source));
  @override
  String toString() {
    return 'UnidadeImovel(idunidade:$idunidade,idimovel:$idimovel,idlocatario:$idlocatario,descricao:$descricao,status:$status,idimovelcategoria:$idimovelcategoria,nome:$nome,endereco:$endereco,nomeimovel:$nomeimovel)';
  }
}
