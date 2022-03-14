import '../../../src/models/pessoas/pessoas.dart';
import 'package:uno/uno.dart';

class PessoaService {
  final Uno uno;

  PessoaService(this.uno);
  Future<List<Pessoas>> fetchPessoas() async {
    //final response = await uno.get('https://apialugueis.herokuapp.com/Pessoas');
    var response = await uno.get(
        'https://apialugueis.herokuapp.com/Consultar/select * from "vw_listacontatosWrap"');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => Pessoas.fromMap(e)).toList();
    return listaPessoas;
  }

  Future<List<Pessoas>> getPessoas() async {
    Uno uno;
    final response = await uno.get('https://apialugueis.herokuapp.com/Pessoas');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => Pessoas.fromMap(e)).toList();
    return listaPessoas;
  }
}
