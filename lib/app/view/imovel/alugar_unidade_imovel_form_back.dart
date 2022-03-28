import 'package:renthome/app/domain/entities/unidade_imovel.dart';
import 'package:renthome/app/domain/regrasdenegocio/services/unidade_imovel_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:renthome/src/api/pessoas/wrap_pessoas_api.dart';
import 'package:renthome/src/models/alugar/wrap_alugar.dart';
import 'package:renthome/src/models/contrato/contrato_wrap.dart';

class AlugarUnidadeImovelFormBack {
  UnidadeImovel unid;
  ContratoWrap ctr;
  AlugarUnidade alugar = new AlugarUnidade();
  var _service = GetIt.I.get<UnidadeImovelService>();
  //bool _idlocadorIsValid;
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

    //Contrato contr = new Contrato();
    String datacad = DateTime.now().year.toString();
    datacad += '-' + DateTime.now().month.toString();
    datacad += '-' + DateTime.now().day.toString();
    DateTime data = DateTime.now();
    data = data.add(const Duration(days: 180));
    String dataval = data.year.toString();
    dataval += '-' + data.month.toString();
    dataval += '-' + data.day.toString();
    ctr.cadastradoem = datacad;
    ctr.validadecontrato = dataval;

    //Cria o cadastro do inquilino
    alugar.idlocador = ctr.idlocador;
    alugar.cadastradoem = ctr.cadastradoem;
    alugar.datacontrato = datacad;
    alugar.diavencimento = int.parse(ctr.diavencimento);
    alugar.idunidadeimovel = ctr.idunidade;
    alugar.validadecontrato = dataval;
    alugar.valor = ctr.valor;
    alugar.taxacondominio = ctr.taxacondominio;
    alugar.valordecaucao = ctr.valordecaucao;
    alugar.valorpago = ctr.valor;
    alugar.nome = ctr.nome;
    alugar.telefone = ctr.telefone;
    alugar.email = ctr.nome + '@email.com';
    alugar.url_avatar =
        'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png';
    print('salvandando $alugar.idunidadeimovel');
    print('alugar $alugar.toJson()');
    print('salvandando $alugar.idlocador');
    if (alugar.idlocador > 0) {
      print('salvandando $alugar.idlocador');
      alugar = (await WrapPessoasApi.criarInquilino(alugar));
    } else {
      print('não salva');
    }
    if (alugar.idpessoa.isNaN || alugar.idpessoa == null) {
      Navigator.of(context).pop();
    } else {
      print('cadastro = $alugar.toJson()');

      await Navigator.of(context).pop();
    }
  }

  //Validar os dados do formulário
  String idLocador(String locador) {
    print(locador);
    try {
      _service.validateIdLocador(locador);
      _diaIsValid = true;
      return null;
    } catch (e) {
      _diaIsValid = false;
      return e.toString();
    }
  }

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
