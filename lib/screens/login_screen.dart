import 'package:flutter/material.dart';
import 'package:loja_online/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  // acesso de validação ao formulário
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              // substituição da tela entrar pela tela criar conta.
              // o usuário já vai está logado.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignUpScreen()
                ),
              );
            },
            child: Text('CRIAR CONTA',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(18),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'E-mail:',
              ),
              keyboardType: TextInputType.emailAddress,
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty || !text.contains('@')) return
                'E-mail inválido! Informe um e-mail válido.';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Senha:',
              ),
              obscureText: true,
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty || text.length < 8) return
                'Senha inválida! Informe uma senha válida com mais de 8 caracteres.';
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){}, 
                child: Text('> Esqueceu sua senha?',
                style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              // style: ButtonStyle(backgroundColor: Color.fromARGB(a, r, g, b)),
              onPressed: (){
                // verifica a validação dos campos
                if(_formKey.currentState.validate()) {
                }
              },
              child: Text('ENTRAR',
              style: TextStyle(
                fontSize: 22,
              ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan[700]),
                fixedSize: MaterialStateProperty.all<Size>(Size(50, 50)),
              ),
            ),
          ],
        ), 
      ),
    );
  }
}