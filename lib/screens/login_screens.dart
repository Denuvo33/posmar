import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:posmar/controller/auth_controller.dart';
import 'package:posmar/screens/home_screen.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _controller = Get.put(AuthController());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child:
              _isLoading
                  ? CircularProgressIndicator()
                  : Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email harap diisi';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),

                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password harap diisi';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (await _controller.login(
                                emailController.text,
                                passwordController.text,
                              )) {
                                // Login successful
                                debugPrint('Login successful');
                                if (!context.mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => HomeScreen(),
                                  ),
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                // Login failed
                                debugPrint('Login failed');
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: Text('Masuk'),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
