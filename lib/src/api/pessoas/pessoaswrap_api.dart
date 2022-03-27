import 'dart:convert';

import 'package:renthome/app/domain/interfaces/pessoas_wrap_dao.dart';
import 'package:renthome/src/models/pagamento/pagamentoPessoa.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';
import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';
import 'package:renthome/src/utils/consultas_genericas.dart';
import 'package:http/http.dart' as http;
import 'package:uno/uno.dart';

class PessoasWrapApi implements PessoasWrapDAO {
  final uriREST = Uri.parse(
      'https://apialugueis.herokuapp.com/Consultar/select * from  "vw_listacontatosWrap"');

  @override
  Future<List<PessoasWrap>> find() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    print(resposta.body);
    Iterable listDart = json.decode(resposta.body);
    var listPessoasWrap = List<PessoasWrap>.from(listDart.map((json) =>
        PessoasWrap(
            idcontrato: int.parse(json['idcontrato']),
            idunidadeimovel: json['idunidadeimovel'],
            idlocador: json['idlocador'],
            idlocatario: json['idlocatario'],
            diavencimento: json['diavencimento'],
            datacontrato: json['datacontrato'],
            status: int.parse(json['status']),
            validadecontrato: json['validadecontrato'],
            valor: json['valor'],
            taxacondominio: json['taxacondominio'],
            valordecaucao: json['valordecaucao'],
            idpessoa: json['idpessoa'],
            nome: json['nome'],
            telefone: json['telefone'],
            proprietario: json['proprietario'],
            cadastradoem: json['cadastradoem'],
            urlAvatar: json['url_avatar'],
            unidade: json['unidade'],
            imovel: json['imovel'],
            enddereco: json['enddereco'],
            pago: json['pago'])));
    //print(listPessoasWrap);
    return listPessoasWrap;
  }

  Future<List<WrapPessoas>> wrapfind() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    final lista = resposta.body as List;
    final listaPessoas = lista.map((e) => WrapPessoas.fromJson(e)).toList();
    return listaPessoas;
  }

  final Uno uno;

  PessoasWrapApi(this.uno);
  Future<List<PessoasWrap>> fetchPessoasWrap() async {
    final response = await uno.get(
        'https://apialugueis.herokuapp.com/Consultar/ select * from  "vw_listacontatosWrap"');
    final lista = response.data as List;
    print('api');
    print(response.data.toString());
    print('api-2');
    final listaPessas = lista.map((e) => PessoasWrap.fromMap(e)).toList();
    print('api-3');
    return listaPessas;
  }

  @override
  save(WrapPessoas pessoasWrap) async {
    print('salvar pessoa');
    var headers = {'Content-Type': 'application/json'};
    var pessoasWrapJson = jsonEncode({
      'idpessoa': pessoasWrap.idpessoa,
      'nome': pessoasWrap.nome,
      'telefone': pessoasWrap.telefone,
      'email': pessoasWrap.email,
      'url_avatar': pessoasWrap.urlAvatar,
      'proprietario': pessoasWrap.proprietario,
      'cadastradoem': pessoasWrap.cadastradoem,
      'status': pessoasWrap.status
    });
    //print(pessoasWrap.idpessoa);
    int statusCode = 0;
    var uri = Uri.parse('https://apialugueis.herokuapp.com/Pessoas');
    if (pessoasWrap.idpessoa == null) {
      //print(pessoasWrapJson);
      var resposta =
          await http.post(uri, headers: headers, body: pessoasWrapJson);
      statusCode = resposta.statusCode;
    } else {
      var resposta =
          await http.put(uri, headers: headers, body: pessoasWrapJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200 && statusCode != 204)
      throw Exception('Erro REST API Salvar Pessoa. $statusCode');
  }

  @override
  reativar(idpessoa) async {
    var uri =
        Uri.parse('https://apialugueis.herokuapp.com/AtivarPessoa/$idpessoa');
    var resposta = await http.put(uri);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API Remove. $resposta.statusCode');
  }

  @override
  remove(idpessoa) async {
    print(idpessoa);
    var uri = Uri.parse(
        'https://apialugueis.herokuapp.com/DesativarPessoa/$idpessoa');
    var resposta = await http.put(uri);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API Remove. $resposta.statusCode');
  }

  @override
  Future<List<PagamentosPessoa>> listar(idpessoa) async {
    var uri = Uri.parse(
        'https://apialugueis.herokuapp.com/Consultar/$vw_pagamentosPessoa where p.idpessoa=$idpessoa');
    print(uri);
    var response = await http.get(uri);

    Iterable listDart = json.decode(response.body);
    var listaPagtosPessoa = List<PagamentosPessoa>.from(listDart.map((map) =>
        PagamentosPessoa(
            idpagamento: map['idpagamento'],
            datapagamento: map['datapagamento'],
            valorpago: double.tryParse(map['valorpago']),
            juros: double.tryParse(map['juros']),
            desconto: double.tryParse(map['desconto']),
            idcontrato: map['idcontrato'],
            idpessoa: map['idpessoa'],
            nome: map['nome'],
            telefone: map['telefone'],
            proprietario: map['proprietario'],
            cadastradoem: map['cadastradoem'],
            status: map['status'],
            urlAvatar: map['url_avatar'],
            email: map['email'],
            idlocatario: map['idlocatario'])));
    print(listaPagtosPessoa.toString());
    return listaPagtosPessoa;
  }
}
