import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renthome/src/models/pessoas/pessoas.dart';

class WrapPessoasApi {
  static const Api_Alugueis =
      'https://apialugueis.herokuapp.com/Consultar/Select * from "vw_listacontatosWrap"';

  static Future<List<Pessoas>> getPessoasWrap(String query) async {
    var resposta = await http.get(Uri.parse(Api_Alugueis));
    if (resposta.statusCode != 200) throw Exception('Erro REST API-Pessoas.');
    if (resposta.statusCode == 200) {
      final List pessoas = json.decode(resposta.body);
      return pessoas.map((json) => Pessoas.fromJson(json)).where((pessoa) {
        final titleLower = pessoa.nome.toLowerCase();
        final authorLower = pessoa.telefone.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  //Método para atender o filtro
  static Future<List<Pessoas>> getPessoasFiltro(
      String query, List<Pessoas> pes) async {
    if (pes.length > 0) {
      final List<Pessoas> wpes = pes;
      return wpes.where((u) {
        final titleLower = u.nome.toLowerCase();
        final authorLower = u.telefone.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
