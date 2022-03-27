import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renthome/src/models/contrato/contrato.dart';
import 'package:renthome/src/models/pessoas/pessoas.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';
import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';

class WrapPessoasApi {
  static const Api_Alugueis =
      'https://apialugueis.herokuapp.com/Consultar/Select * from "vw_listacontatosWrap"';

  static Future<List<WrapPessoas>> getPessoasWrap(String query) async {
    var resposta = await http.get(Uri.parse(Api_Alugueis));
    if (resposta.statusCode != 200) throw Exception('Erro REST API-Pessoas.');
    if (resposta.statusCode == 200) {
      final List pessoas = json.decode(resposta.body);
      return pessoas.map((json) => WrapPessoas.fromJson(json)).where((pessoa) {
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
  static Future<List<WrapPessoas>> getPessoasFiltro(
      String query, List<WrapPessoas> pes) async {
    if (pes.length > 0) {
      final List<WrapPessoas> wpes = pes;
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

  static Future<List<Pessoas>> criarInquilino(PessoasWrap pessoasWrap) async {
    print('Criar inquilino - Api');
    var headers = {'Content-Type': 'application/json'};
    var pessoasWrapJson = jsonEncode({
      'idpessoa': pessoasWrap.idpessoa,
      'nome': pessoasWrap.nome,
      'telefone': pessoasWrap.telefone,
      'email': pessoasWrap.email,
      'url_avatar': pessoasWrap.urlAvatar,
      'proprietario': pessoasWrap.proprietario,
      'cadastradoem': pessoasWrap.cadastradoem,
      'status': pessoasWrap.status
    });
    var uri = Uri.parse('https://apialugueis.herokuapp.com/Pessoas');
    if (pessoasWrap.idpessoa == null) {
      var resposta =
          await http.post(uri, headers: headers, body: pessoasWrapJson);
      Iterable listDart = json.decode(resposta.body);
      var listPessoas = List<Pessoas>.from(listDart.map((json) => Pessoas(
          status: int.parse(json['status']),
          idpessoa: json['idpessoa'],
          nome: json['nome'],
          telefone: json['telefone'],
          proprietario: json['proprietario'],
          cadastradoem: json['cadastradoem'],
          url_avatar: json['url_avatar'])));
      //print(listPessoasWrap);
      return listPessoas;
    }
    return [];
  }

  static Future<List<Contrato>> criarContrato(Contrato contrato) async {
    print('Criar contrato - Api');
    var headers = {'Content-Type': 'application/json'};
    var contratoJson = jsonEncode({
      'idcontrato': contrato.idcontrato,
      'idunidadeimovel': contrato.idunidadeimovel,
      'idlocador': contrato.idlocador,
      'idlocatario': contrato.idlocatario,
      'diavencimento': contrato.diavencimento,
      'datacontrato': contrato.datacontrato,
      'status': contrato.status,
      'validadecontrato': contrato.validadecontrato,
      'valor': contrato.valor,
      'taxacondominio': contrato.taxacondominio,
      'valordecaucao': contrato.valordecaucao,
    });
    var uri = Uri.parse('https://apialugueis.herokuapp.com/Contrato');
    if (contrato.idcontrato == null) {
      var resposta = await http.post(uri, headers: headers, body: contratoJson);
      Iterable listDart = json.decode(resposta.body);
      var listContrato = List<Contrato>.from(listDart.map((json) => Contrato(
          idcontrato: int.parse(json['idcontrato']),
          idunidadeimovel: json['idunidadeimovel'],
          idlocador: json['idlocador'],
          idlocatario: json['idlocatario'],
          diavencimento: json['diavencimento'],
          datacontrato: json['datacontrato'],
          status: int.parse(json['status']),
          validadecontrato: json['validadecontrato'],
          valor: json['valor'],
          taxacondominio: json['taxacondominio'],
          valordecaucao: json['valordecaucao'])));
      //print(listPessoasWrap);
      return listContrato;
    }
    return [];
  }
}
