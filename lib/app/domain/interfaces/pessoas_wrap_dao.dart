import 'package:renthome/src/models/pagamento/pagamentoPessoa.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';

abstract class PessoasWrapDAO {
  Future<List<PessoasWrap>> find();
  Future<List<PagamentosPessoa>> listar(dynamic idpessoa);
  save(PessoasWrap pessoasWrap);
  remove(dynamic id);
  reativar(dynamic id);
}
