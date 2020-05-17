import 'dart:async';

import 'package:dio/dio.dart';
import 'package:searchcepflutterbloc/endereco_model.dart';

class MyHomePageBloc {
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream<EnderecoModel> get output => _streamController.stream
      .where((cep) => cep.length == 8)
      .asyncMap((cep) => _searchCep(cep));

  String url(String cep) => "https://viacep.com.br/ws/$cep/json/";

  Future<EnderecoModel> _searchCep(String cep) async {
    Response response = await Dio().get(url(cep));
    return EnderecoModel.fromJson(response.data);
  }
}
