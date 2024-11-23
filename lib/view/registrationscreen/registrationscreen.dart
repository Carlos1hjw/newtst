import 'package:flutter/material.dart';
import 'package:newtst/view/loginscreen/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != conformPasswordController.text) {
        showError('Passwords do not match');
        return;
      }

      setState(() => isLoading = true);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('isLoggedIn', false);

      navigateTo(const LoginScreen());
      setState(() => isLoading = false);
    }
  }

  void navigateTo(Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Center(child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                IconButton(onPressed: () {
                  
                                }, icon: Icon(Icons.arrow_back))
                                ,Center(child: Text("Sign Up for Free",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                                SizedBox(height: 90,),
                  
                  TextFormField(
                    controller: emailController,
                      decoration: const InputDecoration(
                    labelText: 'enter email',
                    border: OutlineInputBorder(),
                  ),                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(),
                  ),                      obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: conformPasswordController,
                        decoration: const InputDecoration(
                    labelText: 'Enter Conform Password',
                    border: OutlineInputBorder(),
                  ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                     InkWell(onTap: () {register();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                     },
                       child: Container(width: double.infinity,height: 60,
                                     decoration: BoxDecoration(color: Colors.blue.shade600,borderRadius: BorderRadius.all(Radius.circular(20))),
                                     child: Center(child: const Text("Sign Up",style: TextStyle(color:Colors.white ),))),
                     ),
              SizedBox(height: 90,),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Already have an account",style: TextStyle(color: Colors.black),),InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));  },
              child: Text("Sign in",style: TextStyle(color: Colors.blue),))
          ],),
        )
                    ],
                  ),
                                ),
                              ),
                     ] ),
                )))  );
  }
}