import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wicca_store_3/provider/app_authprovider.dart';
import 'package:wicca_store_3/views/Auth.dart';
import 'package:wicca_store_3/views/homepage.dart';
import 'package:wicca_store_3/views/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController userController;
  late TextEditingController passwordController;
  bool obscureText = true;
  bool isChecked = false;
  late AppAuthProvider signUpProvider;

  @override
  void initState() {
    signUpProvider = AppAuthProvider();
    emailController = TextEditingController();
    userController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    signUpProvider.dispose();
    emailController.dispose();
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: signUpProvider,
            child: Consumer<AppAuthProvider>(
              builder: (context, signUpProvider, _) {
                return Form(
                  key: signUpProvider.formKey,
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Text(
                                ' | ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AuthPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Sign Up',
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
                            controller: signUpProvider.emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: const Icon(
                                Icons.mail,
                                color: Color(0xFF727C8E),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF515C6F),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Color.fromARGB(255, 230, 233, 240),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: userController,
                            decoration: InputDecoration(
                              labelText: 'User',
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Color(0xFF727C8E),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF515C6F),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Color.fromARGB(255, 230, 233, 240),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: signUpProvider.obscureText,
                            controller: signUpProvider.passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: InkWell(
                                onTap: () {
                                  signUpProvider.toggleObscure();
                                },
                                child: signUpProvider.obscureText
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Color(0xFF727C8E),
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Color(0xFF727C8E),
                                      ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF515C6F),
                              ),
                              isDense: true,
                              filled: true,
                              fillColor: Color.fromARGB(255, 230, 233, 240),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  false;
                                },
                                activeColor: Color(0xFF6969FF),
                              ),
                              Text(
                                'I agree to receive offers',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF515C6F),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await signUpProvider.signUp(context);
                              await Future.delayed(const Duration(seconds: 2));
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Signup successful!',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFF6969),
                              minimumSize: const Size(300, 60),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.chevron_right, color: Colors.white),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'By creating an account, you agree to our Terms of Service and Privacy Policy',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF515C6F),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
      ),
    );
  }
}
