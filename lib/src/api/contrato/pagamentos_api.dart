import 'dart:convert';

import 'package:renthome/src/models/pagamento/unidade_pagamento.dart';
import 'package:renthome/src/utils/consultas_genericas.dart';
import 'package:http/http.dart' as http;
import '../../../nomedosservidores.dart';
import '../../../src/models/interfaces/pagamentos_interface.dart';
import '../../../src/models/pagamento/pagamentos.dart';
import 'package:uno/uno.dart';

class PagamentosApi implements PagamentosDAO {
  final uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pagamentos');

  @override
  Future<List<Pagamentos>> find() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    Iterable listDart = json.decode(resposta.body);
    var listPagamentos =
        List<Pagamentos>.from(listDart.map((pagamentos) => Pagamentos(
              idpagamento: pagamentos['idpagamento'],
              datapagamento: pagamentos['datapagamento'],
              valorpago: pagamentos['valorpago'],
              juros: pagamentos['juros'],
              desconto: pagamentos['desconto'],
              idcontrato: pagamentos['idcontrato'],
            )));
    return listPagamentos;
  }

  final Uno uno;

  PagamentosApi(this.uno);
  Future<List<Pagamentos>> fetchPagamentos() async {
    final response =
        await uno.get(NomeServidoresApi.Api_Alugueis + '/Pagamentos');
    final lista = response.data as List;
    final listaPagamentos = lista.map((e) => Pagamentos.fromMap(e)).toList();
    return listaPagamentos;
  }

  @override
  remove(id) async {
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pagamentos/$id');
    var resposta = await http.delete(uri);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
  }

  @override
  save(Pagamentos pagamentos) async {
    var headers = {'Content-Type': 'application/json'};
    var pagamentosJson = jsonEncode({
      'idpagamento': pagamentos.idpagamento,
      'datapagamento': pagamentos.datapagamento,
      'valorpago': pagamentos.valorpago,
      'juros': pagamentos.juros,
      'desconto': pagamentos.desconto,
      'idcontrato': pagamentos.idcontrato,
    });
    int statusCode = 0;
    if (pagamentos.idpagamento == null) {
      var resposta =
          await http.post(uriREST, headers: headers, body: pagamentosJson);
      statusCode = resposta.statusCode;
    } else {
      var resposta =
          await http.put(uriREST, headers: headers, body: pagamentosJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200) throw Exception('Erro REST API.');
  }

  @override
  Future<List<UnidadePagto>> buscarPagamentos(id) async {
    var condicao =
        vw_unidadepagadora + ' where un.idlocatario=' + id.toString();
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Contact/$condicao');
    var resposta = await http.get(uri);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    Iterable listDart = json.decode(resposta.body);
    var listUnidadePagto = List<UnidadePagto>.from(listDart.map((map) =>
        UnidadePagto(
            idcontrato: map['idcontrato'],
            idunidadeimovel: map['idunidadeimovel'],
            idlocador: map['idlocador'],
            idlocatario: map['idlocatario'],
            diavencimento: map['diavencimento'],
            datacontrato: map['datacontrato'],
            status: map['status'],
            validadecontrato: map['validadecontrato'],
            valor: double.tryParse(map['valor']),
            taxacondominio: double.tryParse(map['taxacondominio']),
            valordecaucao: double.tryParse(map['valordecaucao']),
            idunidade: map['idunidade'],
            idimovel: map['idimovel'],
            descricao: map['descricao'],
            idimovelcategoria: map['idimovelcategoria'],
            endereco: map['endereco'],
            idproprietario: map['idproprietario'])));
    return listUnidadePagto;
  }
}
