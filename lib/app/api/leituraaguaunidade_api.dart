import 'dart:convert';
import 'package:renthome/app/domain/interfaces/leituraaguaunidade_interface.dart';
import 'package:renthome/src/models/bens/leituraaguaunidade.dart';
import 'package:http/http.dart' as http;
import 'package:uno/uno.dart';

import '../../nomedosservidores.dart';

class LeituraaguaunidadeApi implements LeituraaguaunidadeInterface {
  final uriREST =
      Uri.parse(NomeServidoresApi.Api_Alugueis + '/Leituraaguaunidade');

  @override
  Future<List<LeituraAguaUnidade>> find() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    Iterable listDart = json.decode(resposta.body);
    var listLeituraaguaunidade = List<LeituraAguaUnidade>.from(
        listDart.map((leituraaguaunidade) => LeituraAguaUnidade(
              idleituraaguaunidade:
                  leituraaguaunidade['idleituraaguaunidade'].toString(),
              idunidadeimovel: leituraaguaunidade['idunidadeimovel'].toString(),
              leituraanterior: leituraaguaunidade['leituraanterior'],
              leituraatual: leituraaguaunidade['leituraatual'],
              codigomedidor: leituraaguaunidade['codigomedidor'].toString(),
              dataleitura: leituraaguaunidade['dataleitura'],
              status: leituraaguaunidade['status'].toString(),
              valor: leituraaguaunidade['valor'],
            )));
    return listLeituraaguaunidade;
  }

  final Uno uno;

  LeituraaguaunidadeApi(this.uno);
  Future<List<LeituraAguaUnidade>> fetchLeituraaguaunidade() async {
    final response =
        await uno.get(NomeServidoresApi.Api_Alugueis + '/Leituraaguaunidade');
    final lista = response.data as List;
    final listaLeituraaguaunidade =
        lista.map((e) => LeituraAguaUnidade.fromMap(e)).toList();
    return listaLeituraaguaunidade;
  }

  @override
  remove(id) async {
    var uri =
        Uri.parse(NomeServidoresApi.Api_Alugueis + '/leituraaguaunidade/$id');
    var resposta = await http.delete(uri);
    if (resposta.statusCode != 204) throw Exception('Erro REST API.');
  }

  @override
  save(LeituraAguaUnidade leituraaguaunidade) async {
    var headers = {'Content-Type': 'application/json'};
    //print(leituraaguaunidade);
    var leituraaguaunidadeJson = jsonEncode({
      'idunidadeimovel': leituraaguaunidade.idunidadeimovel,
      'leituraanterior': double.tryParse(leituraaguaunidade.leituraanterior),
      'leituraatual': double.tryParse(leituraaguaunidade.leituraatual),
      'codigomedidor': int.parse(leituraaguaunidade.codigomedidor),
      'dataleitura': leituraaguaunidade.dataleitura.toString(),
      //'status': int.parse(leituraaguaunidade.status),
      'valor': double.tryParse(leituraaguaunidade.valor),
    });
    //print(leituraaguaunidadeJson);
    int statusCode = 0;
    if (leituraaguaunidade.idleituraaguaunidade == null) {
      var resposta = await http.post(uriREST,
          headers: headers, body: leituraaguaunidadeJson);
      statusCode = resposta.statusCode;
    } else {
      var resposta = await http.put(uriREST,
          headers: headers, body: leituraaguaunidadeJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200 && statusCode != 204)
      throw Exception('Erro REST API.');
  }

  @override
  Future<LeituraAguaUnidade> findId(id) async {
    final response =
        await uno.get(NomeServidoresApi.Api_Alugueis + '/LeiturasUnidade/$id');
    print(response.data);
    final consumo = response.data;
    final consumow = consumo.map((e) => LeituraAguaUnidade.fromMap(e));

    return consumow;
  }
}
