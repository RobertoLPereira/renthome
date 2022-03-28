import 'dart:convert';
import 'package:renthome/src/models/apoio/categorias.dart';
import 'package:renthome/src/models/interfaces/apoio/categorias_interface.dart';
import 'package:http/http.dart' as http;
import 'package:uno/uno.dart';

import '../../../nomedosservidores.dart';

class CategoriasAPI implements CategoriasIterface {
  final Uno uno;

  CategoriasAPI(this.uno);

  final uriREST =
      Uri.parse(NomeServidoresApi.Api_Alugueis + '/Categoriadeimoveis');

  @override
  remove(id) async {
    var uri =
        Uri.parse(NomeServidoresApi.Api_Alugueis + '/Categoriadeimoveis/$id');
    var resposta = await http.delete(uri);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
  }

  @override
  save(categorias) async {
    var headers = {'Content-Type': 'application/json'};
    var CategoriasJson = jsonEncode({
      'idCategorias': categorias.idcategoriadeimoveis,
      'denominacao': categorias.denominacao,
    });
    int statusCode = 0;
    if (categorias.idcategoriadeimoveis == null) {
      var resposta =
          await http.post(uriREST, headers: headers, body: CategoriasJson);
      statusCode = resposta.statusCode;
    } else {
      var resposta =
          await http.put(uriREST, headers: headers, body: CategoriasJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200) throw Exception('Erro REST API.');
  }

  @override
  Future<List<Categorias>> find() async {
    final response =
        await uno.get(NomeServidoresApi.Api_Alugueis + '/Categoriadeimoveis');
    if (response.status != 200) {
      print(response.status);
    }
    final lista = response.data as List;
    final listaCategorias = lista.map((e) => Categorias.fromMap(e)).toList();
    return listaCategorias;
  }
}
