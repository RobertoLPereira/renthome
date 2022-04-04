import 'dart:convert';
import 'package:renthome/app/domain/entities/unidade_imovel.dart';
import 'package:renthome/nomedosservidores.dart';
import 'package:renthome/src/models/bens/imovelunidade.dart';
import 'package:http/http.dart' as http;
import 'package:renthome/src/models/interfaces/bens/imovelunidade_interface.dart';
import 'package:uno/uno.dart';

class ImovelUnidadeRestApi implements ImovelUnidadeInterface {
  final uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis + '/ImovelUnidades');

  @override
  Future<List<UnidadeImovel>> find() async {
    var resposta = await http.get(uriREST);
    if (resposta.statusCode != 200) throw Exception('Erro REST API.');
    print('voltei');
    Iterable listDart = json.decode(resposta.body);
    var listImovel = List<UnidadeImovel>.from(listDart.map((imovel) =>
        UnidadeImovel(
            idimovel: imovel['idimovel'],
            descricao: imovel['descricao'],
            idunidade: imovel['idunidade'],
            idlocatario: imovel['idlocatario'],
            status: imovel['status'],
            idimovelcategoria: imovel['idimovelcategoria'],
            nomeimovel: imovel['nomeimovel'],
            idleituraaguaunidade: imovel['idleituraaguaunidade'])));
    return listImovel;
  }

  final Uno uno;

  ImovelUnidadeRestApi(this.uno);
  Future<List<Imovelunidade>> fetchImovel() async {
    print('é aki');
    final response =
        await uno.get(NomeServidoresApi.Api_Alugueis + '/Imovelunidade');
    final lista = response.data as List;
    final listaImovel = lista.map((e) => Imovelunidade.fromMap(e)).toList();
    return listaImovel;
  }

  @override
  remove(id) async {
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/imovelunidade/$id');
    var resposta = await http.delete(uri);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API Imovel Unidade.');
  }

  @override
  save(UnidadeImovel imovelunidade) async {
    var headers = {'Content-Type': 'application/json'};
    var imovelJson = jsonEncode({
      'idimovel': imovelunidade.idimovel,
      'descricao': imovelunidade.descricao,
      'idunidade': imovelunidade.idunidade,
      'idlocatario': imovelunidade.idlocatario,
      'status': imovelunidade.status,
      'idimovelcategoria': imovelunidade.idimovelcategoria,
    });
    int statusCode = 0;
    if (imovelunidade.idunidade == null) {
      var resposta =
          await http.post(uriREST, headers: headers, body: imovelJson);
      statusCode = resposta.statusCode;
    } else {
      var resposta =
          await http.put(uriREST, headers: headers, body: imovelJson);
      statusCode = resposta.statusCode;
    }
    if (statusCode != 200) throw Exception('Erro REST API ImovelUnidade.');
  }

  @override
  reativar(id) async {
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/AtivarUnidade/$id');
    var resposta = await http.put(uri);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API Reativa Unidade. $resposta.statusCode');
  }

  @override
  Future<List<UnidadeImovel>> buscarImovelunidade() {
    // ignore: todo
    // TODO: implement buscarImovelunidade
    throw UnimplementedError();
  }
}
