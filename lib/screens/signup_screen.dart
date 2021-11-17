import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // acesso de validação ao formulário
  final _formKey = GlobalKey<FormState>();

  // exibir senha
  bool _showPassword = false;

  // controladores para os campos de preenchimento
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Criar Conta',
          style: GoogleFonts.kanit(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add,
                          size: 100, color: Theme.of(context).primaryColor),
                    ]),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    icon: Icon(
                      Icons.account_box_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'Nome (Minimo de 3 letras):',
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 3)
                      return 'Deve conter no minimo 3 letras.';
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
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
                      return 'E-mail inválido! Informe um e-mail válido.';
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
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
                          color: Theme.of(context).primaryColor),
                      onTap: () {
                        setState(() {
                          // jogar o valor contrário para a condição
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  // _showPassword for igual a false torna ele true e senão mantem no false
                  obscureText: _showPassword == false ? true : false,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 8)
                      return 'Senha deve conter mais de 8 caracteres.';
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cepController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor)),
                    icon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'CEP (apenas números):',
                  ),
                  keyboardType: TextInputType.number,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 10)
                      return 'CEP contém 8 digitos.';
                  },
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // verifica a validação dos campos
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'cep': _cepController.text,
                      };

                      model.signUp(
                        userData: userData,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    }
                  },
                  child: Text(
                    'CRIAR CONTA',
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
        },
      ),
    );
  }

  void _onSuccess() {
    //ScaffoldMessenger para exibir barra de informação de conta criada
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Usuário criado com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 5),
      ),
    );
    //após exibição da menssagem direcionar para tela inicial home
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Este usuário já existe!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
