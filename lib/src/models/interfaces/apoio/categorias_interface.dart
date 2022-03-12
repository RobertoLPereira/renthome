import 'package:renthome/src/models/apoio/categorias.dart';

abstract class CategoriasIterface {
  save(Categorias categorias);

  remove(dynamic id);

  Future<List<Categorias>> find();
  //uso de chamada REST
}
