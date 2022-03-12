import 'package:renthome/src/models/pagamento/pagamentoPessoa.dart';
import 'package:renthome/src/models/pagamento/pagamentos.dart';

abstract class PagamentoDAO {
  save(Pagamentos pagamento);

  remove(dynamic id);

  Future<List<Pagamentos>> find();

  Future<List<PagamentosPessoa>> listar(dynamic idpessoa);
}
