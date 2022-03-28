/*
//Crie um arquivo com o nome pessoas.dart para representar a classe com essa parte
   import 'dart:convert';
   class Pessoas{String?  idpessoa;
String?  nome;
String?  telefone;
boolean proprietario;
String?  cadastradoem;
String?  status;
String?  url_avatar;
String?  email;
timestamp without time zone createdAt;
timestamp without time zone upString? dAt;

Pessoas({this.idpessoa,this.nome,this.telefone,this.proprietario,this.cadastradoem,this.status,this.url_avatar,this.email,this.createdAt,this.updatedAt});
    Map<String, dynamic> toMap() {
    	return {'idpessoa':idpessoa,
'nome':nome,
'telefone':telefone,
'proprietario':proprietario,
'cadastradoem':cadastradoem,
'status':status,
'url_avatar':url_avatar,
'email':email,
'createdAt':createdAt,
'updatedAt':updatedAt,
};
  	}
   factory Pessoas.fromMap(Map<String, dynamic> map) {
	    return Pessoas(idpessoa:map['idpessoa'],
nome:map['nome'],
telefone:map['telefone'],
proprietario:map['proprietario'],
cadastradoem:map['cadastradoem'],
status:map['status'],
url_avatar:map['url_avatar'],
email:map['email'],
createdAt:map['createdAt'],
updatedAt:map['updatedAt'],
	    );
	  }

	  String toJson() => json.encode(toMap());

	  factory Pessoas.fromJson(String source) =>
	      Pessoas.fromMap(json.decode(source));
   @override
	  String toString() {
	    return 'Pessoas(idpessoa:$idpessoa,nome:$nome,telefone:$telefone,proprietario:$proprietario,cadastradoem:$cadastradoem,status:$status,url_avatar:$url_avatar,email:$email,createdAt:$createdAt,updatedAt:$updatedAt)';
  	}
   }
   //Crie um arquico com o nome domain_layer_exception.dart para atender toda a aplicaao
   class DomainLayerException implements Exception {
	  String cause; 

	  DomainLayerException(this.cause);

	  @override 
	  String toString(){
	    return cause;
	  }

	}
	//crie ou atualize o arquivo nomedasrotas.dart com as informações abaixo
		class NomedasRotas {
	 		static const PESSOAS = '/pessoas';
	 		static const  PESSOAS_FORM= '/pessoas-form';
	 		static const PESSOAS_DETAIL = '/pessoas-detail';
	 	}
import 'package:flutter/material.dart';

		class SearchWidget extends StatefulWidget {
		  final String text;
		  final ValueChanged<String> onChanged;
		  final String hintText;

		  const SearchWidget({
			Key key,
			this.text,
			this.onChanged,
			this.hintText,
		  }) : super(key: key);

		  @override
		  _SearchWidgetState createState() => _SearchWidgetState();
		}

		class _SearchWidgetState extends State<SearchWidget> {
		  final controller = TextEditingController();

		  @override
		  Widget build(BuildContext context) {
			final styleActive = TextStyle(color: Colors.black);
			final styleHint = TextStyle(color: Colors.black54);
			final style = widget.text.isEmpty ? styleHint : styleActive;

			return Container(
			  height: 42,
			  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
			  decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(12),
				color: Colors.white,
				border: Border.all(color: Colors.black26),
			  ),
			  padding: const EdgeInsets.symmetric(horizontal: 8),
			  child: TextField(
				controller: controller,
				decoration: InputDecoration(
				  icon: Icon(Icons.search, color: style.color),
				  suffixIcon: widget.text.isNotEmpty
					  ? GestureDetector(
						  child: Icon(Icons.close, color: style.color),
						  onTap: () {
							controller.clear();
							widget.onChanged(');
							FocusScope.of(context).requestFocus(FocusNode());
						  },
						)
					  : null,
				  hintText: widget.hintText,
				  hintStyle: style,
				  border: InputBorder.none,
				),
				style: style,
				onChanged: widget.onChanged,
			  ),
			);
		  }
		}
		
//Crie um arquivo com o nome pessoas_interface.dart para esta parte
		import '../../models/entidades/pessoas.dart';
		abstract class PessoasInterface {
		  save(Pessoas pessoas);

		  remove(dynamic id);

		  Future<List<Pessoas>> find();
		  //uso de chamada REST

		  Future<List<Pessoas>?> buscarPessoas();
		}
		
//Crie um arquivo pessoas_api.dart para esta parte
	 	
	import 'dart:convert';
	import '../../models/entidades/pessoas.dart';
	import '../../models/interfaces/pessoas_interface.dart';
	import 'package:http/http.dart' as http;
	import 'package:uno/uno.dart';
	
	class PessoasApi implements PessoasInterface {
	final uriREST = Uri.parse('http://192.168.56.1:3050/pessoas');

	@override
	Future<List<Pessoas>> find() async {
	 var resposta = await http.get(uriREST);
	 if(resposta.statusCode != 200) throw Exception('Erro REST API.');
	 Iterable listDart = json.decode(resposta.body); 
	 var listPessoas = List<Pessoas>.from(
	   listDart.map((pessoas) => Pessoas(
		  idpessoa:  pessoas['idpessoa'].toString(),nome:  pessoas['nome'],telefone:  pessoas['telefone'],proprietario:  pessoas['proprietario'],cadastradoem:  pessoas['cadastradoem'],status:  pessoas['status'].toString(),url_avatar:  pessoas['url_avatar'],email:  pessoas['email'],createdAt:  pessoas['createdAt'],updatedAt:  pessoas['updatedAt'],
	   ))
	 );
	 return listPessoas;
	}
	final Uno uno;
	
	  PessoasApi(this.uno);
	  Future<List<Pessoas>> fetchPessoas() async {
	    final response = await uno.get('http://10.0.0.109:3050/Pessoas');
	    final lista = response.data as List;
	    final listaPessoas = lista.map((e) => Pessoas.fromMap(e)).toList();
	    return listaPessoas;
  	  }
  	  
	@override
	remove(id) async{
	 var uri = Uri.parse('http://192.168.56.1:3050/pessoas/$id');
	 var resposta = await http.delete(uri);
	 if(resposta.statusCode != 204) throw Exception('Erro REST API.');
	}

	 @override
	 save(Pessoas pessoas) async {
	   var headers = {
		 'Content-Type': 'application/json'
	   };
	   var pessoasJson = jsonEncode(
		 {'idpessoa':  int.parse(pessoas.idpessoa),'nome':  pessoas.nome,'telefone':  pessoas.telefone,'proprietario':  pessoas.proprietario,'cadastradoem':  pessoas.cadastradoem,'status':  int.parse(pessoas.status),'url_avatar':  pessoas.url_avatar,'email':  pessoas.email,'createdAt':  pessoas.createdAt,'updatedAt':  pessoas.updatedAt,}
	   );
	   int statusCode = 0;
	   if(pessoas.idpessoa == null){
		 var resposta = await http.post(uriREST,headers: headers,body: pessoasJson);
		 statusCode = resposta.statusCode;
	   }else{
		 var resposta = await http.put(uriREST,headers: headers,body:pessoasJson );
		 statusCode = resposta.statusCode;
	   }
	   if(statusCode != 200 && statusCode != 204) throw Exception('Erro REST API.');
	}
	@override
	  Future<List<Pessoas>?> buscarPessoas() {
	    // ignore: todo
	    // TODO: implement buscarIPessoas
	    throw UnimplementedError();
  	 }
  	 
	}
//Crie uma arquivo com o nome pessoas_api com esta parce
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/pessoas/pessoas.dart';

class WrapPessoasApi {
  static const Api_Alugueis =
      NomeServidoresApi.Api_Alugueis +
      '/Consultar/Select * from pessoas';

  static Future<List<Pessoas>> getPessoas(String query) async {
    var resposta = await http.get(Uri.parse(Api_Alugueis));
    if (resposta.statusCode != 200) throw Exception('Erro REST API-Pessoas.');
    if (resposta.statusCode == 200) {
      final List pessoas = json.decode(resposta.body);
      return pessoas.map((json) => Pessoas.fromJson(json)).where((pessoas) {
        final titleLower = pessoas.nome.toLowerCase();
        final authorLower = pessoas.telefone.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  //Método para atender o filtro
  static Future<List<Pessoas>> getPessoasFiltro(
      String query, List<Pessoas> item) async {
    if (item.length > 0) {
      final List<Pessoas> witem = item;
      return witem.where((u) {
        final titleLower = u.nome.toLowerCase();
        final authorLower = u.telefone.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

//Crie um arquivo com nome pessoas_dao_impl com esta parte
		import '../../models/entidades/pessoas.dart';
		import '../../models/interfaces/pessoas_interface.dart';
		import 'package:sqflite/sqflite.dart';

		import '../connection.dart';

		class PessoasDAOImpl implements PessoasInterface {
		  Database _db;

		  @override
		  Future<List<Pessoas>> find() async {
			_db = (await  Connection.get())!;
			List<Map<String,dynamic>> resultado =  await _db.query('pessoas');
			List<Pessoas> lista = List.generate( resultado.length, (i){
			  var pessoas = resultado[i];
			  return Pessoas(
				idpessoa:  pessoas['idpessoa'].toString(),nome:  pessoas['nome'],telefone:  pessoas['telefone'],proprietario:  pessoas['proprietario'],cadastradoem:  pessoas['cadastradoem'],status:  pessoas['status'].toString(),url_avatar:  pessoas['url_avatar'],email:  pessoas['email'],createdAt:  pessoas['createdAt'],updatedAt:  pessoas['updatedAt'],
			  );
			}
			);

			return lista;
		  }

		  @override
		  remove(dynamic id) async {
			_db = (await  Connection.get())!;
			var sql ='DELETE FROM pessoas WHERE idpessoa = ?';
			_db.rawDelete(sql, [id]);
			}

			@override
		  save(Pessoas pessoas) async {
			_db = (await  Connection.get())!;
			var sql;
			if(pessoas.idpessoa == null){
			  sql = 'INSERT INTO pessoas (idpessoa,nome,telefone,proprietario,cadastradoem,status,url_avatar,email,createdAt,updatedAt) VALUES (?,?,?,?,?,?,?,?,?,?)';
			  _db.rawInsert(sql,[pessoas.idpessoa,pessoas.nome,pessoas.telefone,pessoas.proprietario,pessoas.cadastradoem,pessoas.status,pessoas.url_avatar,pessoas.email,pessoas.createdAt,pessoas.updatedAt]);
			}else{
			  sql = 'UPDATE pessoas SET wset WHERE idpessoa = ?';
			  _db.rawUpdate(sql,[pessoas.idpessoa,pessoas.nome,pessoas.telefone,pessoas.proprietario,pessoas.cadastradoem,pessoas.status,pessoas.url_avatar,pessoas.email,pessoas.createdAt,pessoas.updatedAt]);
			}
		  }
		@override
                Future<List<Pessoas>?> buscarPessoas() {
		      // ignore: todo
		      // TODO: implement buscarPessoas
		      throw UnimplementedError();
  		 }
		}

//Crie um arquivo de excecoes com esta parte 
class DomainLayerException implements Exception {	
  String cause; 

  DomainLayerException(this.cause);

  @override 
  String toString(){
    return cause;
  }

}


//Crie um arquivo com o nome pessoas_service.dart com esta parte
import '../../models/entidades/pessoas.dart';
import '../../models/exception/domain_layer_exception.dart';
import '../../models/interfaces/pessoas_interface.dart';
import 'package:get_it/get_it.dart';

class PessoasService{
			var _dao = GetIt.I.get<PessoasInterface>();
			 var format = RegExp(r'^\([1-9]{2}\) [9] [6-9]{1}[0-9]{3}\-[0-9]{4}$'); // (99) 9 9999-9999
			// tem que salvar um pessoas, ter a possibilidade de alterar e excluir e listar todos os contatos
			save(Pessoas pessoas) async {
			
 validateIdpessoa(pessoas.idpessoa.toString());

 validateNome(pessoas.nome.toString());

 validateTelefone(pessoas.telefone.toString());

 validateProprietario(pessoas.proprietario.toString());

 validateCadastradoem(pessoas.cadastradoem.toString());

 validateStatus(pessoas.status.toString());

 validateUrl_Avatar(pessoas.url_avatar.toString());

 validateEmail(pessoas.email.toString());

 validateCreatedat(pessoas.createdAt.toString());

 validateUpdatedat(pessoas.updatedAt.toString());
 
			await _dao.save(pessoas);
			}
			
			remove(dynamic id){
			  _dao.remove(id);
			}
			Future<List<Pessoas>> find(){
			  return _dao.find();
			}
			
 validateIdpessoa(String idpessoa){

if(idpessoa == null){
						throw  DomainLayerException('O idpessoa é obrigatório.');
						}
					}
//nome ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateNome(String nome){

 	  var min = 3;
 	  var max = 50;
if(nome == null){
				throw  DomainLayerException('O nome é obrigatório.');
			  }else if(nome.length < min){
				throw  DomainLayerException('O nome deve possuir pelo menos $min caracteres.');
			  }else if(nome.length > max){
				throw  DomainLayerException('O nome deve possuir no máximo $max caracteres.');
			  }
			} 
//telefone ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateTelefone(String telefone){

 	  var min = 3;
 	  var max = 50;
if(telefone == null){
				throw  DomainLayerException('O telefone é obrigatório.');
			  }else if(telefone.length < min){
				throw  DomainLayerException('O telefone deve possuir pelo menos $min caracteres.');
			  }else if(telefone.length > max){
				throw  DomainLayerException('O telefone deve possuir no máximo $max caracteres.');
			  }
			} 
 validateProprietario(String proprietario){

if(proprietario == null){
						throw  DomainLayerException('O proprietario é obrigatório.');
						}
					}
//cadastradoem ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateCadastradoem(String cadastradoem){

 	  var min = 3;
 	  var max = 50;
if(cadastradoem == null){
				throw  DomainLayerException('O cadastradoem é obrigatório.');
			  }else if(cadastradoem.length < min){
				throw  DomainLayerException('O cadastradoem deve possuir pelo menos $min caracteres.');
			  }else if(cadastradoem.length > max){
				throw  DomainLayerException('O cadastradoem deve possuir no máximo $max caracteres.');
			  }
			} 
 validateStatus(String status){

if(status == null){
						throw  DomainLayerException('O status é obrigatório.');
						}
					}
//url_avatar ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateUrl_Avatar(String url_avatar){

 	  var min = 3;
 	  var max = 50;
if(url_avatar == null){
				throw  DomainLayerException('O url_avatar é obrigatório.');
			  }else if(url_avatar.length < min){
				throw  DomainLayerException('O url_avatar deve possuir pelo menos $min caracteres.');
			  }else if(url_avatar.length > max){
				throw  DomainLayerException('O url_avatar deve possuir no máximo $max caracteres.');
			  }
			} 
//email ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateEmail(String email){

 	  var min = 3;
 	  var max = 50;
if(email == null){
				throw  DomainLayerException('O email é obrigatório.');
			  }else if(email.length < min){
				throw  DomainLayerException('O email deve possuir pelo menos $min caracteres.');
			  }else if(email.length > max){
				throw  DomainLayerException('O email deve possuir no máximo $max caracteres.');
			  }
			} 
//createdAt ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateCreatedat(String createdAt){

 	  var min = 3;
 	  var max = 50;
if(createdAt == null){
				throw  DomainLayerException('O createdAt é obrigatório.');
			  }else if(createdAt.length < min){
				throw  DomainLayerException('O createdAt deve possuir pelo menos $min caracteres.');
			  }else if(createdAt.length > max){
				throw  DomainLayerException('O createdAt deve possuir no máximo $max caracteres.');
			  }
			} 
//updatedAt ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateUpdatedat(String updatedAt){

 	  var min = 3;
 	  var max = 50;
if(updatedAt == null){
				throw  DomainLayerException('O updatedAt é obrigatório.');
			  }else if(updatedAt.length < min){
				throw  DomainLayerException('O updatedAt deve possuir pelo menos $min caracteres.');
			  }else if(updatedAt.length > max){
				throw  DomainLayerException('O updatedAt deve possuir no máximo $max caracteres.');
			  }
			} 
			
		}
//Crie ou altere o arquivo de injecao de dependencia para esta parte 	 
	import 'package:flutter/material.dart';
	import '../../src/database/dao/pessoas_dao_impl.dart';
	import '../../src/models/interfaces/pessoas_interface.dart';
	import '../../src/database/api/pessoas_api.dart';
	import '../services/pessoas_service.dart';
	import 'package:uno/uno.dart';
	import 'package:get_it/get_it.dart';
	setupInjection() async{
	GetIt getIt = GetIt.I;
	  WidgetsFlutterBinding.ensureInitialized();
	  Uno uno;
	  getIt.registerSingleton<PessoasInterface>(PessoasDAOImpl());
	  getIt.registerSingleton<PessoasInterface>(PessoasApi(uno));
	  getIt.registerSingleton<PessoasService>(PessoasService());
	  }
	  

//Crie um arquivo pessoas_list_back.dart com esta parte
//Inclua as rotas no main.dart
import '../../models/entidades/pessoas.dart';
import '../../services/pessoas_service.dart';
import '../../../nomedasrotas.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';
part 'pessoas_list_back.g.dart';

class PessoasListBack = _PessoasListBack with _$PessoasListBack;
abstract class _PessoasListBack with Store{
var _service = GetIt.I.get<PessoasService>();

  //lista de pessoass 
  @observable
  Future<List<Pessoas>> list;

  //metodo para atualizar a lista de pessoass
  @action
  refreshList([dynamic value]){
    list = _service.find();
  }

  _PessoasListBack(){
    refreshList();
  }

  //método para chamar o form salvar/alterar
  goToForm(BuildContext context, [Pessoas pessoas]){
    Navigator.of(context).pushNamed(NomedasRotas.PESSOAS_FORM, arguments: pessoas).then(refreshList);
  }

  goToDetails(BuildContext context, Pessoas pessoas){
    Navigator.of(context).pushNamed(NomedasRotas.PESSOAS_DETAIL, arguments: pessoas);
  }

  //excluir
  remove(int id){
    _service.remove(id); 
    refreshList();
  }

}



//Crie um arquivo com o nome Pessoas_list.dart para exibir na tela os dados com esta parte
import '../../screen/controller/pessoas_list_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListPessoas extends StatelessWidget {
  final _back = PessoasListBack();

  CircleAvatar circleAvatar(String url)  {
    return (Uri.tryParse(url)!.isAbsolute) ?
       CircleAvatar(backgroundImage: NetworkImage(url))
        : CircleAvatar(child: Icon(Icons.person));
  }
  Widget iconCircButton(Function onPressed) {
     return IconButton(icon: Icon(Icons.stairs),
     color: Colors.green,
     onPressed: onPressed);
  }
  
  Widget iconEditButton(Function onPressed){
    return IconButton(icon: Icon(Icons.edit), 
    color: Colors.orange, 
    tooltip: 'Editar',onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, Function remove){
    return IconButton(
      icon: Icon(Icons.delete), 
      color: Colors.red, 
      onPressed: () {
        showDialog(
          context: context, 
          builder:  (context) => AlertDialog(
            title: Text('Excluir'),
            content: Text('Confirma a Exclusão?'),
            actions: [
              ElevatedButton(
                child: Text('Não'), 
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Sim'),
                onPressed: remove,
              ),
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de pessoas'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _back.goToForm(context);
                })
          ],
        ),
        body: Observer(builder: (context) {
          return FutureBuilder(
              future: _back.list,
              builder: (context, futuro) {
                if (!futuro.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List<Pessoas> lista = futuro.data;
                  return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      var pessoas = lista[i];
                      return ListTile(
                        leading: iconCircButton((){}),
        title: Text('$pessoas.nome'),
                        onTap: (){
                          _back.goToDetails(context, pessoas);
                        },subtitle: Text(
		 '$pessoas.telefone'),trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              iconEditButton((){
                                _back.goToForm(context, pessoas);
                              }),
                              iconRemoveButton(context, (){
                                _back.remove(int.parse(pessoas.idpessoa));
                                Navigator.of(context).pop();
                              })
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        }));
  }
}

//Crie um arquivo filter_pessoas_list_page.dart para esta parte
	 import 'dart:async';
import 'package:flutter/material.dart';
import '../../api/pessoas/pessoas_api.dart';
import '../../api/pessoas/pessoas_api.dart';
import '../../models/pessoas/pessoas.dart';
import '../../widgets/serach_widget.dart';

import '../../../nomedasrotas.dart';

class FilterPessoasListPage extends StatefulWidget {
  @override
  FilterPessoasListPageState createState() => FilterPessoasListPageState();
}

class FilterPessoasListPageState extends State<FilterPessoasListPage> {
  List<Pessoas> pessoas = [];
  List<Pessoas> wpessoas = [];
  String query = '';
  var ativo = 1;
  Timer debouncer;
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
    final pessoas = await PessoasApi.getPessoas(query);

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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Lista de Pessoas'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Pessoas pessoas;
                  goToForm(context, pessoas);
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
                  final pessoas = pessoas[index];
                  return buildPessoas(pessoas);                  
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Informe a pesquisa',
        onChanged: searchPessoasWrap,
      );

  Future searchPessoas(String query) async => debounce(() async {
        if (pessoas.length < 1) {
          pessoas = await PessoasApi.getPessoas(query);
          wpessoas = pessoas;
        } else {
          pessoas = await PessoasApi.getPessoasFiltro(query, wpessoas);
        }
        if (!mounted) return;

        setState(() {
          this.query = query;
          this.pessoas = pessoas;
        });
      });

  Widget buildPessoas(Pessoas pessoas) => ListTile(
        leading: Image.network(
          pessoas.url_avatar,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(pessoas.nome),
        onTap: () {
          Navigator.of(context).pushNamed('/PessoasDetail', arguments: pessoas);
        },
        subtitle: Text('Sub titulo'),
        trailing: Container(
          width: 192,
          child: Row(
            children: [
              iconEditButton(() {
                goToForm(context, pessoas);
              }),
              iconDelAtivButton(() {
                if (pessoas.status == 1) {
                  remove(pessoas.idpessoa, context);
                } else {
                  reativar(pessoas.idpessoa, context);
                }
              }),              
            ],
          ),
        ),
      );
  
  void reativar(int idpessoa, BuildContext context) {}

  void remove(int idpessoa, BuildContext context) {}

  void goToForm(BuildContext context, Pessoas pessoas) {
    Navigator.of(context)
        .pushNamed(NomedasRotas.PessoasFORM, arguments: pessoas);
  }

  void goToFormDetal(BuildContext context, Pessoas pessoas) {
    Navigator.of(context).pushNamed(NomedasRotas.PessoasDETAIL);
  }
}

//Inclua/altere as declaracoes dos provider na pagina principal do sistema (myapp)
		return MultiProvider(
		providers: [
			Provider(create: (_) => Uno()),
			Provider(create: (context) => PessoasApi(context.read())),
			ChangeNotifierProvider(create: (context) => PessoasStore(context.read())),
		],
		child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HOME: (context) => HomePage(),
      },
    );
//Crie um arquivop de nome pessoas_state.dart com esta parte
	import '../../src/models/apoio/pessoas.dart';

abstract class PessoasState {}

//inicial,Sucesso,Erro, Processando
class InitialPessoasState extends PessoasState {}

class SucessPessoasState extends PessoasState {
  final List<Pessoas> pessoas;
  SucessPessoasState(this.pessoas);
}

class ErrorPessoasState extends PessoasState {
  final String message;
  ErrorPessoasState(this.message);
}

class LoadingPessoasState extends PessoasState {}

import 'package:flutter/material.dart';
import '../api/pessoas_api.dart';
import '../../src/states/pessoas_state.dart';

class PessoasStore extends ValueNotifier<PessoasState> {
  final PessoasApi srvPessoas;
  
  PessoasStore(this.srvPessoas) : super(InitialPessoasState());
  Future fetchPessoas() async {
    value = LoadingPessoasState();
    try {
      final pessoass = await srvPessoas.fetchPessoas();
      value = SucessPessoasState(pessoass);
    } catch (e) {
      value = ErrorPessoasState(e.toString());
    }
  }
}

//Se optar por usar State e Store, crie um arquivo com o nome pessoasList.dart com esta parte
import 'package:../src/api/apoio/pessoas_api.dart';
	import '../src/models/apoio/pessoas.dart';
	import '../src/states/pessoas_state.dart';
	import '../src/store/pessoas_store.dart';

	import 'package:flutter/material.dart';
	import 'package:provider/src/provider.dart';
	import 'package:uno/uno.dart';

	import '../../../../nomedasrotas.dart';

	class PessoasList extends StatefulWidget {
	  const PessoasList({Key key}) : super(key: key);
	  @override
	  State<PessoasList> createState() => _PessoasListState();
	}

	class _PessoasListState extends State<PessoasList> {
	  final faixaStore = PessoasStore(PessoasApi(Uno()));
	  @override
	  void initState() {
	    super.initState();
	    WidgetsBinding.instance?.addPostFrameCallback((_) {
	      context.read<PessoasStore>().fetchPessoas();
	    });
	  }

	  @override
	  Widget build(BuildContext context) {
	    final store = context.watch<PessoasStore>();
	    final state = store.value;
	    Widget child;
	    if (state is LoadingPessoasState) {
	      child = const Center(
		child: CircularProgressIndicator(),
	      );
	    }
	    if (state is ErrorPessoasState) {
	      child = Center(
		child: Text(state.message),
	      );
	    }
	    if (state is SucessPessoasState) {
	      child = ListView.builder(
		itemCount: state.pessoas.length,
		itemBuilder: (_, index) {
		  Pessoas lista = state.pessoas[index];
		  return Card(
		      elevation: 8,
		      child: Padding(
			padding: EdgeInsets.all(16),
			child: Row(
			  mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  children: <Widget>[
			    Column(
			      crossAxisAlignment: CrossAxisAlignment.start,
			      children: [
				Text(
				  'Nº: ${lista.idpessoa}',
				  style: TextStyle(fontSize: 18),
				),
				Text(
				  'Denominação: ${lista.denominacao}',
				  style: TextStyle(fontSize: 18),
				),
			      ],
			    ),
			    IconButton(
				icon: Icon(Icons.edit, color: Colors.orange),
				onPressed: () => {
				      Navigator.of(context).pushNamed(
					  NomedasRotas.PESSOAS_FORM,
					  arguments: lista)
				    }),
			    IconButton(
				icon: Icon(Icons.delete, color: Colors.redAccent),
				onPressed: () => {
				      Navigator.of(context).pushNamed(
					  NomedasRotas.PESSOAS_DETAIL,
					  arguments: lista.idpessoa)
				    }),
			  ],
			),
		      ));
		},
	      );
	    }
	    return Scaffold(
	      appBar: AppBar(
		title: const Text('Lista de Pessoas'),
	      ),
	      body: child ?? Container(),
	    );
	  }
	}
	

//Crie um arquivo pessoas_form_back.dart para formulario com esta parte
import '../../models/entidades/pessoas.dart';
import '../../services/pessoas_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class PessoasFormBack {
 Pessoas pessoas;
var _service = GetIt.I.get<PessoasService>();
	bool _idpessoaIsValid; 
bool _nomeIsValid; 
bool _telefoneIsValid; 
bool _proprietarioIsValid; 
bool _cadastradoemIsValid; 
bool _statusIsValid; 
bool _url_avatarIsValid; 
bool _emailIsValid; 
bool _createdAtIsValid; 
bool _updatedAtIsValid; 

	bool get isValid => _idpessoaIsValid && _nomeIsValid && _telefoneIsValid && _proprietarioIsValid && _cadastradoemIsValid && _statusIsValid && _url_avatarIsValid && _emailIsValid && _createdAtIsValid && _updatedAtIsValid ;
  // diferenciar novo com alteração 
  PessoasFormBack(BuildContext context){
    var parameter = ModalRoute.of(context)!.settings.arguments;
    pessoas = (parameter == null) ? Pessoas() : parameter;
  }

  //salvar 
  save(BuildContext context) async {
    await _service.save(pessoas!);
    Navigator.of(context).pop();
  }

  //validações  
  String validateIdpessoa(String idpessoa ){
					try{
					  _service.validateIdpessoa (idpessoa);
					  _idpessoaIsValid = true;
					  return null;
			}catch(e){
			  _idpessoaIsValid = false;
			  return e.toString();
			}
		  }
		String validateNome(String nome ){
					try{
					  _service.validateNome (nome);
					  _nomeIsValid = true;
					  return null;
			}catch(e){
			  _nomeIsValid = false;
			  return e.toString();
			}
		  }
		String validateTelefone(String telefone ){
					try{
					  _service.validateTelefone (telefone);
					  _telefoneIsValid = true;
					  return null;
			}catch(e){
			  _telefoneIsValid = false;
			  return e.toString();
			}
		  }
		String validateProprietario(String proprietario ){
					try{
					  _service.validateProprietario (proprietario);
					  _proprietarioIsValid = true;
					  return null;
			}catch(e){
			  _proprietarioIsValid = false;
			  return e.toString();
			}
		  }
		String validateCadastradoem(String cadastradoem ){
					try{
					  _service.validateCadastradoem (cadastradoem);
					  _cadastradoemIsValid = true;
					  return null;
			}catch(e){
			  _cadastradoemIsValid = false;
			  return e.toString();
			}
		  }
		String validateStatus(String status ){
					try{
					  _service.validateStatus (status);
					  _statusIsValid = true;
					  return null;
			}catch(e){
			  _statusIsValid = false;
			  return e.toString();
			}
		  }
		String validateUrl_Avatar(String url_avatar ){
					try{
					  _service.validateUrl_Avatar (url_avatar);
					  _url_avatarIsValid = true;
					  return null;
			}catch(e){
			  _url_avatarIsValid = false;
			  return e.toString();
			}
		  }
		String validateEmail(String email ){
					try{
					  _service.validateEmail (email);
					  _emailIsValid = true;
					  return null;
			}catch(e){
			  _emailIsValid = false;
			  return e.toString();
			}
		  }
		String validateCreatedat(String createdAt ){
					try{
					  _service.validateCreatedat (createdAt);
					  _createdAtIsValid = true;
					  return null;
			}catch(e){
			  _createdAtIsValid = false;
			  return e.toString();
			}
		  }
		String validateUpdatedat(String updatedAt ){
					try{
					  _service.validateUpdatedat (updatedAt);
					  _updatedAtIsValid = true;
					  return null;
			}catch(e){
			  _updatedAtIsValid = false;
			  return e.toString();
			}
		  }
		

}
//Crie um arquivo do tipo formulario pessoasForm.dart com esta parte
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/pessoas_form_back.dart';
 class PessoasForm extends StatelessWidget {
  		final _form = GlobalKey<FormState>();
		//definicao dos campos do formulario
Widget fieldIdpessoa(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateIdpessoa, onSaved: (newValue) => back.pessoas!.idpessoa = newValue as int , onChanged: (value) => back.pessoas!.idpessoa = value ,  initialValue: back.pessoas!.idpessoa.toString(),		  decoration: InputDecoration ( 
					labelText: 'idpessoa:',
				  )
				);
			  }
			Widget fieldNome(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateNome, onSaved: (newValue) => back.pessoas!.nome = newValue as String , onChanged: (value) => back.pessoas!.nome = value ,  initialValue: back.pessoas!.nome.toString(),		  decoration: InputDecoration ( 
					labelText: 'nome:',
				  )
				);
			  }
			Widget fieldTelefone(PessoasFormBack back) {var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
return TextFormField (  
		  validator: back.validateTelefone, onSaved: (newValue) => back.pessoas!.telefone = newValue as String , onChanged: (value) => back.pessoas!.telefone = value ,  initialValue: back.pessoas!.telefone.toString(),inputFormatters: [mask],
		  keyboardType: TextInputType.number,
		  decoration: InputDecoration ( 
					labelText: 'telefone:',
			hintText: '(99) 9 9999-9999'
				  )
				);
			  }
			Widget fieldProprietario(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateProprietario, onSaved: (newValue) => back.pessoas!.proprietario = newValue as boolean, onChanged: (value) => back.pessoas!.proprietario = value ,  initialValue: back.pessoas!.proprietario.toString(),		  decoration: InputDecoration ( 
					labelText: 'proprietario:',
				  )
				);
			  }
			Widget fieldCadastradoem(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateCadastradoem, onSaved: (newValue) => back.pessoas!.cadastradoem = newValue as String , onChanged: (value) => back.pessoas!.cadastradoem = value ,  initialValue: back.pessoas!.cadastradoem.toString(),		  decoration: InputDecoration ( 
					labelText: 'cadastradoem:',
				  )
				);
			  }
			Widget fieldStatus(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateStatus, onSaved: (newValue) => back.pessoas!.status = newValue as int , onChanged: (value) => back.pessoas!.status = value ,  initialValue: back.pessoas!.status.toString(),		  decoration: InputDecoration ( 
					labelText: 'status:',
				  )
				);
			  }
			Widget fieldUrl_Avatar(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateUrl_Avatar, onSaved: (newValue) => back.pessoas!.url_avatar = newValue as String  , onChanged: (value) => back.pessoas!.url_avatar = value ,  initialValue: back.pessoas!.url_avatar.toString(),		  decoration: InputDecoration ( 
					labelText: 'url_avatar:',
				  )
				);
			  }
			Widget fieldEmail(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateEmail, onSaved: (newValue) => back.pessoas!.email = newValue as String  , onChanged: (value) => back.pessoas!.email = value ,  initialValue: back.pessoas!.email.toString(),		  decoration: InputDecoration ( 
					labelText: 'email:',
				  )
				);
			  }
			Widget fieldCreatedat(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateCreatedat, onSaved: (newValue) => back.pessoas!.createdAt = newValue as timestamp without time zone, onChanged: (value) => back.pessoas!.createdAt = value ,  initialValue: back.pessoas!.createdAt.toString(),		  decoration: InputDecoration ( 
					labelText: 'createdAt:',
				  )
				);
			  }
			Widget fieldUpdatedat(PessoasFormBack back) {return TextFormField (  
		  validator: back.validateUpdatedat, onSaved: (newValue) => back.pessoas!.updatedAt = newValue as timestamp without time zone, onChanged: (value) => back.pessoas!.updatedAt = value ,  initialValue: back.pessoas!.updatedAt.toString(),		  decoration: InputDecoration ( 
					labelText: 'updatedAt:',
				  )
				);
			  }
			
		 @override
  Widget build(BuildContext context) {
    var _back = PessoasFormBack(context);
    return Scaffold(
      appBar: AppBar(  
        title: Text('Cadastro de Pessoas'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              _form.currentState!.validate();
              _form.currentState!.save();
              if(_back.isValid){
                _back.save(context);
              }
            })
        ],
      ),
      body: Padding(  
        padding: EdgeInsets.all(10),
        child: Form(  
          key: _form,
          child:  Column (
            children: [
              fieldIdpessoa(_back),
fieldNome(_back),
fieldTelefone(_back),
fieldProprietario(_back),
fieldCadastradoem(_back),
fieldStatus(_back),
fieldUrl_Avatar(_back),
fieldEmail(_back),
fieldCreatedat(_back),
fieldUpdatedat(_back),
            ],
            ),
        ),
      ),
      
    );
  }
}


//Crie um arquivo pessoas_detal_back.dart detalhes com esta parte
import '../../models/entities/pessoas.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class PessoasDetailsBack{
  BuildContext context;
  Pessoas pessoas;

  PessoasDetailsBack(this.context){
    pessoas = ModalRoute.of(context).settings.arguments;
  }

  goToBack(){
    Navigator.of(context).pop();
  }

  _launchApp(String url, Function(BuildContext context) showModalError) async{
    await canLaunch(url) ? await launch(url) : showModalError(context);
  }
  launchIdpessoa(Function(BuildContext context) showModalError){
				_launchApp('idpessoa:${pessoas.idpessoa}', showModalError);
			  }
launchNome(Function(BuildContext context) showModalError){
				_launchApp('nome:${pessoas.nome}', showModalError);
			  }
launchTelefone(Function(BuildContext context) showModalError){
				_launchApp('telefone:${pessoas.telefone}', showModalError);
			  }
launchProprietario(Function(BuildContext context) showModalError){
				_launchApp('proprietario:${pessoas.proprietario}', showModalError);
			  }
launchCadastradoem(Function(BuildContext context) showModalError){
				_launchApp('cadastradoem:${pessoas.cadastradoem}', showModalError);
			  }
launchStatus(Function(BuildContext context) showModalError){
				_launchApp('status:${pessoas.status}', showModalError);
			  }
launchUrl_Avatar(Function(BuildContext context) showModalError){
				_launchApp('url_avatar:${pessoas.url_avatar}', showModalError);
			  }
launchEmail(Function(BuildContext context) showModalError){
				_launchApp('email:${pessoas.email}', showModalError);
			  }
launchCreatedat(Function(BuildContext context) showModalError){
				_launchApp('createdAt:${pessoas.createdAt}', showModalError);
			  }
launchUpdatedat(Function(BuildContext context) showModalError){
				_launchApp('updatedAt:${pessoas.updatedAt}', showModalError);
			  }
  }

//Crie um arquivo com o nome pessoas_detail.dart com esta parte
	import '../../models/entities/pessoas.dart';
import '../../controller/pessoas_details_back.dart';
import 'package:flutter/material.dart';

class PessoasDetails extends StatelessWidget {

  showModalError(BuildContext context){
    var alert = AlertDialog( 
      title: Text('Alerta!'),
      content: Text('Não foi possível encontrar um APP compatível.'),
    );
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var _back = PessoasDetailsBack(context);
    Pessoas pessoas = _back.pessoas;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
       
        var width = constraints.biggest.width; 
		 // ignore: unused_local_variable
        var radius = width/3;
       // var height = constraints.biggest.height;

        return Scaffold(
          body: ListView(  
            padding: EdgeInsets.all(60),
            children: [  
              /*(Uri.tryParse(pessoas.urlAvatar).isAbsolute) ? 
                CircleAvatar(
                  backgroundImage: NetworkImage(pessoas.urlAvatar), 
                  radius:radius ,
                ) : 
                CircleAvatar(
                  child: Icon(
                    Icons.person, 
                    size: width/2,
                  ),
                  radius:radius ,
                ),*/
                 IconButton(
		              icon: Icon(Icons.stairs),
		              color: Colors.green,
		              onPressed: () {},
            ),
              //definicao dos campos do formulario de detalhe
 Center( 
                    child: Text('idpessoa: ${pessoas.idpessoa}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('nome: ${pessoas.nome}', style:  TextStyle(fontSize: 30),),),Card( 
                        child: ListTile( 
                        title: Text('Telefone:'), 
                        subtitle: Text('${pessoas.telefone}'),
                        trailing: Container( 
                            width: width/4 ,
                            child:  Row(
                            children: [
                                IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.message), 
                                onPressed: (){
                                    _back.launchSMS(showModalError);}),
                                IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.phone), 
                                onPressed: (){
                                    _back.launchPhone(showModalError);
                                })]),),),),
 Center( 
                    child: Text('proprietario: ${pessoas.proprietario}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('cadastradoem: ${pessoas.cadastradoem}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('status: ${pessoas.status}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('url_avatar: ${pessoas.url_avatar}', style:  TextStyle(fontSize: 30),),),Card( 
                        child: ListTile( 
                        title: Text('E-mail:'), 
                        onTap: () {
                            _back.launchEmail(showModalError);
                        },
                        subtitle: Text('${pessoas.email}'),)),],), Center( 
                    child: Text('createdAt: ${pessoas.createdAt}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('updatedAt: ${pessoas.updatedAt}', style:  TextStyle(fontSize: 30),),),
          FloatingActionButton( 
            child: Icon(Icons.arrow_back),
            onPressed: (){
              _back.goToBack();
            },
          )],),
        );
      },
    );
  }
}
*/