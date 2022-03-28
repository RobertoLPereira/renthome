import 'package:renthome/src/models/apoio/gera_mvc_flutter.dart';
import 'package:renthome/src/models/interfaces/apoio/geramvcflutter_interface.dart';
import 'package:http/http.dart' as http;

import '../../../nomedosservidores.dart';

class GeraMvcFlutterAPI implements GeramvcflutterIterface {
  var uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Consultar/');

  Future<List<GeraMvcFlutter>> find(String tabela) async {
    uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis +
        '/Consultar/select gera_mvc_flutter('
            '$tabela'
            '');
    final response = await http.get(uriREST);
    if (response.statusCode != 200) {
      print(response.statusCode);
    }
    final lista = response.body as List;
    final listaLinhas = lista.map((e) => GeraMvcFlutter.fromMap(e)).toList();
    return listaLinhas;
  }
}
