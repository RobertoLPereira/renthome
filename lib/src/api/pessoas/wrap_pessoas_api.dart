// ignore_for_file: unused_import

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renthome/nomedosservidores.dart';
import 'package:renthome/src/models/alugar/wrap_alugar.dart';
import 'package:renthome/src/models/contrato/contrato.dart';
import 'package:renthome/src/models/pagamento/pagamentos.dart';
import 'package:renthome/src/models/pessoas/pessoas.dart';
import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';

class WrapPessoasApi {
  static const Api_Alugueis = NomeServidoresApi.Api_Alugueis +
      '/Consultar/Select * from public.vw_listacontatosWrap';

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

  static Future<AlugarUnidade> criarInquilino(AlugarUnidade alugar) async {
    var headers = {'Content-Type': 'application/json'};
    var pessoasWrapJson = jsonEncode({
      'nome': alugar.nome,
      'telefone': alugar.telefone,
      'email': alugar.email,
      'url_avatar': alugar.url_avatar,
      'proprietario': false,
      'cadastradoem': alugar.cadastradoem,
      'status': 1
    });

    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pessoas');

    var resposta =
        await http.post(uri, headers: headers, body: pessoasWrapJson);

    if (resposta.statusCode != 200)
      throw Exception('Erro REST API-Pessoas. (Criar Inquilino) $resposta');

    if (resposta.statusCode == 200 || resposta.statusCode == 204) {
      var pessoa = json.decode(resposta.body);
      alugar.idlocatario = pessoa['idpessoa'] as int;
      await criarContrato(alugar);
    }
    return alugar;
  }

  static Future<AlugarUnidade> criarContrato(AlugarUnidade contrato) async {
    var headers = {'Content-Type': 'application/json'};
    var contratoJson = jsonEncode({
      'idunidadeimovel': contrato.idunidadeimovel,
      'idlocador': contrato.idlocador,
      'idlocatario': contrato.idlocatario,
      'diavencimento': contrato.diavencimento,
      'datacontrato': contrato.datacontrato,
      'status': 1,
      'validadecontrato': contrato.validadecontrato,
      'valor': contrato.valor,
      'taxacondominio': contrato.taxacondominio,
      'valordecaucao': contrato.valordecaucao
    });

    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Contrato');
    var resposta = await http.post(uri, headers: headers, body: contratoJson);
    if (resposta.statusCode != 200)
      throw Exception('Erro REST API-Pessoas. (Criar contrato) $resposta');
    if (resposta.statusCode == 200 || resposta.statusCode == 204) {
      var ctr = json.decode(resposta.body);
      contrato.idcontrato = ctr['idcontrato'];
      contrato = await criaPagamentos(contrato);
    }
    return contrato;
  }

  static Future<AlugarUnidade> criaPagamentos(AlugarUnidade pagamentos) async {
    var resposta;
    var headers = {'Content-Type': 'application/json'};
    var pagamentosJson = jsonEncode({
      'datapagamento': pagamentos.cadastradoem,
      'valorpago': pagamentos.valorpago,
      'juros': 0.00,
      'desconto': 0.00,
      'idcontrato': pagamentos.idcontrato
    });
    print(pagamentosJson.toString());
    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pagamentos');
    resposta = await http.post(uri, headers: headers, body: pagamentosJson);

    if (resposta.statusCode != 200)
      throw Exception(
          'Erro REST API-Pessoas. (Criar pagamento) $resposta.statusCode');
    if (resposta.statusCode == 200 || resposta.statusCode == 204) {
      var pgto = json.decode(resposta.body);
      pagamentos.idpagamento = pgto['idpagamento'];
      pagamentos = await aluga(pagamentos);
    }
    return pagamentos;
  }

  static Future<AlugarUnidade> aluga(AlugarUnidade imovelunidade) async {
    print(imovelunidade);
    var headers = {'Content-Type': 'application/json'};
    var imovelunidadeJson;

    imovelunidadeJson = jsonEncode({
      'idunidade': imovelunidade.idunidadeimovel,
      'idlocatario': (imovelunidade.idlocatario),
      'status': 3,
    });

    var uri = Uri.parse(NomeServidoresApi.Api_Alugueis +
        '/AlugarUnidade/$imovelunidade.idunidadeimovel');
    var resposta =
        await http.put(uri, headers: headers, body: imovelunidadeJson);
    if (resposta.statusCode != 204)
      throw Exception(
          'Erro REST API-Pessoas. (Atualizar imovel unidade) $resposta');
    return imovelunidade;
  }
}
