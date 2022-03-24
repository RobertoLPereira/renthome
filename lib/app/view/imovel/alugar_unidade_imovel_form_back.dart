import 'package:renthome/app/domain/entities/unidade_imovel.dart';
import 'package:renthome/app/domain/regrasdenegocio/services/unidade_imovel_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:renthome/src/api/pessoas/wrap_pessoas_api.dart';
import 'package:renthome/src/models/contrato/contrato.dart';
import 'package:renthome/src/models/contrato/contrato_wrap.dart';
import 'package:renthome/src/models/pessoas/pessoas.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';

class AlugarUnidadeImovelFormBack {
  UnidadeImovel unid;
  ContratoWrap ctr;
  var _service = GetIt.I.get<UnidadeImovelService>();

  bool _diaIsValid;
  bool _valorIsValid;
  bool _taxacondominioIsValid;
  bool _valordecaucaoIsValid;
  bool _nomeIsValid;
  bool _telefoneIsValid;

  bool get isValid =>
      _diaIsValid &&
      _valorIsValid &&
      _taxacondominioIsValid &&
      _valordecaucaoIsValid &&
      _nomeIsValid &&
      _telefoneIsValid;
  //Receber os parametros enviados por uma chamada
  AlugarUnidadeImovelFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context).settings.arguments;
    ctr = (parameter == null) ? ContratoWrap() : parameter;
  }
  save(BuildContext context) async {
    debugPrint('vou salvar');
    PessoasWrap pesw = new PessoasWrap();
    Pessoas pes = new Pessoas();
    Contrato contr = new Contrato();
    String datacad = DateTime.now().year.toString();
    datacad += '-' + DateTime.now().month.toString();
    datacad += '-' + DateTime.now().day.toString();
    DateTime data = DateTime.now();
    print(datacad);
    data = data.add(const Duration(days: 180));
    String dataval = data.year.toString();
    dataval += '-' + data.month.toString();
    dataval += '-' + data.day.toString();
    ctr.cadastradoem = datacad;
    print(dataval);
    ctr.validadecontrato = dataval;
    ctr.status = 1;
    ctr.status_contrato = 1;
    ctr.idlocador = 1;
    print(ctr.toJson());
    pesw.cadastradoem = datacad;
    print(data);
    pesw.nome = ctr.nome;
    pesw.email = ctr.nome + '@gmail.com.br';
    pesw.telefone = ctr.telefone;
    pesw.proprietario = false;
    pesw.status = 1;
    pesw.urlAvatar =
        'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png';
    //Crai o cadastro do inquilino
    pes = (await WrapPessoasApi.criarInquilino(pesw)) as Pessoas;
    if (pes.idpessoa.isNaN || pes.idpessoa == null) {
      Navigator.of(context).pop();
    } else {
      print('cadastro = $pes.toJson()');
      unid.idlocatario = pes.idpessoa.toString();
      unid.status = "3";
      unid.idunidade = ctr.idunidade.toString();
      //Atualiza a situação da unidade como alugada
      print('vou atualizar unidade');
      var imu = await _service.salvar(unid);
      print('resposta unidade $imu');
      contr.datacontrato = datacad;
      contr.diavencimento = int.parse(ctr.diavencimento);
      contr.idlocador = ctr.idlocador;
      contr.idunidadeimovel = imu.idunidade;
      contr.status = 1;
      contr.taxacondominio = ctr.taxacondominio;
      contr.validadecontrato = dataval;
      contr.valor = ctr.valor;
      contr.valordecaucao = ctr.valordecaucao;
      //Cria o contrato de locação para a unidade
      contr = (await WrapPessoasApi.criarContrato(contr)) as Contrato;
      await Navigator.of(context).pop();
    }
  }

  //Validar os dados do formulário

  String validateDiavencimento(String dia) {
    try {
      _service.validarDiavencimento(dia);
      _diaIsValid = true;
      return null;
    } catch (e) {
      _diaIsValid = false;
      return e.toString();
    }
  }

  String validateValor(String valor) {
    try {
      _service.validateValor(valor);
      _valorIsValid = true;
      return null;
    } catch (e) {
      _valorIsValid = false;
      return e.toString();
    }
  }

  String validateTaxacondominio(String taxacondominio) {
    try {
      _service.validateTaxacondominio(taxacondominio);
      _taxacondominioIsValid = true;
      return null;
    } catch (e) {
      _taxacondominioIsValid = false;
      return e.toString();
    }
  }

  String validateValordecaucao(String valordecaucao) {
    try {
      _service.validateValordecaucao(valordecaucao);
      _valordecaucaoIsValid = true;
      return null;
    } catch (e) {
      _valordecaucaoIsValid = false;
      return e.toString();
    }
  }

  String validateNome(String nome) {
    try {
      _service.validateNome(nome);
      _nomeIsValid = true;
      return null;
    } catch (e) {
      _nomeIsValid = false;
      return e.toString();
    }
  }

  String validateTelefone(String telefone) {
    try {
      _service.validateTelefone(telefone);
      _telefoneIsValid = true;
      return null;
    } catch (e) {
      _telefoneIsValid = false;
      return e.toString();
    }
  }

  String validateProprietario(String proprietario) {
    try {
      _service.validateProprietario(proprietario);
      //_proprietarioIsValid = true;
      return null;
    } catch (e) {
      //_proprietarioIsValid = false;
      return e.toString();
    }
  }

  String validateEmail(String email) {
    try {
      _service.validateEmail(email);
      // _emailIsValid = true;
      return null;
    } catch (e) {
      // _emailIsValid = false;
      return e.toString();
    }
  }
}
