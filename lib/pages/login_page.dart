import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool isPaswordHide = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(72, 150, 141, 1),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 400,
            width: 320,
            child: Card(
              shadowColor: Colors.black,
              color: const Color.fromRGBO(114, 174, 170, 1),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Inicia Sesión',
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(214, 214, 214, 1),
                          label: const Text('Correo Electrónico'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(43, 130, 149, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(43, 130, 149, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: passwordController,
                        obscureText: isPaswordHide,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(214, 214, 214, 1),
                          label: const Text('Contraseña'),
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(43, 130, 149, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(43, 130, 149, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffix: GestureDetector(
                            onTap: hidePassword,
                            child: Icon(
                              isPaswordHide
                                  ? Icons.lock_open_rounded
                                  : Icons.lock,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      onPressed: logIn,
                      color: Colors.orange,
                      elevation: 5,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hidePassword() {
    setState(() {
      isPaswordHide = !isPaswordHide;
    });
  }

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
