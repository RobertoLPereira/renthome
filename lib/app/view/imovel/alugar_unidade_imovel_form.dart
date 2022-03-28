import 'dart:convert';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import '../../../nomedosservidores.dart';
import 'alugar_unidade_imovel_form_back.dart';
import 'package:flutter/material.dart';

class AlugarUnidadeImovelForm extends StatefulWidget {
  @override
  State<AlugarUnidadeImovelForm> createState() =>
      _AlugarUnidadeImovelFormState();
}

class _AlugarUnidadeImovelFormState extends State<AlugarUnidadeImovelForm> {
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  List<dynamic> inquilino = [];
  final uriREST = Uri.parse(NomeServidoresApi.Api_Alugueis + '/Pessoas');

  //Definição das propriedades dos campos do formulário
  Widget fieldIdunidade(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        enabled: false,
        onSaved: (newValue) => back.ctr.idunidade,
        initialValue: back.ctr.idunidade.toString(),
        decoration: InputDecoration(
          labelText: 'Unidade:',
        ));
  }

  Widget fieldIdlocador(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        enabled: false,
        validator: back.validateProprietario,
        onSaved: (newValue) => back.ctr.idlocador,
        initialValue: back.ctr.idlocador.toString(),
        decoration: InputDecoration(
          labelText: 'Locador:',
        ));
  }

  Widget fieldDescricao(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        enabled: false,
        onSaved: (newValue) => back.ctr.descricao = newValue,
        initialValue: back.ctr.descricao,
        decoration: InputDecoration(
          labelText: 'Descrição:',
        ));
  }

  Widget fieldCategoria(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        enabled: false,
        onSaved: (newValue) => back.ctr.idimovelcategoria = int.parse(newValue),
        initialValue: back.ctr.idimovelcategoria.toString(),
        decoration: InputDecoration(
          labelText: 'Categoria:',
        ));
  }

  Widget fieldImovel(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        enabled: false,
        onSaved: (newValue) => back.ctr.idimovel = int.parse(newValue),
        initialValue: back.ctr.idimovel.toString(),
        decoration: InputDecoration(
          labelText: 'Imovel:',
        ));
  }

  Widget fieldDiavencimento(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        validator: back.validateDiavencimento,
        onSaved: (newValue) => back.ctr.diavencimento = (newValue),
        onChanged: (value) => back.ctr.diavencimento = (value),
        initialValue: back.ctr.diavencimento,
        decoration: InputDecoration(
          labelText: 'Dia do Vencimento:',
        ));
  }

  Widget fieldValor(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        validator: back.validateValor,
        onSaved: (newValue) => back.ctr.valor = double.parse(newValue),
        onChanged: (value) => back.ctr.valor = double.tryParse(value),
        initialValue: back.ctr.valor.toString(),
        decoration: InputDecoration(
          labelText: 'Valor:',
        ));
  }

  Widget fieldTaxacondominio(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        validator: back.validateTaxacondominio,
        onSaved: (newValue) => back.ctr.taxacondominio = double.parse(newValue),
        onChanged: (value) => back.ctr.taxacondominio = double.tryParse(value),
        initialValue: back.ctr.taxacondominio.toString(),
        decoration: InputDecoration(
          labelText: 'taxacondominio:',
        ));
  }

  Widget fieldValordecaucao(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        validator: back.validateValordecaucao,
        onSaved: (newValue) => back.ctr.valordecaucao = double.parse(newValue),
        onChanged: (value) => back.ctr.valordecaucao = double.tryParse(value),
        initialValue: back.ctr.valordecaucao.toString(),
        decoration: InputDecoration(
          labelText: 'Valor da Caução:',
        ));
  }

  Widget fieldNome(AlugarUnidadeImovelFormBack back) {
    return TextFormField(
        validator: back.validateNome,
        onSaved: (newValue) => back.ctr.nome = newValue,
        onChanged: (value) => back.ctr.nome = value,
        initialValue: back.ctr.nome.toString(),
        decoration: InputDecoration(
          labelText: 'nome:',
        ));
  }

  Widget fieldTelefone(AlugarUnidadeImovelFormBack back) {
    var mask = MaskTextInputFormatter(mask: '(##) # ####-####');
    return TextFormField(
        validator: back.validateTelefone,
        onSaved: (newValue) => back.ctr.telefone = newValue,
        onChanged: (value) => back.ctr.telefone = value,
        initialValue: back.ctr.telefone.toString(),
        inputFormatters: [mask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: 'telefone:', hintText: '(99) 9 9999-9999'));
  }

  Widget fieldInq(AlugarUnidadeImovelFormBack back) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: back.ctr.idlocatario,
          iconSize: 30,
          icon: (null),
          borderRadius: BorderRadius.circular(1),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: Text('Selecione o novo morador'),
          onChanged: (String newValue) {
            setState(() {
              back.ctr.idlocatario = (newValue);
            });
          },
          items: inquilino?.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item['nome']),
                  value: item['idpessoa'].toString(),
                );
              })?.toList() ??
              [],
        ),
      ),
    );
  }

  Widget fieldLocador(AlugarUnidadeImovelFormBack back) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: back.ctr.idlocador.toString(),
          iconSize: 30,
          icon: (null),
          borderRadius: BorderRadius.circular(1),
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          hint: Text('Selecione o Locador'),
          onChanged: (String newValue) {
            setState(() {
              back.ctr.idlocador = int.parse(newValue);
            });
          },
          items: inquilino?.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item['nome']),
                  value: item['idpessoa'].toString(),
                );
              })?.toList() ??
              [],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.fetchInquilino();
  }

  fetchInquilino() async {
    var response = await http.get(uriREST);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        inquilino = items;
        inquilino.add({"idpessoa": 0, "nome": "Selecione o novo morador"});
        isLoading = true;
      });
    } else {
      inquilino = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Apresentação da tela
    var _back = AlugarUnidadeImovelFormBack(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alugar Unidades do Imóvel'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.save),
                tooltip: 'Salvar',
                onPressed: () {
                  _form.currentState.validate();
                  _form.currentState.save();
                  if (_back.isValid) {
                    _back.save(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Form(
          key: _form,
          child: Column(
            children: [
              fieldLocador(_back),
              fieldDescricao(_back),
              fieldInq(_back),
              fieldNome(_back),
              fieldTelefone(_back),
              fieldDiavencimento(_back),
              fieldValor(_back),
              fieldValordecaucao(_back),
              fieldTaxacondominio(_back)
            ],
          ),
        ),
      ),
    );
  }
}
