import 'package:renthome/src/models/pagamento/pagamentoPessoa.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';
import 'package:renthome/src/models/pessoas/wrap_pessoas.dart';

abstract class PessoasWrapDAO {
  Future<List<PessoasWrap>> find();
  Future<List<WrapPessoas>> wrapfind();
  Future<List<PagamentosPessoa>> listar(dynamic idpessoa);
  save(PessoasWrap pessoasWrap);
  remove(dynamic id);
  reativar(dynamic id);
}
