import 'package:flutter/material.dart';
import 'package:newtst/view/homescreen/homescreen.dart';
import 'package:newtst/view/registrationscreen/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
bool check=false;
  bool isLoading = false;

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isLoading = true);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedEmail = prefs.getString('email');
      final String? storedPassword = prefs.getString('password');

      if (emailController.text == storedEmail &&
          passwordController.text == storedPassword) {
        await prefs.setBool('isLoggedIn', true);

        navigateTo(const HomeScreen());
      } else {
        showError('Invalid email or password');
      }

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
                  ,Center(child: Text("Sign in to Your Account",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 90,),
                  
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                      labelText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                        validator: (value) {
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
                      labelText: 'Your password',
                      suffixIcon: Icon(Icons.remove_red_eye_sharp),
                      border: OutlineInputBorder(),
                    ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                         Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: check,
                            onChanged: (value) {
                              check = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Text(
                        "forgot Password",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade500),
                      )
                    ],
                  ),
                  
                      const SizedBox(height: 20),
                      InkWell(onTap:
                         login,
                        child: Container(
                          width: double.infinity,height: 60,
                  decoration: BoxDecoration(color: Colors.blue.shade600,borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Center(child: const Text('sign in',style: TextStyle(color:Colors.white ))),)
                      ),
                      SizedBox(height: 90),
                    
                       Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                            Text("Don't have an account",style: TextStyle(color: Colors.black),),InkWell(onTap: () {
                          navigateTo(const RegistrationScreen());
                            },
                              child: Text("Sign Up",style: TextStyle(color: Colors.blue),))
                          ],)
                    ],
                  ),
                                ),
                              ),
                     ] ),
                )
   )
   )
   );
  }
}