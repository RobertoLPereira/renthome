import 'package:flutter/material.dart';
import '../../src/services/pessoas/pessoas_service.dart';
import '../../src/states/pessoa_state.dart';

class PessoaStore extends ValueNotifier<PessoaState> {
  final PessoaService srvPessoa;

  PessoaStore(this.srvPessoa) : super(InitialPessoaState());
  Future fetchPessoa() async {
    value = LoadingPessoaState();
    try {
      final pessoas = await srvPessoa.fetchPessoas();
      value = SucessPessoaState(pessoas);
    } catch (e) {
      value = ErrorPessoaState(e.toString());
    }
  }

  Future getPessoas() async {
    value = LoadingPessoaState();
    try {
      final pessoas = await srvPessoa.getPessoas();
      value = SucessPessoaState(pessoas);
    } catch (e) {
      value = ErrorPessoaState(e.toString());
    }
  }
}
