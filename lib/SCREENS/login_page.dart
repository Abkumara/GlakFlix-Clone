import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:glak_flix_app/SCREENS/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  bool signBool = true;

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    retypePasswordController.clear();
  }

  void createUserWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (retypePasswordController.text != passwordController.text) {
        print('Password does not match');
        return;
      }

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print(credential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Signup in ${emailController.text}'),
          duration: Duration(seconds: 5),
        ));
        clearTextFields();
        setState(() {
          signBool = true;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        print(credential);
        print(credential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign in ${emailController.text}'),
          duration: Duration(seconds: 5),
        ));
        clearTextFields();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'GlakFlix',
          style: TextStyle(
              color: Colors.orange[800],
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration(
                      fillColor: Colors.grey[500],
                      filled: true,
                      label: const Text(
                        'Email',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2))),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Email';
                    } else if (!value.contains('@')) {
                      return 'Please enter correct email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[500],
                    filled: true,
                    label: const Text(
                      'Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Password';
                    } else if (value.length < 8) {
                      return 'Please enter Strong Passord';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!signBool)
                  TextFormField(
                    obscureText: true,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    decoration: InputDecoration(
                      fillColor: Colors.grey[500],
                      filled: true,
                      label: const Text(
                        'Re-type Password',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                    ),
                    controller: retypePasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Password';
                      } else if (value != passwordController.text) {
                        return 'Not macthing Passwords';
                      }
                      return null;
                    },
                  ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 10)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          shape: MaterialStatePropertyAll(
                            BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          )),
                      onPressed: (signBool)
                          ? signInWithEmailAndPassword
                          : createUserWithEmailAndPassword,
                      child: Text(
                        (signBool) ? 'Sign in' : 'Sign Up',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Need help ?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (signBool)
                          ? 'New to GlakFlix?'
                          : 'Already have an account?',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            signBool = !signBool;
                          });
                        },
                        child: Text(
                          (signBool) ? 'Sign Up Now' : 'Sign In Now',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Sign in is protected by Google',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  'reCAPTCHA to ensure you\'re not a bot',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  'Learn more.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
