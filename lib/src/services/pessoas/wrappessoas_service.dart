import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';
import 'package:uno/uno.dart';

import '../../../nomedosservidores.dart';

class WrapPessoaService {
  final Uno uno;

  WrapPessoaService(this.uno);
  Future<List<WrapPessoas>> fetchPessoas() async {
    var response = await uno.get(NomeServidoresApi.Api_Alugueis +
        '/Consultar/select * from public.vw_listacontatosWrap');
    final lista = response.data as List;
    final listaPessoas = lista.map((e) => WrapPessoas.fromJson(e)).toList();
    return listaPessoas;
  }
}
