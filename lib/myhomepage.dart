import 'package:flutter/material.dart';
import 'package:searchcepflutterbloc/endereco_model.dart';
import 'package:searchcepflutterbloc/myhomepage_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomePageBloc bloc = MyHomePageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                bloc.input.add(value);
              },
              decoration: InputDecoration(
                  hintText: "Digite seu CEP", border: OutlineInputBorder()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: StreamBuilder<EnderecoModel>(
                    stream: bloc.output,
                    initialData: EnderecoModel(
                      logradouro: "Não encontrado",
                      complemento: "Não encontrado",
                      bairro: "Não encontrado",
                      localidade: "Não encontrado",
                      uf: "Não encontrado",
                      unidade: "Não encontrado",
                      ibge: "Não encontrado",
                      gia: "Não encontrado",
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          "Erro na pesquisa",
                          style: TextStyle(color: Colors.red),
                        );
                      }

                      if (!snapshot.hasData) {
                        // return Text('Buscando...');
                        return CircularProgressIndicator();
                      }

                      if (snapshot.data.cep == null) {
                        return Text('Nenhuma informação encontrada');
                      }

                      // EnderecoModel model = snapshot.data;
                      EnderecoModel model = snapshot.data;
                      // return Text("Bairro: ${model.bairro}");
                      return Column(
                        children: <Widget>[
                          Text("Logradouro: ${model.logradouro}"),
                          Text("Complemento: ${model.complemento}"),
                          Text("Bairro: ${model.bairro}"),
                          Text("Localidade: ${model.localidade}"),
                          Text("Estado: ${model.uf}"),
                          Text("Unidade: ${model.unidade}"),
                          Text("IBGE: ${model.ibge}"),
                          model.gia != "" ? Text("GIA: ${model.gia}"):
                          Text("")
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
