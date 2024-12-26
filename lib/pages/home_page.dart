import 'package:bboxxlog/pages/accueil_page.dart';
import 'package:bboxxlog/pages/menu_page.dart';
import 'package:bboxxlog/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  final FocusNode _focusNode = FocusNode();
  final ApiService _apiService = ApiService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      print('Email avant envoi: $email');
      print('Mot de passe avant envoi: $password');

      try {
        final response = await _apiService.login(email, password);
        print('Connexion réussie: $response');
        final token = response['access_token'];
        final utilisateur = response['user']['id'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        await prefs.setString('name', response['user']['name']);
        await prefs.setString('id', utilisateur.toString());
        //final userInfo = await _apiService.getUserinfo();
        _emailController.clear();
        _passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MenuPage(title: '',),
          ),
        );
      } catch (e) {
        print('Connexion échouée: ${e.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur: ${e.toString()}'),
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/image.png'),
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez remplir correctement le champ Adresse e-mail";
                    } else if (!value.contains("@") || !value.contains(".")) {
                      return "Veuillez entrer une adresse e-mail valide";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Adresse e-mail",
                    labelStyle: TextStyle(color: Colors.black),
                    floatingLabelStyle: TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: _passwordController,
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer le bon mot de passe";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mot de passe",
                    labelStyle: const TextStyle(color: Colors.black),
                    floatingLabelStyle: const TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: _focusNode.hasFocus ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Se connecter", style: TextStyle(fontSize: 20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),   
    );
  }
}