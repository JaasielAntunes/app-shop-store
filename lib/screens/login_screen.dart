import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // acesso de validação ao formulário
  final _formKey = GlobalKey<FormState>();

  // exibir senha
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Entrar',
          style: GoogleFonts.kanit(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // substituição da tela entrar pela tela criar conta.
              // o usuário já vai está logado.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Text(
              'CRIAR CONTA',
              style: GoogleFonts.kanit(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      // forma de acessar o modelo e modificar estados
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        // se o modelo do usuário estiver carregando algo retorna o CircularProgressIndicator
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        // caso contrário retorna o formulário
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle,
                        size: 100, color: Theme.of(context).primaryColor)
                  ]),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  )),
                  icon: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'E-mail:',
                ),
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty || !text.contains('@'))
                    return 'E-mail inválido! Informe um e-mail válido!';
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  )),
                  icon: Icon(
                    Icons.vpn_key,
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: 'Senha:',
                  suffixIcon: GestureDetector(
                    child: Icon(
                      _showPassword == false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      setState(() {
                        // jogar o valor contrário para a condição
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: _showPassword == false ? true : false,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty || text.length < 7)
                    return 'Senha inválida! Informe uma senha válida!';
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Informe seu email para redefinição de senha e clique novamente em > Esqueceu sua senha?'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 5),
                        ),
                      );
                    else {
                      model.recoverPass(_emailController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Confira seu email!'),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 5),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '> Esqueceu sua senha?',
                    style: GoogleFonts.signikaNegative(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // verifica a validação dos campos
                  if (_formKey.currentState.validate()) {}
                  model.signIn(
                    email: _emailController.text,
                    pass: _passController.text,
                    onSuccess: _onSuccess,
                    onFail: _onFail,
                  );
                },
                child: Text(
                  'ENTRAR',
                  style: GoogleFonts.kanit(
                    fontSize: 22,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan[700]),
                  fixedSize: MaterialStateProperty.all<Size>(Size(50, 50)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Falha ao realizar Login'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
