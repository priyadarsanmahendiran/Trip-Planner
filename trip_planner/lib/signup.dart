import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trip_planner/home_screen.dart';

class SignUp extends StatefulWidget {
  
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
              const Center(child: Text("Sign Up")),
              SizedBox(
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
              SizedBox(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await firebaseSignUp(context);
                },
                child: isLoading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                              strokeWidth: 3, color: Colors.white),
                      ) : const Text('Sign Up'),
              )
            ],
          ),
        ),
      ),
    );
  }


Future<void> firebaseSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String message = '';
      setState(() {
        isLoading = true;
      }); 
      try {
        await _firebaseAuth.createUserWithEmailAndPassword( // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isLoading = false;
          });
          if(mounted) {
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
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'An account already exists with that email.';
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