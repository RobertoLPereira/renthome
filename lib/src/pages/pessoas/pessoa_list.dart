// ignore_for_file: unused_import

import 'dart:async';

import 'package:renthome/src/api/pessoas/pessoaswrap_api.dart';
import 'package:renthome/src/models/bens/imovelWrap.dart';
import 'package:renthome/src/models/pessoas/pessoas.dart';
import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';
import 'package:renthome/src/services/pessoas/pessoas_service.dart';
import 'package:renthome/src/states/pessoa_state.dart';
import 'package:renthome/src/states/pessoas/pessoasWrap_state.dart';
import 'package:renthome/src/store/pessoas/pessoasWrap_store.dart';
import 'package:renthome/src/store/pessoas_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uno/uno.dart';

import '../../../nomedasrotas.dart';

class PessoaListPage extends StatefulWidget {
  static const routeName = '/pessoas';

  //final _back = PessoaListPageBack();
  const PessoaListPage({Key key}) : super(key: key);

  @override
  State<PessoaListPage> createState() => _PessoaListPageState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer timer;

  Debouncer({
    this.milliseconds,
    this.action,
    this.timer,
  });

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _PessoaListPageState extends State<PessoaListPage> {
  final store = PessoaStore(PessoaService(Uno()));
  //final wrapstore = PessoasWrapStore(PessoasWrapApi(Uno()));
  final _debouncer = Debouncer(milliseconds: 500);
  var pg = "0";
  var ativo = 1;
  var proprietario = false;

  List<Pessoas> pessoa = [];
  List<Pessoas> filteredpessoa = [];
  CircleAvatar circleAvatar(String url) {
    return (Uri.tryParse(url).isAbsolute)
        ? CircleAvatar(backgroundImage: NetworkImage(url))
        : CircleAvatar(child: Icon(Icons.person));
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
  void initState() {
    super.initState();
    store.fetchPessoa();
    //wrapstore.fetchPessoasWrap();
    //WidgetsBinding.instance?.addPostFrameCallback((_) {
    //context.read<PessoasWrapStore>().fetchPessoas();
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Contatos'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // _back.goToForm(context);
                }),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pesquisar...',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  ),
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filteredpessoa = pessoa
                          .where((u) => (u.nome
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u.nome
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    });
                  });
                },
              ),
            ),
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: store,
          builder: (_, state, child) {
            if (state is LoadingPessoaState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorPessoaState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is SucessPessoaState) {
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Pesquisar...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset('assets/icons/search.svg'),
                    ),
                  ),
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        filteredpessoa = pessoa
                            .where((u) => (u.nome
                                    .toLowerCase()
                                    .contains(string.toLowerCase()) ||
                                u.nome
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                            .toList();
                      });
                    });
                  },
                ),
              );
              return ListView.builder(
                  itemCount: state.pessoas.length,
                  itemBuilder: (_, index) {
                    final pessoa = state.pessoas[index];

                    print('pessoaswrap = $pessoa');
                    String telefone;
                    if (pessoa.telefone == null) {
                      telefone = 'Não informado';
                    } else {
                      telefone = pessoa.telefone;
                    }
                    if (!pessoa.proprietario) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Text(pessoa.nome.substring(0, 1)),
                        ),
                        title: Text(pessoa.nome),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/PessoasDetail', arguments: pessoa);
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
                    } else {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: Text(pessoa.nome.substring(0, 1)),
                        ),
                        title: Text(pessoa.nome),
                        onTap: () {},
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
                    }
                  });
            }
            return Container();
          },
        ));
  }
}

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
  Navigator.of(context).pushNamed('/PessoasForm', arguments: pessoa);
}
