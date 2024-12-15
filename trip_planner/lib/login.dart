import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trip_planner/home_screen.dart';


class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                )),
              Padding(padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await firebaseSignIn(context);
                },
                child: isLoading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.white),
                        ) : const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Bogle',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> firebaseSignIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String message = '';
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Future.delayed(const Duration(seconds: 3), () {
          if(mounted) {
            setState(() {
              isLoading = false;
            });
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(title: 'Home',),
              ),
            );
          }
        });
      } on FirebaseAuthException catch (e) {
          setState(() {
            isLoading = false;
          });
          if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
            message = 'Invalid Login Credentials.';
          } else {
            message = e.message.toString();
          }
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "Failed: $e",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        }
      }
  }

}