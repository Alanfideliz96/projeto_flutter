import 'Alan.dart';

import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca Amadora',
      home: TelaPrincipal(),

    //ROTAS DE NAVEGAÇÃO
    initialRoute: '/principal',
    routes: {
      '/principal': (context) => TelaPrincipal(),
      '/primeira': (context) => PrimeiraTela(),
      '/segunda': (context) => SegundaTela(),
      '/terceira': (context) => EscreverTela(),
      '/quarta': (context) => AlanTela(),
    },

      //Tema
      theme: ThemeData(
        primaryColor: Colors.blue[400],
        backgroundColor: Colors.blue[200],
        fontFamily: 'Roboto',  //Raleway
        textTheme: TextTheme(
          headline1: TextStyle(fontSize:  22, color: Colors.white),
          headline2: TextStyle(fontSize:  36),
          headline3: TextStyle(fontSize:  18, fontStyle: FontStyle.italic),
        ),

      ),

    )
  );

}

//
// TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  //Atributos para armazenar os valores digitados pelo usuário
  var _txtUser = TextEditingController();
  var _txtPass = TextEditingController();

  //Atributo para identificar unicamente o formulário
  var _formId = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bliblioteca Amadora', 
            style: Theme.of(context).textTheme.headline1
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,

        actions: [

          IconButton(
            icon: Icon(Icons.delete_rounded), 
            onPressed: (){
              
              setState(() {
                _formId.currentState.reset();
                _txtUser.clear();
                _txtPass.clear();
                FocusScope.of(context).unfocus();
              });                

            }
          )

        ],

      ),
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Form(
            key: _formId,
            child: Column(children: [
              Icon(Icons.people_alt, 
                size: 120, 
                color:  Theme.of(context).primaryColor
              ),

              campoTexto('Username', _txtUser),
              campoTexto('PassWord', _txtPass),
              botao('Entrar'),

            ]),
          ),
        ),
      ),
    );
  }


  //
  // CAMPO DE TEXTO para entrada de dados
  //
  Widget campoTexto(rotulo,variavel){

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(

        //variável que receberá o valor contido no campo de texto
        controller: variavel,

        style: Theme.of(context).textTheme.headline2,
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: Theme.of(context).textTheme.headline3,

          hintText: 'Entre com o valor',
          hintStyle: Theme.of(context).textTheme.headline3,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        //validação da entrada de dados
        validator: (value){
          print(value);
          if (double.tryParse(value) == null){
            return 'Entre com um valor válido (User: 123456 | Senha: 123456)';
          }
          else if(double.tryParse(value) != 123456){
              return 'Entre com um valor válido (User: 123456 | Senha: 123456)';
          }
          else{
            return null;  //tudo certo com a conversão para double
          }

        },


      ),

    );

  }

  //
  // BOTÃO
  //
  Widget botao(rotulo){
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        child: Text(rotulo, style: Theme.of(context).textTheme.headline1),
        onPressed: (){
          //print('botão pressionado!');

          //chamar o validador dos campos de texto
          if (_formId.currentState.validate()){

            //O método setState é utilizado todas as vezes que é 
            //necessário alterar o estado do App
            setState(() {
              Navigator.pushNamed(context, '/segunda');
            });

          }

        },        
      ),
    );
  }

  

}

class Mensagem{
  final String titulo;
  final String conteudo;
  Mensagem(this.titulo,this.conteudo);
}

//
// Segunda Tela
//
//

class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {

  var txtTitulo = TextEditingController();
  var txtConteudo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escreva o seu texto aqui')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, 
          children: [
          OutlinedButton(
            child: Text('Próximo'),
            onPressed: () {
              //Navegar para SegundaTela
              Navigator.pushNamed(context, '/segunda');
            },
          ),

          SizedBox(height: 40),
          TextField(
            controller: txtTitulo,
            decoration: InputDecoration(
              labelText: 'Título',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: txtConteudo,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: 'História',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(height: 10),

          //
          // TROCA DE DADOS ENTRE AS TELAS
          //
          OutlinedButton(
            child: Text('enviar'),
            onPressed: () {

              var msg = Mensagem(
                txtTitulo.text,
                txtConteudo.text
              );

              Navigator.pushNamed(
                context, 
                '/terceira',
                arguments: msg
              );
            },
          ),

        ]),
      ),
    );
  }
}



//
// SEGUNDA TELA MENU
//
class SegundaTela extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                OutlinedButton(
                  child: Text('Logout'),
                  onPressed: () {

                    Navigator.pop(context);

                  },
                ),

                OutlinedButton(
                  child: Text('Escrever'),
                  onPressed: () {

                    Navigator.pushNamed(context, '/primeira');

                  },
                  
                ),

                OutlinedButton(
                  child: Text('Criador do desse App Maravilhoso'),
                  onPressed: () {

                    Navigator.pushNamed(context, '/quarta');

                  },
                  
                ),

                OutlinedButton(
                  child: Text('Ver Histórias'),
                  onPressed: () {

                    Navigator.pushNamed(context, '/terceira');

                  },
                  
                ),

              ],
            ),

         

        ]),
      ),
    );
  }
}


//
// Terceira TELA
//
class EscreverTela extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    //Receber o objeto da classe Mensagem
    Mensagem msg = ModalRoute.of(context).settings.arguments;
    if (msg == null){
      msg = Mensagem('','');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),

        //Remover o ícone de Voltar
        automaticallyImplyLeading: false,
        
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                OutlinedButton(
                  child: Text('Voltar'),
                  onPressed: () {

                    Navigator.pop(context);

                  },
                ),

                OutlinedButton(
                  child: Text('Escrever'),
                  onPressed: () {

                    Navigator.pushNamed(context, '/terceira');

                  },
                ),

              ],
            ),

            SizedBox(height: 40),
            Text('Título', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            Text(msg.titulo, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Conteúdo', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            Text(msg.conteudo, style: TextStyle(fontSize: 24)),


        ]),
      ),
    );
  }
}

class AlanTela extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Carros', 
          style: Theme.of(context).textTheme.headline1
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            AlanWidget('Alan','Versão Normal','lib/imagens/alan_normal.jpeg'),
            AlanWidget('Alan','Versão com Barba','lib/imagens/alan_barba.jpeg'),
          ]
          
        ),
      ),
      
    );
  }
}