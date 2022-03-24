import 'package:renthome/app/domain/entities/unidade_imovel.dart';
import 'package:renthome/app/domain/exception/domain_layer_exception.dart';
import 'package:renthome/src/models/interfaces/bens/imovelunidade_interface.dart';
import 'package:get_it/get_it.dart';

class UnidadeImovelService {
  //Manter a Unidade do imovel (Inclui/Alterar/Consulta e Excluir)
  var _interface = GetIt.I.get<ImovelUnidadeDAO>();
  //Incluir e alterar
  salvar(UnidadeImovel unid) async {
    print('Service =>');
    print(unid);
    validarDescricao(unid.descricao);
    validarCategoria(unid.idimovelcategoria);
    validarImovel(unid.idimovel);
    if (unid.status == 3) {
      validarLocatario(unid.idlocatario.toString());
    }
    await _interface.save(unid);
  }

  //Excluir logicamente uma unidade
  Desativar(dynamic idunidade) async {
    await _interface.remove(idunidade);
  }

  //Ativar uma unidade de imóvel
  Ativar(dynamic idunidade) async {
    await _interface.reativar(idunidade);
  }

  //Validar os dados antes de Incluir/Alterar
  validarDescricao(String desc) {
    var min = 3;
    var max = 50;
    if (desc == null) {
      throw new DomainLayerException('A descrição é obrigatória!');
    } else if (desc.length < min) {
      throw new DomainLayerException(
          'A descrição deve possuir pelo menos $min caracteres.');
    } else if (desc.length > max) {
      throw new DomainLayerException(
          'A descrição deve possuir no máximo $max caracteres.');
    }
  }

  validarDiavencimento(String dia) {
    var min = 1;
    var max = 31;
    if (dia == null) {
      throw new DomainLayerException('O Dia do vencimento é obrigatório!');
    } else if (dia.length < min) {
      throw new DomainLayerException(
          'O dia não é válido, deve ser maior ou igual a $min caracteres.');
    } else if (dia.length > max) {
      throw new DomainLayerException(
          'O dia não é válido, deve ser menor ou igual a $min caracteres.');
    }
  }

  validarImovel(String imovel) {
    if (imovel == null) {
      throw new DomainLayerException('O imovel é obrigatório!');
    }
  }

  validarLocatario(String locatario) {
    if (int.parse(locatario) == 0 || locatario == null) {
      throw new DomainLayerException('O locatário é obrigatório!');
    }
  }

  validarCategoria(String categoria) {
    var min = 1;
    var max = 2;
    if (categoria == null) {
      throw new DomainLayerException('a categoria é obrigatória!');
    } else if (categoria.length < min) {
      throw new DomainLayerException(
          'A categoria do locatário deve possuir pelo menos $min caracteres.');
    } else if (categoria.length > max) {
      throw new DomainLayerException(
          'A categoria do locatário deve possuir no máximo $max caracteres.');
    }
  }

  //valor ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateValor(String valor) {
    var min = 3;
    var max = 50;
    if (valor == null) {
      throw DomainLayerException('O valor é obrigatório.');
    } else if (valor.length < min) {
      throw DomainLayerException(
          'O valor deve possuir pelo menos $min caracteres.');
    } else if (valor.length > max) {
      throw DomainLayerException(
          'O valor deve possuir no máximo $max caracteres.');
    }
  }

//taxacondominio ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateTaxacondominio(String taxacondominio) {
    var min = 3;
    var max = 50;
    if (taxacondominio == null) {
      throw DomainLayerException('O taxacondominio é obrigatório.');
    } else if (taxacondominio.length < min) {
      throw DomainLayerException(
          'O taxacondominio deve possuir pelo menos $min caracteres.');
    } else if (taxacondominio.length > max) {
      throw DomainLayerException(
          'O taxacondominio deve possuir no máximo $max caracteres.');
    }
  }

//valordecaucao ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateValordecaucao(String valordecaucao) {
    var min = 3;
    var max = 50;
    if (valordecaucao == null) {
      throw DomainLayerException('O valordecaucao é obrigatório.');
    } else if (valordecaucao.length < min) {
      throw DomainLayerException(
          'O valordecaucao deve possuir pelo menos $min caracteres.');
    } else if (valordecaucao.length > max) {
      throw DomainLayerException(
          'O valordecaucao deve possuir no máximo $max caracteres.');
    }
  }

//nome ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateNome(String nome) {
    var min = 3;
    var max = 50;
    if (nome == null) {
      throw DomainLayerException('O nome é obrigatório.');
    } else if (nome.length < min) {
      throw DomainLayerException(
          'O nome deve possuir pelo menos $min caracteres.');
    } else if (nome.length > max) {
      throw DomainLayerException(
          'O nome deve possuir no máximo $max caracteres.');
    }
  }

//telefone ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateTelefone(String telefone) {
    var min = 3;
    var max = 50;
    if (telefone == null) {
      throw DomainLayerException('O telefone é obrigatório.');
    } else if (telefone.length < min) {
      throw DomainLayerException(
          'O telefone deve possuir pelo menos $min caracteres.');
    } else if (telefone.length > max) {
      throw DomainLayerException(
          'O telefone deve possuir no máximo $max caracteres.');
    }
  }

  validateProprietario(String proprietario) {
    if (proprietario == null) {
      throw DomainLayerException('O proprietario é obrigatório.');
    }
  }

//cadastradoem ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateCadastradoem(String cadastradoem) {
    var min = 3;
    var max = 50;
    if (cadastradoem == null) {
      throw DomainLayerException('O cadastradoem é obrigatório.');
    } else if (cadastradoem.length < min) {
      throw DomainLayerException(
          'O cadastradoem deve possuir pelo menos $min caracteres.');
    } else if (cadastradoem.length > max) {
      throw DomainLayerException(
          'O cadastradoem deve possuir no máximo $max caracteres.');
    }
  }

  validateStatus_Pessoa(String status_pessoa) {
    if (status_pessoa == null) {
      throw DomainLayerException('O status_pessoa é obrigatório.');
    }
  }

//url_avatar ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateUrl_Avatar(String url_avatar) {
    var min = 3;
    var max = 50;
    if (url_avatar == null) {
      throw DomainLayerException('O url_avatar é obrigatório.');
    } else if (url_avatar.length < min) {
      throw DomainLayerException(
          'O url_avatar deve possuir pelo menos $min caracteres.');
    } else if (url_avatar.length > max) {
      throw DomainLayerException(
          'O url_avatar deve possuir no máximo $max caracteres.');
    }
  }

//email ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50
  validateEmail(String email) {
    var min = 3;
    var max = 50;
    if (email == null) {
      throw DomainLayerException('O email é obrigatório.');
    } else if (email.length < min) {
      throw DomainLayerException(
          'O email deve possuir pelo menos $min caracteres.');
    } else if (email.length > max) {
      throw DomainLayerException(
          'O email deve possuir no máximo $max caracteres.');
    }
  }
}
