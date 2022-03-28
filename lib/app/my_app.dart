// ignore_for_file: unused_import

import 'package:renthome/app/api/imovelunidade_rest_api.dart';
import 'package:renthome/src/api/apoio/categorias_api.dart';
import 'package:renthome/src/api/apoio/faixadeconsumo_api.dart';
import 'package:renthome/src/api/apoio/naturezarelacionamento_api.dart';
import 'package:renthome/src/api/apoio/status_api.dart';
import 'package:renthome/src/models/modelonegocio/leituradeconsumo_api.dart';
import 'package:renthome/src/pages/default/boasvindas_page.dart';
import 'package:renthome/src/pages/imovel/index_page.dart';
import 'package:renthome/src/pages/teste/demos.dart';

import 'package:renthome/src/pages/teste/homepage.dart';
import 'package:renthome/src/store/categoriadeimoveis_store.dart';
import 'package:renthome/src/store/faixadeconsumo_store.dart';
import 'package:renthome/src/store/imovelunidade_store.dart';
import 'package:renthome/src/store/leituraaguaunidade_store.dart';
import 'package:renthome/src/store/naturezarelacionamento_store.dart';
import 'package:renthome/src/store/status_store.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

import '../widget_tree.dart';
import 'api/leituraaguaunidade_api.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Uno()),
        Provider(create: (context) => StatusApi(context.read())),
        Provider(create: (context) => CategoriasAPI(context.read())),
        Provider(
            create: (context) => NaturezarelacionamentoApi(context.read())),
        Provider(create: (context) => FaixadeconsumoApi(context.read())),
        Provider(create: (context) => LeituraaguaunidadeApi(context.read())),
        Provider(create: (context) => LeituraDeConsumoApi()),
        Provider(create: (context) => ImovelUnidadeRestApi(context.read())),
        ChangeNotifierProvider(
            create: (context) => StatusStore(context.read())),
        ChangeNotifierProvider(
            create: (context) => CategoriadeimoveisStore(context.read())),
        ChangeNotifierProvider(
            create: (context) => NaturezarelacionamentoStore(context.read())),
        ChangeNotifierProvider(
            create: (context) => LeituraaguaunidadeStore(context.read())),
        ChangeNotifierProvider(
            create: (context) => ImovelunidadeStore(context.read())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Panel do Administrador',
        theme: ThemeData(
            scaffoldBackgroundColor: Constants.kSecondaryColor,
            primarySwatch: Colors.blue,
            canvasColor: Constants.kPrimaryColor),
        home: BoasVindas(), //WidgetTree(),
        routes: Map.fromEntries(demos.map((d) => MapEntry(d.route, d.builder))),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HOME: (context) => StatusList(),
        //HOME: (context) => ContactList(),
        CONTACT_FORM: (context) => ContactForm(),
        CONTACT_DETAILS: (context) => ContactDetails(),
        STATUS_FORM: (context) => StatusForm(),
        STATUS_DETAILS: (context) => StatusDetails()
      },
    );
  }
}
*/