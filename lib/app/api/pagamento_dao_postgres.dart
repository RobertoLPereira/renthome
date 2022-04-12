import 'dart:convert';
import 'package:renthome/app/domain/interfaces/pagamento_dao.dart';
import 'package:renthome/src/models/pagamento/pagamentoPessoa.dart';
import 'package:renthome/src/models/pagamento/pagamentos.dart';
import 'package:renthome/src/utils/consultas_genericas.dart';
import 'package:http/http.dart' as http;

import '../../nomedosservidores.dart';

class PagamentoDAOPostgres implements PagamentoDAO {
  final uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pagamentos');

  @override
  Future<List<Pagamentos>> find() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    //print(resposta.body);
    Iterable listDart = json.decode(resposta.body);
    //print(listDart);
    var listPagto = List<Pagamentos>.from(listDart.map((map) => Pagamentos(
        idpagamento: map['idpagamento'],
        datapagamento: map['datapagamento'],
        valorpago: map['valorpago'],
        juros: map['juros'],
        desconto: map['desconto'],
        idcontrato: map['idcontrato'])));
    //print(listPagto);
    return listPagto;
  }

  @override
  remove(id) async {
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/pagamentosM/$id');
    var resposta = await http.delete(uri);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API Remove. $resposta.statusCode');
  }

  @override
  save(Pagamentos Pagto) async {
    print('cheguei na api');
    print(Pagto);
    var headers = {'Content-Type': 'application/json'};
    var PagtoJson = jsonEncode({
      'datapagamento': Pagto.datapagamento,
      'valorpago': Pagto.valorpago,
      'juros': Pagto.juros,
      'desconto': Pagto.desconto,
      'idcontrato': Pagto.idcontrato
    });
    //print(Pagto.id);
    int statusCode = 0;

    if (Pagto.idpagamento == null) {
      print(PagtoJson);
      var resposta =
          await http.post(uriREST, headers: headers, body: PagtoJson);
      statusCode = resposta.statusCode;
    } else {
      var uri = Uri.parse(
          NomeServidoresApi.Api_Alugueis + '/pagamentosM/$Pagto.idpagamento');
      //print(uri);
      var resposta = await http.put(uri, headers: headers, body: PagtoJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200 && statusCode != 204)
      throw Exception('Erro REST API Salvar. $statusCode');
  }

  @override
  Future<List<PagamentosPessoa>> listar(idpessoa) async {
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis +
        '/Consultar/$vw_pagamentosPessoa where p.idpessoa=$idpessoa');
    var response = await http.delete(uri);
    final lista = response.body as List;
    final listaPagtosPessoa =
        lista.map((e) => PagamentosPessoa.fromMap(e)).toList();
    return listaPagtosPessoa;
  }
}
