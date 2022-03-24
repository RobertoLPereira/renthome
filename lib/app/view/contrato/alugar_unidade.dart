/*//Crie um arquivo com o nome alugar.dart para representar a classe com essa parte
   import 'dart:convert';
   class Alugar{
     int  idcontrato;
int  idunidadeimovel;
int  idlocador;
int  idlocatario;
int  diavencimento;
String  datacontrato;
int  status_contrato;
String  validadecontrato;
double  valor;
double  taxacondominio;
double  valordecaucao;
String  nome;
String  telefone;
bool proprietario;
String  cadastradoem;
int  status_pessoa;
String  url_avatar;
String  email;
int  status_unidade;

Alugar({this.idcontrato,this.idunidadeimovel,this.idlocador,this.idlocatario,this.diavencimento,this.datacontrato,this.status_contrato,this.validadecontrato,this.valor,this.taxacondominio,this.valordecaucao,this.nome,this.telefone,this.proprietario,this.cadastradoem,this.status_pessoa,this.url_avatar,this.email,this.status_unidade});
    Map<String, dynamic> toMap() {
    	return {'idcontrato':idcontrato,
'idunidadeimovel':idunidadeimovel,
'idlocador':idlocador,
'idlocatario':idlocatario,
'diavencimento':diavencimento,
'datacontrato':datacontrato,
'status_contrato':status_contrato,
'validadecontrato':validadecontrato,
'valor':valor,
'taxacondominio':taxacondominio,
'valordecaucao':valordecaucao,
'nome':nome,
'telefone':telefone,
'proprietario':proprietario,
'cadastradoem':cadastradoem,
'status_pessoa':status_pessoa,
'url_avatar':url_avatar,
'email':email,
'status_unidade':status_unidade,
};
  	}
   factory Alugar.fromMap(Map<String, dynamic> map) {
	    return Alugar(idcontrato:map['idcontrato'],
idunidadeimovel:map['idunidadeimovel'],
idlocador:map['idlocador'],
idlocatario:map['idlocatario'],
diavencimento:map['diavencimento'],
datacontrato:map['datacontrato'],
status_contrato:map['status_contrato'],
validadecontrato:map['validadecontrato'],
valor:map['valor'],
taxacondominio:map['taxacondominio'],
valordecaucao:map['valordecaucao'],
nome:map['nome'],
telefone:map['telefone'],
proprietario:map['proprietario'],
cadastradoem:map['cadastradoem'],
status_pessoa:map['status_pessoa'],
url_avatar:map['url_avatar'],
email:map['email'],
status_unidade:map['status_unidade'],
	    );
	  }

	  String toJson() => json.encode(toMap());

	  factory Alugar.fromJson(String source) =>
	      Alugar.fromMap(json.decode(source));
   @override
	  String toString() {
	    return 'Alugar(idcontrato:$idcontrato,idunidadeimovel:$idunidadeimovel,idlocador:$idlocador,idlocatario:$idlocatario,diavencimento:$diavencimento,datacontrato:$datacontrato,status_contrato:$status_contrato,validadecontrato:$validadecontrato,valor:$valor,taxacondominio:$taxacondominio,valordecaucao:$valordecaucao,nome:$nome,telefone:$telefone,proprietario:$proprietario,cadastradoem:$cadastradoem,status_pessoa:$status_pessoa,url_avatar:$url_avatar,email:$email,status_unidade:$status_unidade)';
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
	 		static const ALUGAR = '/alugar';
	 		static const  ALUGAR_FORM= '/alugar-form';
	 		static const ALUGAR_DETAIL = '/alugar-detail';
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
		
//Crie um arquivo com o nome alugar_interface.dart para esta parte
		import '../../models/entidades/alugar.dart';
		abstract class AlugarInterface {
		  save(Alugar alugar);

		  remove(dynamic id);

		  Future<List<Alugar>> find();
		  //uso de chamada REST

		  Future<List<Alugar>?> buscarAlugar();
		}
		
//Crie um arquivo alugar_api.dart para esta parte
	 	
	import 'dart:convert';
	import '../../models/entidades/alugar.dart';
	import '../../models/interfaces/alugar_interface.dart';
	import 'package:http/http.dart' as http;
	import 'package:uno/uno.dart';
	
	class AlugarApi implements AlugarInterface {
	final uriREST = Uri.parse('http://192.168.56.1:3050/alugar');

	@override
	Future<List<Alugar>> find() async {
	 var resposta = await http.get(uriREST);
	 if(resposta.statusCode != 200) throw Exception('Erro REST API.');
	 Iterable listDart = json.decode(resposta.body); 
	 var listAlugar = List<Alugar>.from(
	   listDart.map((alugar) => Alugar(
		  idcontrato:  alugar['idcontrato'],idunidadeimovel:  alugar['idunidadeimovel'],idlocador:  alugar['idlocador'],idlocatario:  alugar['idlocatario'],diavencimento:  alugar['diavencimento'],datacontrato:  alugar['datacontrato'],status_contrato:  alugar['status_contrato'],validadecontrato:  alugar['validadecontrato'],valor:   double.parse(alugar['valor']),taxacondominio:   double.parse(alugar['taxacondominio']),valordecaucao:   double.parse(alugar['valordecaucao']),nome:  alugar['nome'],telefone:  alugar['telefone'],proprietario:  alugar['proprietario'],cadastradoem:  alugar['cadastradoem'],status_pessoa:  alugar['status_pessoa'],url_avatar:  alugar['url_avatar'],email:  alugar['email'],status_unidade:  alugar['status_unidade'],
	   ))
	 );
	 return listAlugar;
	}
	final Uno uno;
	
	  AlugarApi(this.uno);
	  Future<List<Alugar>> fetchAlugar() async {
	    final response = await uno.get('http://10.0.0.109:3050/Alugar');
	    final lista = response.data as List;
	    final listaAlugar = lista.map((e) => Alugar.fromMap(e)).toList();
	    return listaAlugar;
  	  }
  	  
	@override
	remove(id) async{
	 var uri = Uri.parse('http://192.168.56.1:3050/alugar/$id');
	 var resposta = await http.delete(uri);
	 if(resposta.statusCode != 204) throw Exception('Erro REST API.');
	}

	 @override
	 save(Alugar alugar) async {
	   var headers = {
		 'Content-Type': 'application/json'
	   };
	   var alugarJson = jsonEncode(
		 {'idcontrato':  int.parse(alugar.idcontrato),'idunidadeimovel':  int.parse(alugar.idunidadeimovel),'idlocador':  int.parse(alugar.idlocador),'idlocatario':  int.parse(alugar.idlocatario),'diavencimento':  int.parse(alugar.diavencimento),'datacontrato':  alugar.datacontrato,'status_contrato':  int.parse(alugar.status_contrato),'validadecontrato':  alugar.validadecontrato,'valor':  double.parse(alugar.valor),'taxacondominio':  double.parse(alugar.taxacondominio),'valordecaucao':  double.parse(alugar.valordecaucao),'nome':  alugar.nome,'telefone':  alugar.telefone,'proprietario':  alugar.proprietario,'cadastradoem':  alugar.cadastradoem,'status_pessoa':  int.parse(alugar.status_pessoa),'url_avatar':  alugar.url_avatar,'email':  alugar.email,'status_unidade':  int.parse(alugar.status_unidade),}
	   );
	   int statusCode = 0;
	   if(alugar.idcontrato == null){
		 var resposta = await http.post(uriREST,headers: headers,body: alugarJson);
		 statusCode = resposta.statusCode;
	   }else{
		 var resposta = await http.put(uriREST,headers: headers,body:alugarJson );
		 statusCode = resposta.statusCode;
	   }
	   if(statusCode != 200 && statusCode != 204) throw Exception('Erro REST API.');
	}
	@override
	  Future<List<Alugar>?> buscarAlugar() {
	    // ignore: todo
	    // TODO: implement buscarIAlugar
	    throw UnimplementedError();
  	 }
  	 
	}
//Crie uma arquivo com o nome alugar_api com esta parce
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/alugar/alugar.dart';

class WrapAlugarApi {
  static const Api_Alugueis =
      'https://apialugueis.herokuapp.com/Consultar/Select * from alugar';

  static Future<List<Alugar>> getAlugar(String query) async {
    var resposta = await http.get(Uri.parse(Api_Alugueis));
    if (resposta.statusCode != 200) throw Exception('Erro REST API-Alugar.');
    if (resposta.statusCode == 200) {
      final List alugar = json.decode(resposta.body);
      return alugar.map((json) => Alugar.fromJson(json)).where((alugar) {
        final titleLower = alugar.nome.toLowerCase();
        final authorLower = alugar.telefone.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  //Método para atender o filtro
  static Future<List<Alugar>> getAlugarFiltro(
      String query, List<Alugar> item) async {
    if (item.length > 0) {
      final List<Alugar> witem = item;
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

//Crie um arquivo com nome alugar_dao_impl com esta parte
		import '../../models/entidades/alugar.dart';
		import '../../models/interfaces/alugar_interface.dart';
		import 'package:sqflite/sqflite.dart';

		import '../connection.dart';

		class AlugarDAOImpl implements AlugarInterface {
		  Database _db;

		  @override
		  Future<List<Alugar>> find() async {
			_db = (await  Connection.get())!;
			List<Map<String,dynamic>> resultado =  await _db.query('alugar');
			List<Alugar> lista = List.generate( resultado.length, (i){
			  var alugar = resultado[i];
			  return Alugar(
				idcontrato:  alugar['idcontrato'],idunidadeimovel:  alugar['idunidadeimovel'],idlocador:  alugar['idlocador'],idlocatario:  alugar['idlocatario'],diavencimento:  alugar['diavencimento'],datacontrato:  alugar['datacontrato'],status_contrato:  alugar['status_contrato'],validadecontrato:  alugar['validadecontrato'],valor:   double.parse(alugar['valor']),taxacondominio:   double.parse(alugar['taxacondominio']),valordecaucao:   double.parse(alugar['valordecaucao']),nome:  alugar['nome'],telefone:  alugar['telefone'],proprietario:  alugar['proprietario'],cadastradoem:  alugar['cadastradoem'],status_pessoa:  alugar['status_pessoa'],url_avatar:  alugar['url_avatar'],email:  alugar['email'],status_unidade:  alugar['status_unidade'],
			  );
			}
			);

			return lista;
		  }

		  @override
		  remove(dynamic id) async {
			_db = (await  Connection.get())!;
			var sql ='DELETE FROM alugar WHERE idunidadeimovel = ?';
			_db.rawDelete(sql, [id]);
			}

			@override
		  save(Alugar alugar) async {
			_db = (await  Connection.get())!;
			var sql;
			if(alugar.idunidadeimovel == null){
			  sql = 'INSERT INTO alugar (idcontrato,idunidadeimovel,idlocador,idlocatario,diavencimento,datacontrato,status_contrato,validadecontrato,valor,taxacondominio,valordecaucao,nome,telefone,proprietario,cadastradoem,status_pessoa,url_avatar,email,status_unidade) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';
			  _db.rawInsert(sql,[alugar.idcontrato,alugar.idunidadeimovel,alugar.idlocador,alugar.idlocatario,alugar.diavencimento,alugar.datacontrato,alugar.status_contrato,alugar.validadecontrato,alugar.valor,alugar.taxacondominio,alugar.valordecaucao,alugar.nome,alugar.telefone,alugar.proprietario,alugar.cadastradoem,alugar.status_pessoa,alugar.url_avatar,alugar.email,alugar.status_unidade]);
			}else{
			  sql = 'UPDATE alugar SET wset WHERE idunidadeimovel = ?';
			  _db.rawUpdate(sql,[alugar.idcontrato,alugar.idunidadeimovel,alugar.idlocador,alugar.idlocatario,alugar.diavencimento,alugar.datacontrato,alugar.status_contrato,alugar.validadecontrato,alugar.valor,alugar.taxacondominio,alugar.valordecaucao,alugar.nome,alugar.telefone,alugar.proprietario,alugar.cadastradoem,alugar.status_pessoa,alugar.url_avatar,alugar.email,alugar.status_unidade]);
			}
		  }
		@override
                Future<List<Alugar>?> buscarAlugar() {
		      // ignore: todo
		      // TODO: implement buscarAlugar
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


//Crie um arquivo com o nome alugar_service.dart com esta parte
import '../../models/entidades/alugar.dart';
import '../../models/exception/domain_layer_exception.dart';
import '../../models/interfaces/alugar_interface.dart';
import 'package:get_it/get_it.dart';

class AlugarService{
			var _dao = GetIt.I.get<AlugarInterface>();
			 var format = RegExp(r'^\([1-9]{2}\) [9] [6-9]{1}[0-9]{3}\-[0-9]{4}$'); // (99) 9 9999-9999
			// tem que salvar um alugar, ter a possibilidade de alterar e excluir e listar todos os contatos
			save(Alugar alugar) async {
			
 validateIdcontrato(alugar.idcontrato.toString());

 validateIdunidadeimovel(alugar.idunidadeimovel.toString());

 validateIdlocador(alugar.idlocador.toString());

 validateIdlocatario(alugar.idlocatario.toString());

 validateDiavencimento(alugar.diavencimento.toString());

 validateDatacontrato(alugar.datacontrato.toString());

 validateStatus_Contrato(alugar.status_contrato.toString());

 validateValidadecontrato(alugar.validadecontrato.toString());

 validateValor(alugar.valor.toString());

 validateTaxacondominio(alugar.taxacondominio.toString());

 validateValordecaucao(alugar.valordecaucao.toString());

 validateNome(alugar.nome.toString());

 validateTelefone(alugar.telefone.toString());

 validateProprietario(alugar.proprietario.toString());

 validateCadastradoem(alugar.cadastradoem.toString());

 validateStatus_Pessoa(alugar.status_pessoa.toString());

 validateUrl_Avatar(alugar.url_avatar.toString());

 validateEmail(alugar.email.toString());

 validateStatus_Unidade(alugar.status_unidade.toString());
 
			await _dao.save(alugar);
			}
			
			remove(dynamic id){
			  _dao.remove(id);
			}
			Future<List<Alugar>> find(){
			  return _dao.find();
			}
			
 validateIdcontrato(String idcontrato){

if(idcontrato == null){
						throw  DomainLayerException('O idcontrato é obrigatório.');
						}
					}
 validateIdunidadeimovel(String idunidadeimovel){

if(idunidadeimovel == null){
						throw  DomainLayerException('O idunidadeimovel é obrigatório.');
						}
					}
 validateIdlocador(String idlocador){

if(idlocador == null){
						throw  DomainLayerException('O idlocador é obrigatório.');
						}
					}
 validateIdlocatario(String idlocatario){

if(idlocatario == null){
						throw  DomainLayerException('O idlocatario é obrigatório.');
						}
					}
 validateDiavencimento(String diavencimento){

if(diavencimento == null){
						throw  DomainLayerException('O diavencimento é obrigatório.');
						}
					}
//datacontrato ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateDatacontrato(String datacontrato){

 	  var min = 3;
 	  var max = 50;
if(datacontrato == null){
				throw  DomainLayerException('O datacontrato é obrigatório.');
			  }else if(datacontrato.length < min){
				throw  DomainLayerException('O datacontrato deve possuir pelo menos $min caracteres.');
			  }else if(datacontrato.length > max){
				throw  DomainLayerException('O datacontrato deve possuir no máximo $max caracteres.');
			  }
			} 
 validateStatus_Contrato(String status_contrato){

if(status_contrato == null){
						throw  DomainLayerException('O status_contrato é obrigatório.');
						}
					}
//validadecontrato ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateValidadecontrato(String validadecontrato){

 	  var min = 3;
 	  var max = 50;
if(validadecontrato == null){
				throw  DomainLayerException('O validadecontrato é obrigatório.');
			  }else if(validadecontrato.length < min){
				throw  DomainLayerException('O validadecontrato deve possuir pelo menos $min caracteres.');
			  }else if(validadecontrato.length > max){
				throw  DomainLayerException('O validadecontrato deve possuir no máximo $max caracteres.');
			  }
			} 
//valor ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateValor(String valor){

 	  var min = 3;
 	  var max = 50;
if(valor == null){
				throw  DomainLayerException('O valor é obrigatório.');
			  }else if(valor.length < min){
				throw  DomainLayerException('O valor deve possuir pelo menos $min caracteres.');
			  }else if(valor.length > max){
				throw  DomainLayerException('O valor deve possuir no máximo $max caracteres.');
			  }
			} 
//taxacondominio ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateTaxacondominio(String taxacondominio){

 	  var min = 3;
 	  var max = 50;
if(taxacondominio == null){
				throw  DomainLayerException('O taxacondominio é obrigatório.');
			  }else if(taxacondominio.length < min){
				throw  DomainLayerException('O taxacondominio deve possuir pelo menos $min caracteres.');
			  }else if(taxacondominio.length > max){
				throw  DomainLayerException('O taxacondominio deve possuir no máximo $max caracteres.');
			  }
			} 
//valordecaucao ? seja obrigatório, tenha no mínimo 3 caracteres e no máximo 50 
 validateValordecaucao(String valordecaucao){

 	  var min = 3;
 	  var max = 50;
if(valordecaucao == null){
				throw  DomainLayerException('O valordecaucao é obrigatório.');
			  }else if(valordecaucao.length < min){
				throw  DomainLayerException('O valordecaucao deve possuir pelo menos $min caracteres.');
			  }else if(valordecaucao.length > max){
				throw  DomainLayerException('O valordecaucao deve possuir no máximo $max caracteres.');
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
 validateStatus_Pessoa(String status_pessoa){

if(status_pessoa == null){
						throw  DomainLayerException('O status_pessoa é obrigatório.');
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
 validateStatus_Unidade(String status_unidade){

if(status_unidade == null){
						throw  DomainLayerException('O status_unidade é obrigatório.');
						}
					}
			
		}
//Crie ou altere o arquivo de injecao de dependencia para esta parte 	 
	import 'package:flutter/material.dart';
	import '../../src/database/dao/alugar_dao_impl.dart';
	import '../../src/models/interfaces/alugar_interface.dart';
	import '../../src/database/api/alugar_api.dart';
	import '../services/alugar_service.dart';
	import 'package:uno/uno.dart';
	import 'package:get_it/get_it.dart';
	setupInjection() async{
	GetIt getIt = GetIt.I;
	  WidgetsFlutterBinding.ensureInitialized();
	  Uno uno;
	  getIt.registerSingleton<AlugarInterface>(AlugarDAOImpl());
	  getIt.registerSingleton<AlugarInterface>(AlugarApi(uno));
	  getIt.registerSingleton<AlugarService>(AlugarService());
	  }
	  

//Crie um arquivo alugar_list_back.dart com esta parte
//Inclua as rotas no main.dart
import '../../models/entidades/alugar.dart';
import '../../services/alugar_service.dart';
import '../../../nomedasrotas.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';
part 'alugar_list_back.g.dart';

class AlugarListBack = _AlugarListBack with _$AlugarListBack;
abstract class _AlugarListBack with Store{
var _service = GetIt.I.get<AlugarService>();

  //lista de alugars 
  @observable
  Future<List<Alugar>> list;

  //metodo para atualizar a lista de alugars
  @action
  refreshList([dynamic value]){
    list = _service.find();
  }

  _AlugarListBack(){
    refreshList();
  }

  //método para chamar o form salvar/alterar
  goToForm(BuildContext context, [Alugar alugar]){
    Navigator.of(context).pushNamed(NomedasRotas.ALUGAR_FORM, arguments: alugar).then(refreshList);
  }

  goToDetails(BuildContext context, Alugar alugar){
    Navigator.of(context).pushNamed(NomedasRotas.ALUGAR_DETAIL, arguments: alugar);
  }

  //excluir
  remove(int id){
    _service.remove(id); 
    refreshList();
  }

}



//Crie um arquivo com o nome Alugar_list.dart para exibir na tela os dados com esta parte
import '../../screen/controller/alugar_list_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListAlugar extends StatelessWidget {
  final _back = AlugarListBack();

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
          title: Text('Lista de alugar'),
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
                  List<Alugar> lista = futuro.data;
                  return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      var alugar = lista[i];
                      return ListTile(
                        leading: iconCircButton((){}),
        title: Text('$alugar.idunidadeimovel'),
                        onTap: (){
                          _back.goToDetails(context, alugar);
                        },subtitle: Text(
		 '$alugar.idlocador'),trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              iconEditButton((){
                                _back.goToForm(context, alugar);
                              }),
                              iconRemoveButton(context, (){
                                _back.remove(int.parse(alugar.idcontrato));
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

//Crie um arquivo filter_alugar_list_page.dart para esta parte
	 import 'dart:async';
import 'package:flutter/material.dart';
import '../../api/alugar/alugar_api.dart';
import '../../api/alugar/alugar_api.dart';
import '../../models/alugar/alugar.dart';
import '../../widgets/serach_widget.dart';

import '../../../nomedasrotas.dart';

class FilterAlugarListPage extends StatefulWidget {
  @override
  FilterAlugarListPageState createState() => FilterAlugarListPageState();
}

class FilterAlugarListPageState extends State<FilterAlugarListPage> {
  List<Alugar> alugar = [];
  List<Alugar> walugar = [];
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
    final alugar = await AlugarApi.getAlugar(query);

    //setState(() => this.pessoas = pessoas);
    setState(() {
      walugar = alugar;
      this.alugar = alugar;
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
          title: Text('Lista de Alugar'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Alugar alugar;
                  goToForm(context, alugar);
                }),
          ],
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: alugar.length,
                itemBuilder: (context, index) {
                  final alugar = alugar[index];
                  return buildAlugar(alugar);                  
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

  Future searchAlugar(String query) async => debounce(() async {
        if (alugar.length < 1) {
          alugar = await AlugarApi.getAlugar(query);
          walugar = alugar;
        } else {
          alugar = await AlugarApi.getAlugarFiltro(query, walugar);
        }
        if (!mounted) return;

        setState(() {
          this.query = query;
          this.alugar = alugar;
        });
      });

  Widget buildAlugar(Alugar alugar) => ListTile(
        leading: Image.network(
          alugar.url_avatar,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(alugar.nome),
        onTap: () {
          Navigator.of(context).pushNamed('/AlugarDetail', arguments: alugar);
        },
        subtitle: Text('Sub titulo'),
        trailing: Container(
          width: 192,
          child: Row(
            children: [
              iconEditButton(() {
                goToForm(context, alugar);
              }),
              iconDelAtivButton(() {
                if (alugar.status == 1) {
                  remove(alugar.idunidadeimovel, context);
                } else {
                  reativar(alugar.idunidadeimovel, context);
                }
              }),              
            ],
          ),
        ),
      );
  
  void reativar(int idunidadeimovel, BuildContext context) {}

  void remove(int idunidadeimovel, BuildContext context) {}

  void goToForm(BuildContext context, Alugar alugar) {
    Navigator.of(context)
        .pushNamed(NomedasRotas.AlugarFORM, arguments: alugar);
  }

  void goToFormDetal(BuildContext context, Alugar alugar) {
    Navigator.of(context).pushNamed(NomedasRotas.AlugarDETAIL);
  }
}

//Inclua/altere as declaracoes dos provider na pagina principal do sistema (myapp)
		return MultiProvider(
		providers: [
			Provider(create: (_) => Uno()),
			Provider(create: (context) => AlugarApi(context.read())),
			ChangeNotifierProvider(create: (context) => AlugarStore(context.read())),
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
//Crie um arquivop de nome alugar_state.dart com esta parte
	import '../../src/models/apoio/alugar.dart';

abstract class AlugarState {}

//inicial,Sucesso,Erro, Processando
class InitialAlugarState extends AlugarState {}

class SucessAlugarState extends AlugarState {
  final List<Alugar> alugar;
  SucessAlugarState(this.alugar);
}

class ErrorAlugarState extends AlugarState {
  final String message;
  ErrorAlugarState(this.message);
}

class LoadingAlugarState extends AlugarState {}

import 'package:flutter/material.dart';
import '../api/alugar_api.dart';
import '../../src/states/alugar_state.dart';

class AlugarStore extends ValueNotifier<AlugarState> {
  final AlugarApi srvAlugar;
  
  AlugarStore(this.srvAlugar) : super(InitialAlugarState());
  Future fetchAlugar() async {
    value = LoadingAlugarState();
    try {
      final alugars = await srvAlugar.fetchAlugar();
      value = SucessAlugarState(alugars);
    } catch (e) {
      value = ErrorAlugarState(e.toString());
    }
  }
}

//Se optar por usar State e Store, crie um arquivo com o nome alugarList.dart com esta parte
import 'package:../src/api/apoio/alugar_api.dart';
	import '../src/models/apoio/alugar.dart';
	import '../src/states/alugar_state.dart';
	import '../src/store/alugar_store.dart';

	import 'package:flutter/material.dart';
	import 'package:provider/src/provider.dart';
	import 'package:uno/uno.dart';

	import '../../../../nomedasrotas.dart';

	class AlugarList extends StatefulWidget {
	  const AlugarList({Key key}) : super(key: key);
	  @override
	  State<AlugarList> createState() => _AlugarListState();
	}

	class _AlugarListState extends State<AlugarList> {
	  final faixaStore = AlugarStore(AlugarApi(Uno()));
	  @override
	  void initState() {
	    super.initState();
	    WidgetsBinding.instance?.addPostFrameCallback((_) {
	      context.read<AlugarStore>().fetchAlugar();
	    });
	  }

	  @override
	  Widget build(BuildContext context) {
	    final store = context.watch<AlugarStore>();
	    final state = store.value;
	    Widget child;
	    if (state is LoadingAlugarState) {
	      child = const Center(
		child: CircularProgressIndicator(),
	      );
	    }
	    if (state is ErrorAlugarState) {
	      child = Center(
		child: Text(state.message),
	      );
	    }
	    if (state is SucessAlugarState) {
	      child = ListView.builder(
		itemCount: state.alugar.length,
		itemBuilder: (_, index) {
		  Alugar lista = state.alugar[index];
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
				  'Nº: ${lista.idunidadeimovel}',
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
					  NomedasRotas.ALUGAR_FORM,
					  arguments: lista)
				    }),
			    IconButton(
				icon: Icon(Icons.delete, color: Colors.redAccent),
				onPressed: () => {
				      Navigator.of(context).pushNamed(
					  NomedasRotas.ALUGAR_DETAIL,
					  arguments: lista.idunidadeimovel)
				    }),
			  ],
			),
		      ));
		},
	      );
	    }
	    return Scaffold(
	      appBar: AppBar(
		title: const Text('Lista de Alugar'),
	      ),
	      body: child ?? Container(),
	    );
	  }
	}
	

//Crie um arquivo alugar_form_back.dart para formulario com esta parte
import '../../models/entidades/alugar.dart';
import '../../services/alugar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class AlugarFormBack {
 Alugar alugar;
var _service = GetIt.I.get<AlugarService>();
	bool _idcontratoIsValid; 
bool _idunidadeimovelIsValid; 
bool _idlocadorIsValid; 
bool _idlocatarioIsValid; 
bool _diavencimentoIsValid; 
bool _datacontratoIsValid; 
bool _status_contratoIsValid; 
bool _validadecontratoIsValid; 
bool _valorIsValid; 
bool _taxacondominioIsValid; 
bool _valordecaucaoIsValid; 
bool _nomeIsValid; 
bool _telefoneIsValid; 
bool _proprietarioIsValid; 
bool _cadastradoemIsValid; 
bool _status_pessoaIsValid; 
bool _url_avatarIsValid; 
bool _emailIsValid; 
bool _status_unidadeIsValid; 

	bool get isValid => _idcontratoIsValid && _idunidadeimovelIsValid && _idlocadorIsValid && _idlocatarioIsValid && _diavencimentoIsValid && _datacontratoIsValid && _status_contratoIsValid && _validadecontratoIsValid && _valorIsValid && _taxacondominioIsValid && _valordecaucaoIsValid && _nomeIsValid && _telefoneIsValid && _proprietarioIsValid && _cadastradoemIsValid && _status_pessoaIsValid && _url_avatarIsValid && _emailIsValid && _status_unidadeIsValid ;
  // diferenciar novo com alteração 
  AlugarFormBack(BuildContext context){
    var parameter = ModalRoute.of(context)!.settings.arguments;
    alugar = (parameter == null) ? Alugar() : parameter;
  }

  //salvar 
  save(BuildContext context) async {
    await _service.save(alugar!);
    Navigator.of(context).pop();
  }

  //validações  
  String validateIdcontrato(String idcontrato ){
					try{
					  _service.validateIdcontrato (idcontrato);
					  _idcontratoIsValid = true;
					  return null;
			}catch(e){
			  _idcontratoIsValid = false;
			  return e.toString();
			}
		  }
		String validateIdunidadeimovel(String idunidadeimovel ){
					try{
					  _service.validateIdunidadeimovel (idunidadeimovel);
					  _idunidadeimovelIsValid = true;
					  return null;
			}catch(e){
			  _idunidadeimovelIsValid = false;
			  return e.toString();
			}
		  }
		String validateIdlocador(String idlocador ){
					try{
					  _service.validateIdlocador (idlocador);
					  _idlocadorIsValid = true;
					  return null;
			}catch(e){
			  _idlocadorIsValid = false;
			  return e.toString();
			}
		  }
		String validateIdlocatario(String idlocatario ){
					try{
					  _service.validateIdlocatario (idlocatario);
					  _idlocatarioIsValid = true;
					  return null;
			}catch(e){
			  _idlocatarioIsValid = false;
			  return e.toString();
			}
		  }
		String validateDiavencimento(String diavencimento ){
					try{
					  _service.validateDiavencimento (diavencimento);
					  _diavencimentoIsValid = true;
					  return null;
			}catch(e){
			  _diavencimentoIsValid = false;
			  return e.toString();
			}
		  }
		String validateDatacontrato(String datacontrato ){
					try{
					  _service.validateDatacontrato (datacontrato);
					  _datacontratoIsValid = true;
					  return null;
			}catch(e){
			  _datacontratoIsValid = false;
			  return e.toString();
			}
		  }
		String validateStatus_Contrato(String status_contrato ){
					try{
					  _service.validateStatus_Contrato (status_contrato);
					  _status_contratoIsValid = true;
					  return null;
			}catch(e){
			  _status_contratoIsValid = false;
			  return e.toString();
			}
		  }
		String validateValidadecontrato(String validadecontrato ){
					try{
					  _service.validateValidadecontrato (validadecontrato);
					  _validadecontratoIsValid = true;
					  return null;
			}catch(e){
			  _validadecontratoIsValid = false;
			  return e.toString();
			}
		  }
		String validateValor(String valor ){
					try{
					  _service.validateValor (valor);
					  _valorIsValid = true;
					  return null;
			}catch(e){
			  _valorIsValid = false;
			  return e.toString();
			}
		  }
		String validateTaxacondominio(String taxacondominio ){
					try{
					  _service.validateTaxacondominio (taxacondominio);
					  _taxacondominioIsValid = true;
					  return null;
			}catch(e){
			  _taxacondominioIsValid = false;
			  return e.toString();
			}
		  }
		String validateValordecaucao(String valordecaucao ){
					try{
					  _service.validateValordecaucao (valordecaucao);
					  _valordecaucaoIsValid = true;
					  return null;
			}catch(e){
			  _valordecaucaoIsValid = false;
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
		String validateStatus_Pessoa(String status_pessoa ){
					try{
					  _service.validateStatus_Pessoa (status_pessoa);
					  _status_pessoaIsValid = true;
					  return null;
			}catch(e){
			  _status_pessoaIsValid = false;
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
		String validateStatus_Unidade(String status_unidade ){
					try{
					  _service.validateStatus_Unidade (status_unidade);
					  _status_unidadeIsValid = true;
					  return null;
			}catch(e){
			  _status_unidadeIsValid = false;
			  return e.toString();
			}
		  }
		

}
//Crie um arquivo do tipo formulario alugarForm.dart com esta parte
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controller/alugar_form_back.dart';
 class AlugarForm extends StatelessWidget {
  		final _form = GlobalKey<FormState>();
		//definicao dos campos do formulario
      Widget fieldIdcontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdcontrato, onSaved: (newValue) => back.alugar!.idcontrato = newValue as int , onChanged: (value) => back.alugar!.idcontrato = value ,  initialValue: back.alugar!.idcontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'idcontrato:',
				  )
				);
			  }
			Widget fieldIdunidadeimovel(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdunidadeimovel, onSaved: (newValue) => back.alugar!.idunidadeimovel = newValue as int , onChanged: (value) => back.alugar!.idunidadeimovel = value ,  initialValue: back.alugar!.idunidadeimovel.toString(),		  decoration: InputDecoration ( 
					labelText: 'idunidadeimovel:',
				  )
				);
			  }
			Widget fieldIdlocador(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdlocador, onSaved: (newValue) => back.alugar!.idlocador = newValue as int , onChanged: (value) => back.alugar!.idlocador = value ,  initialValue: back.alugar!.idlocador.toString(),		  decoration: InputDecoration ( 
					labelText: 'idlocador:',
				  )
				);
			  }
			Widget fieldIdlocatario(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdlocatario, onSaved: (newValue) => back.alugar!.idlocatario = newValue as int , onChanged: (value) => back.alugar!.idlocatario = value ,  initialValue: back.alugar!.idlocatario.toString(),		  decoration: InputDecoration ( 
					labelText: 'idlocatario:',
				  )
				);
			  }
			Widget fieldDiavencimento(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateDiavencimento, onSaved: (newValue) => back.alugar!.diavencimento = newValue as int , onChanged: (value) => back.alugar!.diavencimento = value ,  initialValue: back.alugar!.diavencimento.toString(),		  decoration: InputDecoration ( 
					labelText: 'diavencimento:',
				  )
				);
			  }
			Widget fieldDatacontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateDatacontrato, onSaved: (newValue) => back.alugar!.datacontrato = newValue as String , onChanged: (value) => back.alugar!.datacontrato = value ,  initialValue: back.alugar!.datacontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'datacontrato:',
				  )
				);
			  }
			Widget fieldStatus_Contrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Contrato, onSaved: (newValue) => back.alugar!.status_contrato = newValue as int , onChanged: (value) => back.alugar!.status_contrato = value ,  initialValue: back.alugar!.status_contrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_contrato:',
				  )
				);
			  }
			Widget fieldValidadecontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValidadecontrato, onSaved: (newValue) => back.alugar!.validadecontrato = newValue as String , onChanged: (value) => back.alugar!.validadecontrato = value ,  initialValue: back.alugar!.validadecontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'validadecontrato:',
				  )
				);
			  }
			Widget fieldValor(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValor, onSaved: (newValue) => back.alugar!.valor = newValue as double , onChanged: (value) => back.alugar!.valor = value ,  initialValue: back.alugar!.valor.toString(),		  decoration: InputDecoration ( 
					labelText: 'valor:',
				  )
				);
			  }
			Widget fieldTaxacondominio(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateTaxacondominio, onSaved: (newValue) => back.alugar!.taxacondominio = newValue as double , onChanged: (value) => back.alugar!.taxacondominio = value ,  initialValue: back.alugar!.taxacondominio.toString(),		  decoration: InputDecoration ( 
					labelText: 'taxacondominio:',
				  )
				);
			  }
			Widget fieldValordecaucao(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValordecaucao, onSaved: (newValue) => back.alugar!.valordecaucao = newValue as double , onChanged: (value) => back.alugar!.valordecaucao = value ,  initialValue: back.alugar!.valordecaucao.toString(),		  decoration: InputDecoration ( 
					labelText: 'valordecaucao:',
				  )
				);
			  }
			Widget fieldNome(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateNome, onSaved: (newValue) => back.alugar!.nome = newValue as String  , onChanged: (value) => back.alugar!.nome = value ,  initialValue: back.alugar!.nome.toString(),		  decoration: InputDecoration ( 
					labelText: 'nome:',
				  )
				);
			  }
			Widget fieldTelefone(AlugarFormBack back) {var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
return TextFormField (  
		  validator: back.validateTelefone, onSaved: (newValue) => back.alugar!.telefone = newValue as String  , onChanged: (value) => back.alugar!.telefone = value ,  initialValue: back.alugar!.telefone.toString(),inputFormatters: [mask],
		  keyboardType: TextInputType.number,
		  decoration: InputDecoration ( 
					labelText: 'telefone:',
			hintText: '(99) 9 9999-9999'
				  )
				);
			  }
			Widget fieldProprietario(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateProprietario, onSaved: (newValue) => back.alugar!.proprietario = newValue as boolean, onChanged: (value) => back.alugar!.proprietario = value ,  initialValue: back.alugar!.proprietario.toString(),		  decoration: InputDecoration ( 
					labelText: 'proprietario:',
				  )
				);
			  }
			Widget fieldCadastradoem(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateCadastradoem, onSaved: (newValue) => back.alugar!.cadastradoem = newValue as String , onChanged: (value) => back.alugar!.cadastradoem = value ,  initialValue: back.alugar!.cadastradoem.toString(),		  decoration: InputDecoration ( 
					labelText: 'cadastradoem:',
				  )
				);
			  }
			Widget fieldStatus_Pessoa(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Pessoa, onSaved: (newValue) => back.alugar!.status_pessoa = newValue as int , onChanged: (value) => back.alugar!.status_pessoa = value ,  initialValue: back.alugar!.status_pessoa.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_pessoa:',
				  )
				);
			  }
			Widget fieldUrl_Avatar(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateUrl_Avatar, onSaved: (newValue) => back.alugar!.url_avatar = newValue as String  , onChanged: (value) => back.alugar!.url_avatar = value ,  initialValue: back.alugar!.url_avatar.toString(),		  decoration: InputDecoration ( 
					labelText: 'url_avatar:',
				  )
				);
			  }
			Widget fieldEmail(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateEmail, onSaved: (newValue) => back.alugar!.email = newValue as String  , onChanged: (value) => back.alugar!.email = value ,  initialValue: back.alugar!.email.toString(),		  decoration: InputDecoration ( 
					labelText: 'email:',
				  )
				);
			  }
			Widget fieldStatus_Unidade(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Unidade, onSaved: (newValue) => back.alugar!.status_unidade = newValue as int , onChanged: (value) => back.alugar!.status_unidade = value ,  initialValue: back.alugar!.status_unidade.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_unidade:',
				  )
				);
			  }
			
		 @override
  Widget build(BuildContext context) {
    var _back = AlugarFormBack(context);
    return Scaffold(
      appBar: AppBar(  
        title: Text('Cadastro de Alugar'),
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
              fieldIdcontrato(_back),
fieldIdunidadeimovel(_back),
fieldIdlocador(_back),
fieldIdlocatario(_back),
fieldDiavencimento(_back),
fieldDatacontrato(_back),
fieldStatus_Contrato(_back),
fieldValidadecontrato(_back),
fieldValor(_back),
fieldTaxacondominio(_back),
fieldValordecaucao(_back),
fieldNome(_back),
fieldTelefone(_back),
fieldProprietario(_back),
fieldCadastradoem(_back),
fieldStatus_Pessoa(_back),
fieldUrl_Avatar(_back),
fieldEmail(_back),
fieldStatus_Unidade(_back),
            ],
            ),
        ),
      ),
      
    );
  }
}


//Crie um arquivo alugar_detal_back.dart detalhes com esta parte
import '../../models/entities/alugar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AlugarDetailsBack{
  BuildContext context;
  Alugar alugar;

  AlugarDetailsBack(this.context){
    alugar = ModalRoute.of(context).settings.arguments;
  }

  goToBack(){
    Navigator.of(context).pop();
  }

  _launchApp(String url, Function(BuildContext context) showModalError) async{
    await canLaunch(url) ? await launch(url) : showModalError(context);
  }
  launchIdcontrato(Function(BuildContext context) showModalError){
				_launchApp('idcontrato:${alugar.idcontrato}', showModalError);
			  }
launchIdunidadeimovel(Function(BuildContext context) showModalError){
				_launchApp('idunidadeimovel:${alugar.idunidadeimovel}', showModalError);
			  }
launchIdlocador(Function(BuildContext context) showModalError){
				_launchApp('idlocador:${alugar.idlocador}', showModalError);
			  }
launchIdlocatario(Function(BuildContext context) showModalError){
				_launchApp('idlocatario:${alugar.idlocatario}', showModalError);
			  }
launchDiavencimento(Function(BuildContext context) showModalError){
				_launchApp('diavencimento:${alugar.diavencimento}', showModalError);
			  }
launchDatacontrato(Function(BuildContext context) showModalError){
				_launchApp('datacontrato:${alugar.datacontrato}', showModalError);
			  }
launchStatus_Contrato(Function(BuildContext context) showModalError){
				_launchApp('status_contrato:${alugar.status_contrato}', showModalError);
			  }
launchValidadecontrato(Function(BuildContext context) showModalError){
				_launchApp('validadecontrato:${alugar.validadecontrato}', showModalError);
			  }
launchValor(Function(BuildContext context) showModalError){
				_launchApp('valor:${alugar.valor}', showModalError);
			  }
launchTaxacondominio(Function(BuildContext context) showModalError){
				_launchApp('taxacondominio:${alugar.taxacondominio}', showModalError);
			  }
launchValordecaucao(Function(BuildContext context) showModalError){
				_launchApp('valordecaucao:${alugar.valordecaucao}', showModalError);
			  }
launchNome(Function(BuildContext context) showModalError){
				_launchApp('nome:${alugar.nome}', showModalError);
			  }
launchTelefone(Function(BuildContext context) showModalError){
				_launchApp('telefone:${alugar.telefone}', showModalError);
			  }
launchProprietario(Function(BuildContext context) showModalError){
				_launchApp('proprietario:${alugar.proprietario}', showModalError);
			  }
launchCadastradoem(Function(BuildContext context) showModalError){
				_launchApp('cadastradoem:${alugar.cadastradoem}', showModalError);
			  }
launchStatus_Pessoa(Function(BuildContext context) showModalError){
				_launchApp('status_pessoa:${alugar.status_pessoa}', showModalError);
			  }
launchUrl_Avatar(Function(BuildContext context) showModalError){
				_launchApp('url_avatar:${alugar.url_avatar}', showModalError);
			  }
launchEmail(Function(BuildContext context) showModalError){
				_launchApp('email:${alugar.email}', showModalError);
			  }
launchStatus_Unidade(Function(BuildContext context) showModalError){
				_launchApp('status_unidade:${alugar.status_unidade}', showModalError);
			  }
  }

//Crie um arquivo com o nome alugar_detail.dart com esta parte
	import '../../models/entities/alugar.dart';
import '../../controller/alugar_details_back.dart';
import 'package:flutter/material.dart';

class AlugarDetails extends StatelessWidget {

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
    var _back = AlugarDetailsBack(context);
    Alugar alugar = _back.alugar;

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
              /*(Uri.tryParse(alugar.urlAvatar).isAbsolute) ? 
                CircleAvatar(
                  backgroundImage: NetworkImage(alugar.urlAvatar), 
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
                    child: Text('idcontrato: ${alugar.idcontrato}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('idunidadeimovel: ${alugar.idunidadeimovel}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('idlocador: ${alugar.idlocador}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('idlocatario: ${alugar.idlocatario}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('diavencimento: ${alugar.diavencimento}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('datacontrato: ${alugar.datacontrato}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('status_contrato: ${alugar.status_contrato}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('validadecontrato: ${alugar.validadecontrato}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('valor: ${alugar.valor}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('taxacondominio: ${alugar.taxacondominio}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('valordecaucao: ${alugar.valordecaucao}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('nome: ${alugar.nome}', style:  TextStyle(fontSize: 30),),),Card( 
                        child: ListTile( 
                        title: Text('Telefone:'), 
                        subtitle: Text('${alugar.telefone}'),
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
                    child: Text('proprietario: ${alugar.proprietario}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('cadastradoem: ${alugar.cadastradoem}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('status_pessoa: ${alugar.status_pessoa}', style:  TextStyle(fontSize: 30),),), Center( 
                    child: Text('url_avatar: ${alugar.url_avatar}', style:  TextStyle(fontSize: 30),),),Card( 
                        child: ListTile( 
                        title: Text('E-mail:'), 
                        onTap: () {
                            _back.launchEmail(showModalError);
                        },
                        subtitle: Text('${alugar.email}'),)),],), Center( 
                    child: Text('status_unidade: ${alugar.status_unidade}', style:  TextStyle(fontSize: 30),),),
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
}import 'dart:convert';
import '../../../nomedosservidores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alugar_form_controller.dart';

class AlugarForm extends StatefulWidget {
  @override
  State<AlugarForm> createState() => _AlugarFormState();
}

class _AlugarFormState extends State<AlugarForm> {
  final _form = GlobalKey<FormState>();
 
  bool xforekey = false;
  Lforekey = [];
  //definicao dos campos do formulario
Widget fieldIdcontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdcontrato, onSaved: (newValue) => back.alugar!.idcontrato = newValue as int , onChanged: (value) => back.alugar!.idcontrato = value ,  initialValue: back.alugar!.idcontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'idcontrato:',
				  )
				);
			  }
			Widget fieldIdunidadeimovel(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdunidadeimovel, onSaved: (newValue) => back.alugar!.idunidadeimovel = newValue as int , onChanged: (value) => back.alugar!.idunidadeimovel = value ,  initialValue: back.alugar!.idunidadeimovel.toString(),		  decoration: InputDecoration ( 
					labelText: 'idunidadeimovel:',
				  )
				);
			  }
			Widget fieldIdlocador(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdlocador, onSaved: (newValue) => back.alugar!.idlocador = newValue as int , onChanged: (value) => back.alugar!.idlocador = value ,  initialValue: back.alugar!.idlocador.toString(),		  decoration: InputDecoration ( 
					labelText: 'idlocador:',
				  )
				);
			  }
			Widget fieldIdlocatario(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateIdlocatario, onSaved: (newValue) => back.alugar!.idlocatario = newValue as int , onChanged: (value) => back.alugar!.idlocatario = value ,  initialValue: back.alugar!.idlocatario.toString(),		  decoration: InputDecoration ( 
					labelText: 'idlocatario:',
				  )
				);
			  }
			Widget fieldDiavencimento(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateDiavencimento, onSaved: (newValue) => back.alugar!.diavencimento = newValue as int , onChanged: (value) => back.alugar!.diavencimento = value ,  initialValue: back.alugar!.diavencimento.toString(),		  decoration: InputDecoration ( 
					labelText: 'diavencimento:',
				  )
				);
			  }
			Widget fieldDatacontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateDatacontrato, onSaved: (newValue) => back.alugar!.datacontrato = newValue as String , onChanged: (value) => back.alugar!.datacontrato = value ,  initialValue: back.alugar!.datacontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'datacontrato:',
				  )
				);
			  }
			Widget fieldStatus_Contrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Contrato, onSaved: (newValue) => back.alugar!.status_contrato = newValue as int , onChanged: (value) => back.alugar!.status_contrato = value ,  initialValue: back.alugar!.status_contrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_contrato:',
				  )
				);
			  }
			Widget fieldValidadecontrato(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValidadecontrato, onSaved: (newValue) => back.alugar!.validadecontrato = newValue as String , onChanged: (value) => back.alugar!.validadecontrato = value ,  initialValue: back.alugar!.validadecontrato.toString(),		  decoration: InputDecoration ( 
					labelText: 'validadecontrato:',
				  )
				);
			  }
			Widget fieldValor(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValor, onSaved: (newValue) => back.alugar!.valor = newValue as double , onChanged: (value) => back.alugar!.valor = value ,  initialValue: back.alugar!.valor.toString(),		  decoration: InputDecoration ( 
					labelText: 'valor:',
				  )
				);
			  }
			Widget fieldTaxacondominio(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateTaxacondominio, onSaved: (newValue) => back.alugar!.taxacondominio = newValue as double , onChanged: (value) => back.alugar!.taxacondominio = value ,  initialValue: back.alugar!.taxacondominio.toString(),		  decoration: InputDecoration ( 
					labelText: 'taxacondominio:',
				  )
				);
			  }
			Widget fieldValordecaucao(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateValordecaucao, onSaved: (newValue) => back.alugar!.valordecaucao = newValue as double , onChanged: (value) => back.alugar!.valordecaucao = value ,  initialValue: back.alugar!.valordecaucao.toString(),		  decoration: InputDecoration ( 
					labelText: 'valordecaucao:',
				  )
				);
			  }
			Widget fieldNome(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateNome, onSaved: (newValue) => back.alugar!.nome = newValue as String  , onChanged: (value) => back.alugar!.nome = value ,  initialValue: back.alugar!.nome.toString(),		  decoration: InputDecoration ( 
					labelText: 'nome:',
				  )
				);
			  }
			Widget fieldTelefone(AlugarFormBack back) {var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
return TextFormField (  
		  validator: back.validateTelefone, onSaved: (newValue) => back.alugar!.telefone = newValue as String  , onChanged: (value) => back.alugar!.telefone = value ,  initialValue: back.alugar!.telefone.toString(),inputFormatters: [mask],
		  keyboardType: TextInputType.number,
		  decoration: InputDecoration ( 
					labelText: 'telefone:',
			hintText: '(99) 9 9999-9999'
				  )
				);
			  }
			Widget fieldProprietario(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateProprietario, onSaved: (newValue) => back.alugar!.proprietario = newValue as boolean, onChanged: (value) => back.alugar!.proprietario = value ,  initialValue: back.alugar!.proprietario.toString(),		  decoration: InputDecoration ( 
					labelText: 'proprietario:',
				  )
				);
			  }
			Widget fieldCadastradoem(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateCadastradoem, onSaved: (newValue) => back.alugar!.cadastradoem = newValue as String , onChanged: (value) => back.alugar!.cadastradoem = value ,  initialValue: back.alugar!.cadastradoem.toString(),		  decoration: InputDecoration ( 
					labelText: 'cadastradoem:',
				  )
				);
			  }
			Widget fieldStatus_Pessoa(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Pessoa, onSaved: (newValue) => back.alugar!.status_pessoa = newValue as int , onChanged: (value) => back.alugar!.status_pessoa = value ,  initialValue: back.alugar!.status_pessoa.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_pessoa:',
				  )
				);
			  }
			Widget fieldUrl_Avatar(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateUrl_Avatar, onSaved: (newValue) => back.alugar!.url_avatar = newValue as String  , onChanged: (value) => back.alugar!.url_avatar = value ,  initialValue: back.alugar!.url_avatar.toString(),		  decoration: InputDecoration ( 
					labelText: 'url_avatar:',
				  )
				);
			  }
			Widget fieldEmail(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateEmail, onSaved: (newValue) => back.alugar!.email = newValue as String  , onChanged: (value) => back.alugar!.email = value ,  initialValue: back.alugar!.email.toString(),		  decoration: InputDecoration ( 
					labelText: 'email:',
				  )
				);
			  }
			Widget fieldStatus_Unidade(AlugarFormBack back) {return TextFormField (  
		  validator: back.validateStatus_Unidade, onSaved: (newValue) => back.alugar!.status_unidade = newValue as int , onChanged: (value) => back.alugar!.status_unidade = value ,  initialValue: back.alugar!.status_unidade.toString(),		  decoration: InputDecoration ( 
					labelText: 'status_unidade:',
				  )
				);
			  }
			

  int idpessoa;
  var url;
  
  @override
  void initState() {
    super.initState();
    this.fetchUser();
    this.fetchStatus();
    this.fetchCategoria();
    this.fetchUnidadeImovel();
    xinitState
  }

  xfetch
 
  fetchftb() async {
    var url = NomeServidoresApi.Api_Alugueis + 'falugar';
    var response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        _categoria = items;
        isCategLoading = true;
      });
    } else {
      isCategLoading = false;
      _categoria = [];
    }
  }

  fetchAlugar() async {
    var url = NomeServidoresApi.Api_Alugueis + 'Alugar';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        _alugar = items;
        isAlugarLoading = true;
      });
    } else {
      isAlugarLoading = false;
      _alugar = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var _back = AlugarFormController(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de alugar'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _form.currentState.validate();
                _form.currentState.save();
                if (_back.isValid) {
                  _back.save(context);
                }
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
               xcampos
            ],
          ),
        ),
      ),
    );
  }
}*/