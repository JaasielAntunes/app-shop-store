import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  // acesso de validação ao formulário
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(18),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Nome Completo:',
              ),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty) return
                'Nome não pode ser vazio!';
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'CPF (apenas números):',
              ),
              keyboardType: TextInputType.number,
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty || text.length < 11 || text.length > 11) return
                'CPF inválido! Informe um CPF válido.';
              },
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Endereço:',
              ),
              // ignore: missing_return
              validator: (text){
                if(text.isEmpty) return
                'Endereço não pode ser vazio!';
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){
                // verifica a validação dos campos
                if(_formKey.currentState.validate()) {
                }
              },
              child: Text('CRIAR CONTA',
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