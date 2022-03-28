import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';

import '../../../nomedosservidores.dart';
import '../../../src/models/pessoas/pessoas.dart';
import 'package:uno/uno.dart';

class PessoaService {
  final Uno uno;

  PessoaService(this.uno);
  Future<List<Pessoas>> fetchPessoas() async {
    //final response = await uno.get(NomeServidoresApi.Api_Alugueis +'/Pessoas');
    var response = await uno.get(NomeServidoresApi.Api_Alugueis +
        '/Consultar/select * from "vw_listacontatosWrap"');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => Pessoas.fromMap(e)).toList();
    return listaPessoas;
  }

  Future<List<WrapPessoas>> wrapPessoas() async {
    Uno uno;
    var response = await uno.get(NomeServidoresApi.Api_Alugueis +
        '/Consultar/select * from "vw_listacontatosWrap"');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => WrapPessoas.fromJson(e)).toList();
    return listaPessoas;
  }

  Future<List<Pessoas>> getPessoas() async {
    Uno uno;
    final response = await uno.get(NomeServidoresApi.Api_Alugueis + '/Pessoas');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => Pessoas.fromMap(e)).toList();
    return listaPessoas;
  }
}
