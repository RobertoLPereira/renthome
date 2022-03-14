import 'package:renthome/src/api/pessoas/pessoaswrap_api.dart';
import 'package:renthome/src/states/pessoas/pessoasWrap_state.dart';
import 'package:flutter/material.dart';

class PessoasWrapStore extends ValueNotifier<PessoasWrapState> {
  final PessoasWrapApi pessoasWrap;

  PessoasWrapStore(this.pessoasWrap) : super(InitialPessoasWrapState());
  Future fetchPessoasWrap() async {
    value = LoadingPessoasWrapState();
    try {
      final pessoas = await pessoasWrap.fetchPessoasWrap();
      value = SucessPessoasWrapState(pessoas);
    } catch (e) {
      value = ErrorPessoasWrapState(e.toString());
    }
  }
}
