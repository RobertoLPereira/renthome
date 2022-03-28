import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../constants.dart';
import '../../../responsive_layout.dart';
import '../../nomedosservidores.dart';
import '../charts.dart';
import 'package:http/http.dart' as http;

class Todo {
  String name;
  bool enable;
  Todo({this.enable = true, this.name});
}

class PanelLeftPage extends StatefulWidget {
  @override
  _PanelLeftPageState createState() => _PanelLeftPageState();
}

class _PanelLeftPageState extends State<PanelLeftPage> {
  List<Todo> _todos = [];
  double wtotal = 0.00;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchUnidadesEmDia();
  }

  fetchUnidadesEmDia() async {
    try {
      setState(() async {
        var url = NomeServidoresApi.Api_Alugueis +
            '/Consultar/select * from "vw_unidades_em_dia_mescorrente"';
        try {
          var response = await http.get(Uri.tryParse(url));

          if (response.statusCode == 200) {
            Iterable listDart = json.decode(response.body);

            setState(() {
              for (Map<String, dynamic> map in listDart) {
                _todos.add(Todo(name: (map['name']), enable: true));
              }
              isLoading = false;
            });
          } else {
            _todos = [];
            isLoading = false;
          }
          isLoading = true;
        } catch (e) {
          isLoading = false;
          print('Servidor ($url) fora do ar');
          if (e.toString() == 'XMLHttpRequest error') {}
          print(e.toString());
        }
      });
    } catch (e) {
      isLoading = false;
      print('deu erro ' + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (ResponsiveLayout.isComputer(context))
            Container(
              color: Constants.purpleLight,
              width: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Constants.purpleDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.kPadding / 2,
                      top: Constants.kPadding / 2,
                      right: Constants.kPadding / 2),
                  child: Card(
                      color: Constants.purpleLight,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Observer(builder: (_) {
                        return Container(
                          width: double.infinity,
                          child: ListTile(
                            //leading: Icon(Icons.shopping_basket),
                            title: Text(
                              "Valor total de Contrato",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "100% Contratado",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Chip(
                              label: Text(
                                'R\$$wtotal',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                PieChartSample2(),
                LineChartSample2(),
                Padding(
                  padding: const EdgeInsets.only(
                      right: Constants.kPadding / 2,
                      bottom: Constants.kPadding,
                      top: Constants.kPadding,
                      left: Constants.kPadding / 2),
                  child: Card(
                    color: Constants.purpleLight,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: List.generate(
                        _todos.length,
                        (index) => CheckboxListTile(
                          title: Text(
                            _todos[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                          value: _todos[index].enable,
                          onChanged: (newValue) {
                            setState(() {
                              _todos[index].enable = newValue ?? true;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
