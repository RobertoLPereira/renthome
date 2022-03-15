import 'package:renthome/src/models/pessoas/pessoas_wrap.dart';

abstract class PessoasWrapState {}

//inicial,Sucesso,Erro, Processando
class InitialPessoasWrapState extends PessoasWrapState {}

class SucessPessoasWrapState extends PessoasWrapState {
  final List<PessoasWrap> wrappessoas;
  SucessPessoasWrapState(this.wrappessoas);
}

class ErrorPessoasWrapState extends PessoasWrapState {
  final String message;
  ErrorPessoasWrapState(this.message);
}

class LoadingPessoasWrapState extends PessoasWrapState {}
