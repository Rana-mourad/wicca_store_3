import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wicca_store_3/provider/app_authprovider.dart';
import 'package:wicca_store_3/views/signinup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<AppAuthProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AppAuthProvider>(
            builder: (ctx, appAuthProvider, _) {
              return Form(
                key: appAuthProvider.formKey,
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'LogIn',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF515C6F),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: appAuthProvider.emailController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Email is required';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Enter a valid Email';
                            } else {
                              if (!value.split('@').last.contains('gmail')) {
                                return 'Enter a valid Gmail';
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            suffixIcon: const Icon(
                              Icons.mail,
                              color: Color(0xFF727C8E),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Color.fromARGB(255, 232, 232, 232),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: appAuthProvider.obscureText,
                          controller: appAuthProvider.passwordController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Password is required';
                            }
                            if (value.length < 8) {
                              return 'Password length must be 8';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                appAuthProvider.toggleObscure();
                              },
                              child: appAuthProvider.obscureText
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Color(0xFF727C8E),
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Color(0xFF727C8E),
                                    ),
                            ),
                            isDense: true,
                            filled: true,
                            fillColor: Color.fromARGB(255, 232, 232, 232),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (appAuthProvider.formKey.currentState
                                    ?.validate() ??
                                false) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.loading,
                                title: 'Logging In',
                                text: 'Please wait...',
                              );
                              await Future.delayed(const Duration(seconds: 2));
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Login successful!',
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 60),
                            primary: Color(0xFF515C6F),
                          ),
                          child: const Text('Login'),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Swipe right to create a new account.",
                            style: TextStyle(
                              color: Color(0xFF515C6F),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
