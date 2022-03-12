import 'package:renthome/src/models/apoio/categorias.dart';

abstract class CategoriadeImoveisDAO {
  save(Categorias categoriadeimoveis);

  remove(dynamic id);

  Future<List<Categorias>> find();
}
