import 'dart:async';
import 'package:flutter/material.dart';
import 'package:renthome/src/api/pessoas/wrap_pessoas_api.dart';
import 'package:renthome/src/models/bens/imovelWrap.dart';
import 'package:renthome/src/models/pessoas/pessoas.dart';
import 'package:renthome/src/widgets/serach_widget.dart';

import '../../../nomedasrotas.dart';

class FilterPessoasListPage extends StatefulWidget {
  @override
  FilterPessoasListPageState createState() => FilterPessoasListPageState();
}

class FilterPessoasListPageState extends State<FilterPessoasListPage> {
  List<Pessoas> pessoas = [];
  List<Pessoas> wpessoas = [];
  String query = '';
  Timer debouncer;
  var pg = "0";
  var ativo = 1;
  var proprietario = false;
  String telefone;
  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final pessoas = await WrapPessoasApi.getPessoasWrap(query);

    //setState(() => this.pessoas = pessoas);
    setState(() {
      wpessoas = pessoas;
      this.pessoas = pessoas;
    });
  }

  Widget iconEditButton(Function onPressed) {
    return IconButton(
      icon: Icon(Icons.edit),
      color: Colors.orange,
      onPressed: () {},
    );
  }

  Widget iconPagtoButton(Function onPressed) {
    return IconButton(
        icon: Icon(Icons.money_sharp), color: Colors.green, onPressed: () {});
  }

  Widget iconListarPgButton(Function onPressed) {
    if (int.parse(pg) > 0) {
      return IconButton(
          icon: Icon(Icons.monetization_on),
          color: Colors.green.shade400,
          tooltip: 'Listar Pg',
          onPressed: onPressed);
    } else {
      return IconButton(
          icon: Icon(Icons.list_alt_rounded),
          color: Colors.green.shade400,
          tooltip: 'Sem Pg no mês',
          onPressed: onPressed);
    }
  }

  Widget iconRemoveButton(BuildContext context, Function remove) {
    return IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Confirma a Exclusão?'),
                    actions: [
                      // ignore: deprecated_member_use
                      ElevatedButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      // ignore: deprecated_member_use
                      ElevatedButton(
                        child: Text('Sim'),
                        onPressed: () {},
                      ),
                    ],
                  ));
        });
  }

  Widget iconDelAtivButton(Function onPressed) {
    if (ativo == 2) {
      return IconButton(
          icon: Icon(Icons.update),
          tooltip: 'Reativar',
          color: Colors.green,
          onPressed: onPressed);
    } else {
      return IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          tooltip: 'Desativar',
          onPressed: onPressed);
    }
  }

  Widget iconImovelButton(Function onPressed) {
    return IconButton(
        icon: Icon(Icons.home),
        color: Colors.orange,
        tooltip: 'Manter Imóvel',
        onPressed: onPressed);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Lista de Pessoas'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Pessoas pes;
                  goToForm(context, pes);
                }),
          ],
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: pessoas.length,
                itemBuilder: (context, index) {
                  final pessoa = pessoas[index];
                  if (pessoa.telefone == null) {
                    telefone = 'Não informado';
                  } else {
                    telefone = pessoa.telefone;
                  }
                  if (pessoa.proprietario) {
                    return buildPessoasWrap(pessoa);
                  } else {
                    return buildPessoasProp(pessoa);
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nome ou Telefone',
        onChanged: searchPessoasWrap,
      );

  Future searchPessoasWrap(String query) async => debounce(() async {
        if (pessoas.length < 1) {
          pessoas = await WrapPessoasApi.getPessoasWrap(query);
          wpessoas = pessoas;
        } else {
          pessoas = await WrapPessoasApi.getPessoasFiltro(query, wpessoas);
        }
        if (!mounted) return;

        setState(() {
          this.query = query;
          this.pessoas = pessoas;
        });
      });

  Widget buildPessoasWrap(Pessoas pessoa) => ListTile(
        leading: Image.network(
          pessoa.url_avatar,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(pessoa.nome),
        onTap: () {
          Navigator.of(context).pushNamed('/PessoasDetail', arguments: pessoa);
        },
        subtitle: Text(telefone),
        trailing: Container(
          width: 192,
          child: Row(
            children: [
              iconEditButton(() {
                goToForm(context, pessoa);
              }),
              iconImovelButton(() {
                goToImovel(context, pessoa);
              }),
              iconDelAtivButton(() {
                if (pessoa.status == 1) {
                  remove(pessoa.idpessoa, context);
                } else {
                  reativar(pessoa.idpessoa, context);
                }
              }),
              iconListarPgButton(() {
                goToListaPagamentos(context, pessoa);
              }),
            ],
          ),
        ),
      );
  //Widget para quando a pessoa for proprietário
  Widget buildPessoasProp(Pessoas pessoa) => ListTile(
        leading: Image.network(
          pessoa.url_avatar,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(pessoa.nome),
        onTap: () {
          Navigator.of(context).pushNamed('/PessoasDetail', arguments: pessoa);
        },
        subtitle: Text(telefone),
        trailing: Container(
          width: 192,
          child: Row(
            children: [
              iconEditButton(() {
                goToForm(context, pessoa);
              }),
              iconPagtoButton(() {
                if (int.parse(pg) == 0) {
                  goToListaPagamentos(context, pessoa);
                } else {
                  goToFormPagto(context, pessoa);
                }
              }),
              iconDelAtivButton(() {
                if (pessoa.status == 1) {
                  remove(pessoa.idpessoa, context);
                } else {
                  reativar(pessoa.idpessoa, context);
                }
              }),
              iconListarPgButton(() {
                goToListaPagamentos(context, pessoa);
              }),
            ],
          ),
        ),
      );

  void reativar(int idpessoa, BuildContext context) {}

  void remove(int idpessoa, BuildContext context) {}

  void goToFormPagto(BuildContext context, Pessoas pessoa) {
    Navigator.of(context).pushNamed('/Pagamentos', arguments: pessoa);
  }

  void goToListaPagamentos(BuildContext context, Pessoas pessoa) {
    Navigator.of(context).pushNamed('/PagamentosPessoa', arguments: pessoa);
  }

  void goToImovel(BuildContext context, Pessoas pessoa) {
    ImovelWrap imv = ImovelWrap();
    imv.idproprietario = pessoa.idpessoa;
    imv.idpessoa = pessoa.idpessoa;
    imv.idimovelcategoria = 1;
    imv.status = 1;
    Navigator.of(context).pushNamed(NomedasRotas.IMOVELFORM, arguments: imv);
  }

  void goToForm(BuildContext context, Pessoas pessoa) {
    Navigator.of(context)
        .pushNamed(NomedasRotas.PESSOASFORM, arguments: pessoa);
  }

  void goToFormDetal(BuildContext context, Pessoas pessoa) {
    Navigator.of(context).pushNamed(NomedasRotas.PESSOASDETAIL);
  }
}
